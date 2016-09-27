//
//  LDDataBaseManager.h
//  DataPermanent
//
//  Created by fuchun on 16/9/26.
//  Copyright © 2016年 ylx. All rights reserved.
//

#import <Foundation/Foundation.h>
@class userActionListModel;

@interface LDDataBaseManager : NSObject

+ (instancetype)shareManager;
/// 插入一条数据
- (void)insetDataWithActionListModel:(userActionListModel *)actionListModel;
/// 删除所有数据
-(void)deleteAllData;
/// 获取要发送的数据
- (NSArray *)getActionlistData;


//- (NSArray *)listWithModelClass:(Class)modelClass range:(NSRange)range;
//- (BOOL)isExistWithId:(NSString *)idStr;

@end

