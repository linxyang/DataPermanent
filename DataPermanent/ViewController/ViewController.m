//
//  ViewController.m
//  DataPermanent
//
//  Created by fuchun on 16/9/26.
//  Copyright © 2016年 ylx. All rights reserved.
//

#import "ViewController.h"
#import "LDDataPermanentManager.h"
#import "LDDataBaseManager.h"
#import "userActionListModel.h"
#import "DetailViewController.h"


@interface ViewController ()
/** 进入页面用户行为模型 */
@property (nonatomic, strong) userActionListModel *enterModel;
/** 点击跳转的用户行为模型 */
@property (nonatomic, strong) userActionListModel *clickModel;
@end

@implementation ViewController

- (userActionListModel *)enterModel
{
    if (!_enterModel) {
        _enterModel = [[userActionListModel alloc] init];
        _enterModel.page = NSStringFromClass([self class]);
        _enterModel.event = @"enter_page";
    }
    return _enterModel;
}

- (userActionListModel *)clickModel
{
    if (!_clickModel) {
        _clickModel = [[userActionListModel alloc] init];
        _clickModel.page = NSStringFromClass([self class]);
        _clickModel.event = @"watch_video";
    }
    return _clickModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"首页";
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSDate *date =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    formatter.dateFormat = @"yyyy-MM-dd hh:mm:ss.SSS";
    
    NSString *timeIn = [formatter stringFromDate:date];
    self.enterModel.timeIn = timeIn;
    
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSDate *date =[NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd hh:mm:ss.SSS";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    self.enterModel.timeOut = [formatter stringFromDate:date];
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



- (IBAction)insetData:(UIButton *)sender {
    
    NSDictionary *paras = [[LDDataPermanentManager shareManager] dataPrepare];
    
    [[LDDataPermanentManager shareManager] sendDateWithParas:paras];
    
}

- (IBAction)clearDataBase:(UIButton *)sender {
    
    [[LDDataBaseManager shareManager] deleteAllData];
    
}

- (IBAction)openDetailVc:(UIButton *)sender {
    
    NSDate *date =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd hh:mm:ss.SSS";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    self.clickModel.operationTime = [formatter stringFromDate:date];// 点击时间
    [[LDDataBaseManager shareManager] insetDataWithActionListModel:self.clickModel];
    
    DetailViewController *detaiVc = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:detaiVc animated:YES];
}


@end
