//
//  LDDataPermanentManager.m
//  DataPermanent
//
//  Created by Yanglixia on 16/9/26.
//  Copyright © 2016年 ylx. All rights reserved.
//  数据埋点工具类

#import "LDDataPermanentManager.h"
#import "LDNetworkManager.h"

@interface LDDataPermanentManager()
/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;
/** 每隔几分钟发送一次 */
@property (nonatomic, assign) NSUInteger minuteCount;
@end

@implementation LDDataPermanentManager

+ (instancetype)shareManager
{
    static LDDataPermanentManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self timer];
    }
    return self;
}

- (NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeTick) userInfo:nil repeats:YES];
        [_timer setFireDate:[NSDate distantFuture]];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (void)timeTick
{
    static NSUInteger timeCount = 0;

    if (timeCount % (self.minuteCount*60) == 0) { // 5分钟发送一次
        NSDictionary *paras = [self dataPrepare];
        [self sendDateWithParas:paras];
    }
    timeCount ++;
}

- (void)sendUserActionDataToServerForMin:(NSUInteger)minutes
{
    self.minuteCount = minutes;
    [self.timer setFireDate:[NSDate date]];
}

- (void)sendDateWithParas:(NSDictionary *)paras
{
    [[LDNetworkManager shareManager] postWithUrl:LDUserActionUrl params:paras success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
//        [[LDDataBaseManager shareManager] deleteAllData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];
    
}

- (NSDictionary *)dataPrepare
{
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    // 用户id
    [paras setObject:userId forKey:@"userId"];
    // 用户名
    [paras setObject:nickName forKey:@"nickName"];
    // 渠道名称，iOS就苹果商店
    [paras setObject:@"AppStore" forKey:@"channelName"];
    // 渠道别名，iOS就苹果商店
    [paras setObject:@"AppStore" forKey:@"channelAlias"];
    // 版本号
    [paras setObject:LDVERSIONNUM forKey:@"versionNum"];
    // 手机uuid
    [paras setObject:[MyTool getUUIDString] forKey:@"mac"];

    // 网络状态
    NSString *network = @"";
    switch ([LDNetworkManager shareManager].networkStatus) {
            
        case AFNetworkReachabilityStatusReachableViaWiFi:
            network = @"WIFI网络";
            break;
           
        case AFNetworkReachabilityStatusReachableViaWWAN:
            network = @"2G/3G/4G网络";
            break;
        case AFNetworkReachabilityStatusUnknown:
            network = @"未知网络";
            break;
    
        default:
            break;
    }
    
    [paras setObject:network forKey:@"network"];
    // 设备名称
    [paras setObject:[MyTool getDeviceName] forKey:@"device"];
    
    // 省名称
    [paras setObject:@"广东省" forKey:@"provinceName"];
    
    // 市名称
    [paras setObject:@"深圳市" forKey:@"cityName"];
    
    // 品牌商id
    [paras setObject:@"14" forKey:@"partnerId"];
    
    // 用户平台 0:iOS 1:安卓
    [paras setObject:@"0" forKey:@"platform"];
    
    // 手机操作系统
    [paras setObject:[MyTool getSysVersion] forKey:@"os"];
    
    // 是否有EMS设备
    [paras setObject:@"1" forKey:@"emsStatus"];
    
    // 用户行为数据，从dataBase中取
    NSArray *userListArray = [[LDDataBaseManager shareManager] getActionlistData];
    
    // 要转成json传给后台
    NSData *data = [NSJSONSerialization dataWithJSONObject:userListArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [paras setObject:jsonString forKey:@"actionList"];
    
    
    return paras;
}



@end

