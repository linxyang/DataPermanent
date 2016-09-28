//
//  BaseViewController.m
//  DataPermanent
//
//  Created by Yanglixia on 16/9/29.
//  Copyright © 2016年 ylx. All rights reserved.
//

#import "BaseViewController.h"
#import "userActionListModel.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize enterModel = _enterModel;

#pragma mark - 生命周期
// 基类记录好进入与离开时间以及页面名称等用户行为数据
- (userActionListModel *)enterModel
{
    if (!_enterModel) {
        _enterModel = [[userActionListModel alloc] init];
        _enterModel.event = @"enter_page";
    }
    return _enterModel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 页面进入时间
    NSDate *date =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:SSS";
    
    NSString *timeIn = [formatter stringFromDate:date];
    self.enterModel.timeIn = timeIn;
    // 当前页面名称
    self.enterModel.page = NSStringFromClass([self class]);
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // 页面离开时间
    NSDate *date =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:SSS";
    
    NSString *timeOut = [formatter stringFromDate:date];
    self.enterModel.timeOut = timeOut;
    
}

@end
