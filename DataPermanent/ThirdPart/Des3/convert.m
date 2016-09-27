//
//  convert.m
//  DataPermanent
//
//  Created by fuchun on 16/9/26.
//  Copyright © 2016年 ylx. All rights reserved.
//

#import "convert.h"

@implementation convert

+ (NSData *)hexStrToNSData:(NSString *)hexStr{
    NSMutableData* data = [NSMutableData data];
    for (int i = 0; i+2 <= hexStr.length; i+=2) {
        NSRange range = NSMakeRange(i, 2);
        NSString* ch = [hexStr substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:ch];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    
    return data;
}

+ (NSString *)NSDataToHexString:(NSData *)data{
    if (data == nil) {
        return nil;
    }
    
    NSMutableString* hexString = [NSMutableString string];
    const unsigned char *p = [data bytes];
    for (int i=0; i < [data length]; i++) {
        [hexString appendFormat:@"%02x", *p++];
    }
    
    return hexString;
}


@end
