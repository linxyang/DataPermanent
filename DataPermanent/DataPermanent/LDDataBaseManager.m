//
//  DataBaseTool.m
//  DataPermanent
//
//  Created by fuchun on 16/9/26.
//  Copyright © 2016年 ylx. All rights reserved.
//

#import "LDDataBaseManager.h"
#import "userActionListModel.h"
#import <FMDatabase.h>
#import "UserPref.h"


@interface LDDataBaseManager()
{
    FMDatabase *_db;
    NSUInteger _index;
}

@end

@implementation LDDataBaseManager
//单列
+ (instancetype)shareManager
{
    static LDDataBaseManager *dataBase = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataBase = [[LDDataBaseManager alloc] init];
    });
    
    return dataBase;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *index = [UserPref getUserPref:@"userActionList"];
        _index = index.integerValue;
        NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/UserActionData.sqlite",NSHomeDirectory()];
        _db = [FMDatabase databaseWithPath:path];
        [_db open];
        BOOL result = [_db executeUpdate:
                       @"create table if not exists userActionData_table \
                       (id integer primary key autoincrement, \
                       indexNum integer,\
                       page  text,\
                       event text,\
                       eventDetail text,\
                       adId integer,\
                       topicId integer,\
                       planId integer,\
                       productId integer,\
                       shanpingId integer,\
                       productOrderId integer,\
                       operationTime integer,\
                       timeIn text,\
                       timeOut text,\
                       reserve1 text,\
                       reserve2 text)"];
        if (result) {
            NSLog(@"创建表成功:UserActionData.sqlite");
        }
        [_db close];
        
    }
    return self;
}

// 插入一条数据库
- (void)insetDataWithActionListModel:(userActionListModel *)actionListModel {
    
    BOOL flag = [_db open];
    if (!flag) {
        return;
    }
    
    // FMDB中可以用?当作占位符, 但是需要注意: 如果使用问号占位符, 以后只能给占位符传递"对象"
    // NSString *sql = @"INSERT INTO t_student(age, score, name) VALUES (?,?,?)";
    NSString *sql =[NSString stringWithFormat:
                    @"INSERT INTO userActionData_table ('%@','%@','%@','%@','%@','%@','%@','%@','%@', '%@','%@','%@','%@') VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)",
                    @"indexNum",
                    @"page",
                    @"event",
                    @"eventDetail",
                    @"adId",
                    @"topicId",
                    @"planId",
                    @"productId",
                    @"shanpingId",
                    @"productOrderId",
                    @"operationTime",
                    @"timeIn",
                    @"timeOut"];
    BOOL isSuccess = [_db executeUpdate:sql,
                      @(_index),
                      actionListModel.page==nil ? @"":actionListModel.page,
                      actionListModel.event==nil ? @"":actionListModel.event,
                      actionListModel.eventDetail==nil ? @"":actionListModel.eventDetail,
                      @(actionListModel.adId),
                      @(actionListModel.topicId),
                      @(actionListModel.planId),
                      @(actionListModel.productId),
                      @(actionListModel.shanpingId),
                      @(actionListModel.productOrderId),
                      actionListModel.operationTime==nil ? @"":actionListModel.operationTime,
                      actionListModel.timeIn==nil ? @"":actionListModel.timeIn,
                      actionListModel.timeOut==nil ? @"":actionListModel.timeOut];//参数要和语句里的顺序一致，不然会存错位置。
    if (isSuccess) {
        _index ++;
        NSLog(@"插入数据== 成功 =");
    } else {
        NSLog(@"插入数据== 失败 =");
    }
    
    [_db close];
    // 会影响用户体检么？ 卡顿？
    [UserPref saveUserPref:[StrUtil longToStr:_index] key:@"userActionList"];
}


- (void)deleteAllData
{
    BOOL flag = [_db open];
    if (!flag) {
        return;
    }
    NSString *sqlStr = @"delete from userActionData_table";
    BOOL isSuccess = [_db executeUpdate:sqlStr];
    if (isSuccess) {
        // 清除所有数据后，索引为0
        _index = 0;
        
        [UserPref saveUserPref:[StrUtil longToStr:_index] key:@"userActionList"];
        
    }
    [_db close];
}



/// 获取要发送的数据
- (NSArray *)getActionlistData
{
    BOOL flag = [_db open];
    if (!flag) {
        return nil;
    }
    
    FMResultSet *resultSet = [_db executeQuery:@"SELECT * FROM userActionData_table"];
    NSMutableArray *actionListM = [NSMutableArray array];
    while (resultSet.next) {
        // 获得当前所指向的数据----对应字段来取数据
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[resultSet stringForColumn: @"page" ] forKey:@"page"];
        [dict setObject:[resultSet stringForColumn: @"event" ] forKey:@"event"];
        [dict setObject:[resultSet stringForColumn: @"eventDetail" ] forKey:@"eventDetail"];
        [dict setObject:@([resultSet intForColumn: @"adId"]) forKey:@"adId"];
        [dict setObject:@([resultSet intForColumn: @"topicId"]) forKey:@"topicId"];
        [dict setObject:@([resultSet intForColumn: @"planId"]) forKey:@"planId"];
        [dict setObject:@([resultSet intForColumn: @"productId"]) forKey:@"productId"];
        [dict setObject:@([resultSet intForColumn: @"shanpingId"]) forKey:@"shanpingId"];
        [dict setObject:@([resultSet intForColumn: @"productOrderId"]) forKey:@"productOrderId"];
        [dict setObject:[resultSet stringForColumn: @"operationTime" ] forKey:@"operationTime"];
        [dict setObject:[resultSet stringForColumn: @"timeIn" ] forKey:@"timeIn"];
        [dict setObject:[resultSet stringForColumn: @"timeOut" ] forKey:@"timeOut"];
        [actionListM addObject:dict];
    }
    
    [_db close];
    
    return actionListM.count > 0 ? actionListM : @[];
}

////取出某个范围内的数据
//- (NSArray *)listWithModelClass:(Class)modelClass range:(NSRange)range
//{
//    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM userActionData_table LIMIT %lu, %lu",range.location, range.length];
//    FMResultSet *set = [_db executeQuery:SQL];
//    NSMutableArray *list = [NSMutableArray array];
//    while (set.next) {
//        NSData *dictData = [set objectForColumnName:@"itemDict"];
//        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:dictData];
////        [list addObject:[modelClass mj_objectWithKeyValues:dict]];
//    }
//    return list;
//}
////通过一组数据的唯一标识判断数据是否存在
//- (BOOL)isExistWithId:(NSString *)idStr
//{
//    BOOL isExist = NO;
//    FMResultSet *resultSet= [_db executeQuery:@"SELECT * FROM userActionData_table where idStr = ?",idStr];
//    while ([resultSet next]) {
//        if([resultSet stringForColumn:@"idStr"]) {
//            isExist = YES;
//        }else{
//            isExist = NO;
//        }
//    }
//    return isExist;
//}

@end

