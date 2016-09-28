//
//  BaseViewController.h
//  DataPermanent
//
//  Created by Yanglixia on 16/9/29.
//  Copyright © 2016年 ylx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class userActionListModel;

@interface BaseViewController : UIViewController
/** 进入页面用户行为模型 */
@property (nonatomic, strong,readonly) userActionListModel *enterModel;
@end
