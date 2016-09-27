//
//  convert.h
//  DataPermanent
//
//  Created by fuchun on 16/9/26.
//  Copyright © 2016年 ylx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface convert : NSObject
//将16进制数据转化成NSData
+ (NSData *)hexStrToNSData:(NSString *)hexStr;

//将NSData转化成16进制数据
+ (NSString *)NSDataToHexString:(NSData *)data;
@end
