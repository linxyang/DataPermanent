//
//  StrUtil.h
//  HelloWorld
//
//  Created by 家吉 李 on 13-3-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StrUtil : NSObject

/*
 *字符串转int
 */
+(int)strToInt:(NSString *)str initValue:(int) initValue;
+(int)strToInt:(NSString *)str;
/*
 *字符串转float
 */
+(float)strToFloat:(NSString* )str initValue:(float) initValue;
+(float)strToFloat:(NSString* )str;

/*
 *字符串转long
 */
+(long)strToLong:(NSString* )str initValue:(long) initValue;
+(long)strToLong:(NSString* )str;

+(NSString *)longToStr:(long)value;
/*
 *int转字符串
 */
+(NSString*)intToStr:(int )value;
/*
 *float转字符串
 */
+(NSString*)floatToStr:(float)value;
/*
 *str1+str2
 */
+(NSString*)append:(NSString*) str1 other:(NSString*) str2;
+(NSString*)plus:(NSArray *) array;
/*
 *比较字符串
 */
+(BOOL)isEqual:(NSString*) str1 another:(NSString*) str2;

/*
 *是否为空
 */
+(BOOL)isNull:(id)object;
/*
 *是否为空
 */
+(NSString*)formatStr:(id )value;

+(NSString *)getTimeStr:(int)time;
/*
 *是否为空
 */
+(NSString*)nullToStr:(NSString *)str;
/*
 *是否包含
 */
+(BOOL)strContainsStr:(NSString *)parentStr subStr:(NSString *)subStr;
+(NSString *)strToFormat:(NSString *)str;
+(BOOL) isEmpty:(NSString*)text;
+(BOOL) boolValue:(NSDictionary*)dict forKey:(id)key;
+(float) floatValue:(NSDictionary*)dict forKey:(id)key;
+(NSInteger) intValue:(NSDictionary*)dict forKey:(id)key;
+(NSString*) strValue:(NSDictionary*)dict forKey:(id)key;
+(NSArray*) arrayValue:(NSDictionary*)dict forKey:(id)key;
+(id) noneNullValue:(NSDictionary*)dict forKey:(id)key;
+(NSDictionary*) dictionaryValue:(NSDictionary*)dict forKey:(id)key;
+(BOOL) strEquals:(NSString*)str1 to:(NSString*)str2;
+(BOOL) caseEquals:(NSString*)str1 to:(NSString*)str2;
+(NSString*) refineUrl:(NSString*)url;
+(BOOL) isURLStr:(NSString*)text;
+(BOOL) startWith:(NSString*)prefix forString:(NSString*)text;
+(BOOL) endWith:(NSString*)suffix forString:(NSString*)text;
+(NSString*) getCurrentShortTime;
+(NSTimeInterval)strToTime:(NSString *)string;
+(NSString *)strToDateStr:(NSString *)string withFormat:(NSString*)fmt;
+(NSDate *)strToDate:(NSString *)string withFormat:(NSString*)fmt;
+(NSString*) dateToStr:(NSDate*)date withFormat:(NSString*)fmt;
+(NSString*) dateToStr:(NSDate*)date withStandardFormat:(NSString*)fmt;
+(NSString*) idToStr:(id)obj;
+(int) idToInt:(id)obj;
+(NSInteger) idToInteger:(id)obj;
+(BOOL)  booleanToBool:(id)bobj;
+(NSString*) getShortTime:(NSString *)date;
+(NSString*) getDateYmd;
+(NSString*) getTomorrowDateYmd;
+(NSString*) encode:(NSString *)str;
+(float)getImageRatio:(NSString *)url;
- (NSString *)md5String:(NSString *)string;
+(NSString *)getUUID;

+(NSString *)getUUIDImgName;

+(NSString *)getUUIDImgName:(int)width height:(int)height;

+(NSString *)getUUIDImgName:(NSString *)name date:(NSString *)date;


+ (BOOL)containsChinese:(NSString *)str;

+ (BOOL)containsSpecialCharact:(NSString *)str;

+ (BOOL)isTelePhone:(NSString *)str;

+ (BOOL)isMediaUrl:(NSString *)url;

/**
 *  该字符串是否全部为中文
 */
+ (BOOL)isAllChineseString:(NSString *)str;

//获取除掉多媒体标签的内容
+ (NSString*) getSplitMediaContent:(NSString *)content;


@end
