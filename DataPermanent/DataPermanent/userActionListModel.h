//
//  userActionListModel.h
//  DataPermanent
//
//  Created by Yanglixia on 16/9/27.
//  Copyright © 2016年 ylx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userActionListModel : NSObject
/** 当前一条数据的序号 */
@property (nonatomic, assign) NSInteger index;// 本地记录序号，可扩展查询哪些数据
/** 当前页面名称 */
@property (nonatomic, copy) NSString *page;
/** 事件 */
@property (nonatomic, copy) NSString *event;
/** 事件详情 */
@property (nonatomic, copy) NSString *eventDetail;
/** 广告Id */
@property (nonatomic, assign) NSInteger adId;
/** 帖子Id */
@property (nonatomic, assign) NSInteger topicId;
/** 计划Id */
@property (nonatomic, assign) NSInteger planId;
/** 商品Id */
@property (nonatomic, assign) NSInteger productId;
/** 闪屏Id */
@property (nonatomic, assign) NSInteger shanpingId;
/** 订单Id */
@property (nonatomic, assign) NSInteger productOrderId;
/** 操作时间(点击事件) */
@property (nonatomic, copy) NSString *operationTime;// @"2016-09-27 00:53:43:246" 时间格式,精确到毫秒
/** 页面进入时间 */
@property (nonatomic, copy) NSString *timeIn;
/** 页面离开时间 */
@property (nonatomic, copy) NSString *timeOut;


@end
