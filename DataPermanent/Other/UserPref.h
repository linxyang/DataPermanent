//
//  Constants.h
//  SP2P
//
//  Created by xuym on 13-7-30.
//  Copyright (c) 2013年 sls001. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserPref :NSObject


+ (NSString *)getUserPref:(NSString *)key;

+ (void)saveUserPref:(id)value key:(NSString *)key;

+ (void)removeUserPref:(NSString *)key;

+ (void)clearUserPref;


@end
