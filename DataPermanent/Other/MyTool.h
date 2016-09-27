//
//  MyTool.h
//  SP2P
//
//  Created by xuym on 13-7-31.
//  Copyright (c) 2013年 sls001. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BiaoDetailDelegate <NSObject>

- (void)someEvent:(NSInteger)tag debtId:(NSInteger)debtId ;

@end

@interface MyTool : NSObject

+ (void)showActivityIndicator;

+ (void)hideActivityIndicator;

+ (NSString *)getSysVersion;

+(NSString *)getDeviceName;

+ (NSString*)deviceVersion;

+(NSString *)getDeviceModel;

+ (NSString *)getAppVersion;

+ (NSString *)getAppName;

+(NSString *)idfvString;

+(NSString *)idfaString;

+(NSString * )macString;

+(NSString *)getUUIDString;

+(NSString *)getSecretStr;

+ (BOOL)isSupportBLE;
@end
