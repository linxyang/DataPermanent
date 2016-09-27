// LDNetworkManager.h
//
//  Created by fuchun on 16/9/26.
//  Copyright © 2016年 ylx. All rights reserved.
//

#import "LDNetworkManager.h"
#import "LDUploadFile.h"
#import "LDAPIConst.h"
#import "MyTool.h"
#import "StrUtil.h"

#define kMSScreenWith CGRectGetWidth([UIScreen mainScreen].bounds)
#define kMSScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

#define kMSScreenSize [NSString stringWithFormat:@"%dx%d",(int)kMSScreenWith,(int)kMSScreenHeight]

@interface LDNetworkManager()

@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;

@end

@implementation LDNetworkManager

+ (instancetype)shareManager {
    static LDNetworkManager *_shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _shareManager = [[self alloc] init];
        _shareManager.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:LDAPIBaseUrl]];
        _shareManager.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _shareManager.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript", nil];
        
        _shareManager.sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
        
        [requestSerializer setValue:[NSString stringWithFormat:@"%@",LDVERSIONNUM] forHTTPHeaderField:@"versionNum"];
        
        [requestSerializer setValue:kMSScreenSize forHTTPHeaderField:@"screenSize"];
        [requestSerializer setValue:@"0" forHTTPHeaderField:@"platform"];
        [requestSerializer setValue:[MyTool getUUIDString] forHTTPHeaderField:@"mac"];//MyTool中已对uuiid加密
        [requestSerializer setValue:[MyTool deviceVersion] forHTTPHeaderField:@"deviceName"];
        [requestSerializer setValue:[MyTool getSysVersion] forHTTPHeaderField:@"os"];
        [requestSerializer setValue:[MyTool getDeviceModel] forHTTPHeaderField:@"deviceModel"];
        
        _shareManager.sessionManager.requestSerializer = requestSerializer;
    });
    
    return _shareManager;
}
- (NSString *)baseURLString
{
    return self.sessionManager.baseURL.absoluteString;
}

- (void)setAuthToken:(NSString *)authToken
{
    _authToken = authToken;
    [self.sessionManager.requestSerializer setValue:authToken forHTTPHeaderField:@"token"];
}

#pragma mark - GET请求
/// GET
- (NSURLSessionDataTask *)getWithUrl:(NSString *)Url params:(NSDictionary *)params success:(successBlock)successCallBack failure:(failureBlock)failureCallBack
{
    // 成功回调
    void (^ success)(NSURLSessionDataTask * task, id responseObject) = ^(NSURLSessionDataTask *task, id responseObject)
    {
        successCallBack(task,responseObject);
    };
    // 失败回调
    void (^ failure)(NSURLSessionDataTask * task, NSError *error) = ^(NSURLSessionDataTask * task, NSError *error)
    {
        if(!(error.code == NSURLErrorCancelled && [error.domain isEqualToString:NSURLErrorDomain]))
        {
            if(error.code != NSURLErrorTimedOut)//非请求超时
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 屏幕提示请求出错
//                  [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                });
            }
        }
        failureCallBack(task,error);
    };

    NSString *urlString;
    if([Url hasPrefix:@"http://"])//智能拼接baseUrl
    {
        urlString = Url;
    }
    else
    {
        urlString = LDAPIBaseUrl;
        NSURL *baseURLString = [NSURL URLWithString:urlString];
        urlString = [[NSURL URLWithString:Url relativeToURL:baseURLString] absoluteString];
    }

    // 请求
    NSURLSessionDataTask *task = [self.sessionManager GET:urlString parameters:params progress:nil success:success failure:failure];
    return task;

}

#pragma mark - POST请求
/// POST请求
- (NSURLSessionDataTask *)postWithUrl:(NSString *)Url
                               params:(NSDictionary *)params
                              success:(successBlock)successCallBack
                              failure:(failureBlock)failureCallBack
{
    
    void (^ success)(NSURLSessionDataTask * task, id responseObject) = ^(NSURLSessionDataTask *task, id responseObject)
    {
        successCallBack(task,responseObject);
    };
    
    void (^ failure)(NSURLSessionDataTask * task, NSError *error) = ^(NSURLSessionDataTask * task, NSError *error)
    {
        if(!(error.code == NSURLErrorCancelled && [error.domain isEqualToString:NSURLErrorDomain]))
        {
            if(error.code != NSURLErrorTimedOut)//非请求超时
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 屏幕提示请求出错
//                  [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                });
            }
        }
        failureCallBack(task,error);
    };
    
    NSString *urlString;
    if([Url hasPrefix:@"http://"])//智能拼接baseUrl
    {
        urlString = Url;
    }
    else
    {
        urlString = LDAPIBaseUrl;
        NSURL *baseURLString = [NSURL URLWithString:urlString];
        urlString = [[NSURL URLWithString:Url relativeToURL:baseURLString] absoluteString];
    }
    
    // 请求
    NSURLSessionDataTask *task = [self.sessionManager POST:urlString parameters:params progress:nil success:success failure:failure];
    return task;
}

#pragma mark - 上传图片文件
/// POST上传图片文件
- (NSURLSessionDataTask *)postWithUrl:(NSString *)Url params:(NSDictionary *)params imageFileDatas:(NSDictionary *)fileDatas success:(successBlock)successCallBack failure:(failureBlock)failureCallBack
{
    void (^ builDFormData)(id <AFMultipartFormData> formData);
    if(fileDatas)
    {
        builDFormData = ^(id<AFMultipartFormData> formData)
        {
            for(NSString *key in fileDatas.keyEnumerator)
            {
                NSArray *dataArray = fileDatas[key];
                for(NSData *data in dataArray)
                {
                    [formData appendPartWithFileData:data
                                                name:key
                                            fileName:[NSString stringWithFormat:@"%@.jpg",key]
                                            mimeType:@"image/jpeg"];
                }
            }
        };
    }
    else
    {
        builDFormData = nil;
    }
    
    NSURLSessionDataTask *task = [self postWithUrl:Url
                                            params:params
                         constructingBodyWithBlock:builDFormData
                                           success:successCallBack
                                           failure:failureCallBack];
    
    return task;
}

#pragma mark - 上传文件
/// POST上传文件
- (NSURLSessionDataTask *)postWithUrl:(NSString *)Url params:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block success:(successBlock)successCallBack failure:(failureBlock)failureCallBack
{
    void (^ success)(NSURLSessionDataTask * task, id responseObject) = ^(NSURLSessionDataTask *task, id responseObject)
    {
        successCallBack(task,responseObject);
    };
    
    void (^ failure)(NSURLSessionDataTask * task, NSError *error) = ^(NSURLSessionDataTask * task, NSError *error)
    {
        if(!(error.code == NSURLErrorCancelled && [error.domain isEqualToString:NSURLErrorDomain]))
        {
            if(error.code != NSURLErrorTimedOut)//非请求超时
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 屏幕提示请求出错
//                  [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                });
            }
        }
        failureCallBack(task,error);
    };
    
    NSString *urlString;
    if([Url hasPrefix:@"http://"])//智能拼接baseUrl
    {
        urlString = Url;
    }
    else
    {
        urlString = LDAPIBaseUrl;
        NSURL *baseURLString = [NSURL URLWithString:urlString];
        urlString = [[NSURL URLWithString:Url relativeToURL:baseURLString] absoluteString];
    }
    
    NSURLSessionDataTask *task;
    
    if(block)//上传
    {
        task = [self.sessionManager POST:urlString parameters:params constructingBodyWithBlock:block progress:nil success:success failure:failure];
    }
    else
    {
        task = [self.sessionManager POST:urlString parameters:params progress:nil success:success failure:failure];
    }
    return task;
    
}


/**
 监控网络状态
 */
static BOOL isNetworkUse;
- (BOOL)checkNetworkStatus {
    
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown) {
            isNetworkUse = YES;
        } else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            isNetworkUse = YES;
        } else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            isNetworkUse = YES;
        } else if (status == AFNetworkReachabilityStatusNotReachable){
            // 网络异常操作
            isNetworkUse = NO;
            NSLog(@"网络异常,请检查网络是否可用！");
        }
        _networkStatus = status;
    }];
    [reachabilityManager startMonitoring];
    return isNetworkUse;
}



@end
