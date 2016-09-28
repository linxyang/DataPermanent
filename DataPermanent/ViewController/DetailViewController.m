//
//  DetailViewController.m
//  DataPermanent
//
//  Created by Yanglixia on 16/9/27.
//  Copyright © 2016年 ylx. All rights reserved.
//

#import "DetailViewController.h"
#import "LDDataBaseManager.h"
#import "userActionListModel.h"

@interface DetailViewController ()
/** 点击发布的用户行为模型 */
@property (nonatomic, strong) userActionListModel *clickModel;
@end

@implementation DetailViewController

- (userActionListModel *)clickModel
{
    if (!_clickModel) {
        _clickModel = [[userActionListModel alloc] init];
        _clickModel.event = @"click_public";
    }
    return _clickModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    btn.frame = CGRectMake(100, 100, 100, 40);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
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

- (void)btnClick
{
    NSDate *date =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    self.clickModel.operationTime = [formatter stringFromDate:date];// 点击时间
    self.clickModel.timeIn = self.enterModel.timeIn;//按钮所在页面进入时间
    self.clickModel.page = self.enterModel.page;//页面名称
    [[LDDataBaseManager shareManager] insetDataWithActionListModel:self.clickModel];
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
