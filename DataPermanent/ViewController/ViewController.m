//
//  ViewController.m
//  DataPermanent
//
//  Created by Yanglixia on 16/9/26.
//  Copyright © 2016年 ylx. All rights reserved.
//

#import "ViewController.h"
#import "LDDataPermanentManager.h"
#import "LDDataBaseManager.h"
#import "userActionListModel.h"
#import "DetailViewController.h"


@interface ViewController ()
/** 点击跳转的用户行为模型 */
@property (nonatomic, strong) userActionListModel *clickModel;
@end

@implementation ViewController


- (userActionListModel *)clickModel
{
    if (!_clickModel) {
        _clickModel = [[userActionListModel alloc] init];
        _clickModel.event = @"watch_video";
    }
    return _clickModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"首页";
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    // 插入数据
    [[LDDataBaseManager shareManager] insetDataWithActionListModel:self.enterModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 封装的工具类测试ok
//    [[LDNetworkManager shareManager] getWithUrl:LDHardwareListUrl params:nil success:^(NSURLSessionDataTask *task, NSDictionary  *responseObject) {
//        NSLog(@"%@",responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@",error.description);
//    }];
    
    
    [[LDDataPermanentManager shareManager] dataPrepare];
    

}



- (IBAction)sendData:(UIButton *)sender {
    
    // 拿到要发送的数据
    NSDictionary *paras = [[LDDataPermanentManager shareManager] dataPrepare];
    // 发送
    [[LDDataPermanentManager shareManager] sendDateWithParas:paras];
    
}

- (IBAction)clearDataBase:(UIButton *)sender {
    
    // 清除表中所有数据
    [[LDDataBaseManager shareManager] deleteAllData];
    
}

// 打开详情控制器(对点击事件埋点)
- (IBAction)openDetailVc:(UIButton *)sender {
    
    NSDate *date =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    self.clickModel.operationTime = [formatter stringFromDate:date];// 点击时间
    self.clickModel.timeIn = self.enterModel.timeIn;//按钮所在页面进入时间
    self.clickModel.page = self.enterModel.page;//页面名称
    [[LDDataBaseManager shareManager] insetDataWithActionListModel:self.clickModel];
    
    DetailViewController *detaiVc = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:detaiVc animated:YES];
}


@end
