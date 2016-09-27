//
//  ProductM.m
//  liandaniphone
//
//  Created by meilixun Mac mini on 14-6-11.
//  Copyright (c) 2014年 meilixun Mac mini. All rights reserved.
//

#import "UserPref.h"
#import "StrUtil.h"


@implementation UserPref

+ (NSString *)getUserPref:(NSString *)key{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    return [StrUtil idToStr:[defaults objectForKey:key]];
}

+ (void)saveUserPref:(id)value key:(NSString *)key{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
}

+ (void)removeUserPref:(NSString *)key{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
}

+ (void)clearUserPref{
    //[NSUserDefaults resetStandardUserDefaults];
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}


@end
