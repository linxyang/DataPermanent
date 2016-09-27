//
//  MyTool.m
//  SP2P
//
//  Created by xuym on 13-7-31.
//  Copyright (c) 2013年 sls001. All rights reserved.
//

#import "MyTool.h"
//for mac
#include <sys/socket.h>
#include <sys/sysctl.h>
#import "sys/utsname.h"
#include <net/if.h>
#include <net/if_dl.h>

//for idfa
#import <AdSupport/AdSupport.h>

#import "KeychainItemWrapper.h"
 //#import "OpenUDID.h"

#import "Encrypt.h"



static NSString * const appsecret = @"d82fc1b3afb19e8d3aac0bead2f9274e"; //APP秘钥,APP本地保留
@implementation MyTool

//获取系统版本
+(NSString *)getSysVersion
{
    return [NSString stringWithFormat:@"%@ %@",[[UIDevice currentDevice] systemName],[[UIDevice currentDevice] systemVersion]];
}

+(NSString *)getDeviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (NSString*)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    //iPod
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([deviceString isEqualToString:@"iPad4,4"]
        ||[deviceString isEqualToString:@"iPad4,5"]
        ||[deviceString isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    
    if ([deviceString isEqualToString:@"iPad4,7"]
        ||[deviceString isEqualToString:@"iPad4,8"]
        ||[deviceString isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
    return deviceString;
}

+(NSString *)getDeviceModel
{
    return  [[UIDevice currentDevice] model];
}

//获取app版本
+ (NSString *)getAppVersion
{
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    NSString* versionNum =[infoDict objectForKey:@"CFBundleShortVersionString"];
    return versionNum;
}

//获取app名称
+ (NSString *)getAppName
{
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    NSString*appName =[infoDict objectForKey:@"CFBundleDisplayName"];
    return appName;
}


+(NSString * )macString{
      return @"";
}

+(NSString *)idfaString {
    return @"";
}

+(NSString*)uuidString
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString* result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

+(NSString *)idfvString
{
      if([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
            return [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
      return @"";
}

+(NSString *) getUUIDString{
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"deviceIdentifier" accessGroup:nil];
    NSString *uniqueIdentifier = [wrapper objectForKey:(id)CFBridgingRelease(kSecAttrAccount)];
    if ([uniqueIdentifier isEqualToString:@""]) {
        [wrapper setObject:[self uuidString] forKey:(id)CFBridgingRelease(kSecAttrAccount)];
    }
    return [Encrypt encrypt:[wrapper objectForKey:(id)CFBridgingRelease(kSecAttrAccount)]];
}

+ (void)showActivityIndicator
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

+ (void)hideActivityIndicator
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
//----判断设备名称(iphone4s,iphone5,ipad3,ipad4,ipadmini,ipod touch5,)支持蓝牙4.0:http://theiphonewiki.com/wiki/index.php?title=Models
+ (BOOL)isSupportBLE{
    NSArray *deviceArray = [[NSArray alloc] initWithObjects:@"iPhone3,1",@"iPhone3,2",@"iPhone3,3",@"iPad1,1",@"iPad2,1",@"iPad2,2",@"iPad2,3",@"iPad2,4",@"iPod1,1",@"iPod2,1",@"iPod3,1",@"iPod4,1",nil];
    NSString *currentMachine = [MyTool getDeviceName];
    return ![deviceArray containsObject:currentMachine];
}

//获取当前时间到1970毫秒数
+(long long)getCurrentTimeFrom1970{
    NSDate *date=[NSDate date];
    //    NSTimeZone *zone=[NSTimeZone localTimeZone];
    //    NSInteger interval=[zone secondsFromGMTForDate:date];
    //    NSDate *localDate=[date dateByAddingTimeInterval:interval];
    long long myIntval=[date timeIntervalSince1970]*1000.0f;
    return myIntval;
}

@end
