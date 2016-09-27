//
//  Encrypt.h
//  aaa
//
//  Created by md005 on 13-11-29.
//  Copyright (c) 2013年 md005. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Encrypt : NSObject

+ (NSString*)encrypt:(NSString*)plainText; //加密
+ (NSString*)decrypt:(NSString*)encryptText;  //解密
@end
