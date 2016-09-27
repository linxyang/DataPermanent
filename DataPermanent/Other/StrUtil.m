//
//  StrUtil.m
//  HelloWorld
//
//  Created by fuchun on 13-3-12.
//  Copyright (c) 2013年 fuchun. All rights reserved.
//

#import "StrUtil.h"
#import <CommonCrypto/CommonDigest.h>

@implementation StrUtil



+(int)strToInt:(NSString *)str initValue:(int) initValue
{
    if(str==NULL|| str == nil)
        return initValue;
    return [str intValue];
}
+(int) strToInt:(NSString *)str
{
    return [self strToInt:str  initValue:0];
}

+(float)strToFloat:(NSString *)str initValue:(float)initValue
{
    if(str==NULL|| str == nil)
        return  initValue;
    return[str floatValue];
}
+(float)strToFloat:(NSString *)str
{
    return [self strToFloat:str  initValue:0];
}

+(long)strToLong:(NSString *)str initValue:(long)initValue
{
    if(str==NULL|| str == nil)
        return  initValue;
    return[str doubleValue];
}
+(long)strToLong:(NSString *)str
{
    return [self strToLong:str  initValue:0];
}

+(NSString *)intToStr:(int)value
{
    return [NSString stringWithFormat:@"%d",value];
}

+(NSString *)longToStr:(long)value
{
    return [NSString stringWithFormat:@"%ld",value];
}

+(NSString *)floatToStr:(float)value
{
    return [NSString stringWithFormat:@"%f",value];
}

+(NSString *)formatStr:(id)value
{
    return [NSString stringWithFormat:@"%@",value];
}

+(NSString *)append:(NSString *)str1 other:(NSString *)str2
{
    
    if(str1==NULL|| str1 == nil)
        str1 = @"";
    if(str2==NULL|| str2 == nil)
        str2 = @"";
    return [str1 stringByAppendingString:str2];
}
+(NSString *)plus:(NSArray *)array
{
    NSString* str=@"";
    for(int i=0;i<[array count];i++)
    {
        str=[self append:str other:[array objectAtIndex:i]];
    }
    return str;
}

+(BOOL)isEqual:(NSString *)str1 another:(NSString *)str2
{
    if(str1==NULL|| str1 == nil)
        return  NO;
    if(str2==NULL|| str2 == nil)
        return  NO;
    return [str1 compare:str2]==NSOrderedSame;
}

+(BOOL)isNull:(id)object
{
    if(object != nil && ![object isKindOfClass:[NSNull class]])
        return NO;
    return YES;
}


+(NSString*)nullToStr:(NSString *)str
{
    if(str==NULL || str == nil ||[str isKindOfClass:[NSNull class]] || [str isEqualToString:@"(null)"] || [str isEqualToString:@"<null>"])
        return @"";
    return str;
    
}

+(BOOL)strContainsStr:(NSString *)parentStr subStr:(NSString *)subStr
{
    if([StrUtil isEmpty:parentStr])
        return NO;
    if([StrUtil isEmpty:subStr])
        return YES;
    NSRange range = [parentStr rangeOfString:subStr];//判断字符串是否包含
    if (range.location == NSNotFound)
        return NO;
    else//包含
        return YES;
}

+(NSString *)strToFormat:(NSString *)str
{
    return [str stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];
}


/*
 - (NSString *)stringByRemovingNewLinesAndWhitespace
 {
 NSScanner *scanner = [[NSScanner alloc] initWithString:self];
 [scanner setCharactersToBeSkipped:nil];
 NSMutableString *result = [[NSMutableString alloc] init];
 NSString *temp;
 NSCharacterSet *newLineAndWhitespaceCharacters = [ NSCharacterSet newlineCharacterSet];
 // Scan
 while (![scanner isAtEnd]) {
 
 // Get non new line or whitespace characters
 temp = nil;
 [scanner scanUpToCharactersFromSet:newLineAndWhitespaceCharacters intoString:&temp];
 if (temp) [result appendString:temp];
 
 // Replace with a space
 if ([scanner scanCharactersFromSet:newLineAndWhitespaceCharacters intoString:NULL]) {
 if (result.length > 0 && ![scanner isAtEnd]) // Dont append space to beginning or end of result
 [result appendString:@" "];
 }
 }
 // Return
 NSString *retString = [NSString stringWithString:result];
 // Return
 return retString;
 }
 
 +(BOOL)replaceAll:(NSString *)string:(NSString *)subStr
 {
 for (int i = 0; i<[string length]; i++) {
 //截取字符串中的每一个字符
 NSString *s = [string substringWithRange:NSMakeRange(i, 1)];
 NSLog(@"string is %@",s);
 if ([s isEqualToString:@"m"]) {
 NSRange range = NSMakeRange(i, 1);
 //将字符串中的“m”转化为“w”
 string =   [string stringByReplacingCharactersInRange:range withString:@"w"];
 
 }
 }
 }
 
 */


+(BOOL) isEmpty:(NSString*)text
{
    if (text == nil) {
        return YES;
    }
    if ([text length] == 0 ) {
        return YES;
    }
    return NO;
}

+(NSString*) idToStr:(id)obj
{
    if ( obj == nil ) {
        return @"";
    }
    
    if ( [obj isKindOfClass:[NSNull class]]) {
        return @"";
    }
    if ( [obj isKindOfClass:[NSString class]]) {
        return (NSString*)obj;
    } else if ( [obj isKindOfClass:[NSArray class]] ) {
        NSMutableString* ntf = [NSMutableString string];
        for (id t in obj ) {
            [ntf appendString:[self idToStr:t]];
            [ntf appendString:@","];
        }
        return ntf;
    } else {
        if( CFGetTypeID((__bridge CFTypeRef)(obj)) == CFBooleanGetTypeID() ) {
            return [NSString stringWithFormat:@"%@", (CFBooleanGetValue((CFBooleanRef)obj) == true ? @"true" : @"false") ];
        }
        if ( sizeof(obj) == sizeof(BOOL) ) {
            //return (BOOL)obj == YES ? @"true" : @"false";
        }
        if( [obj respondsToSelector:@selector(stringValue)] ) {
            
            return [obj stringValue];
            
        }
        return [obj description];
    }
}


+(int) idToInt:(id)obj
{
    if ( obj == nil || [obj isKindOfClass:[NSNull class]]) {
        return 0;
    }
    return [obj intValue];
}

+(NSInteger) idToInteger:(id)obj
{
    if ( obj == nil || [obj isKindOfClass:[NSNull class]]) {
        return 0;
    }
    return [obj integerValue];
}

+(BOOL) boolValue:(NSDictionary*)dict forKey:(id)key

{
    id bl = [dict objectForKey:key];
    if ( bl == nil || [bl isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if ( [bl isKindOfClass:[NSString class]]) {
        NSString* cstr = [bl lowercaseString];
        if ( [cstr isEqualToString:@"yes"] || [cstr isEqualToString:@"true"]) {
            return YES;
        }
        return [cstr boolValue];
    }
    if ( CFBooleanGetValue((CFBooleanRef)bl) ) {
        return YES;
    }
    return NO;
}

+(float) floatValue:(NSDictionary*)dict forKey:(id)key{
    id bl = [dict objectForKey:key];
    if ( bl == nil || [bl isKindOfClass:[NSNull class]]) {
        return 0.0f;
    }
    return [bl floatValue];
}

+(NSInteger) intValue:(NSDictionary*)dict forKey:(id)key
{
    id bl = [dict objectForKey:key];
    if ( bl == nil || [bl isKindOfClass:[NSNull class]]) {
        return 0;
    }
    return [bl intValue];
}


+(NSString*) strValue:(NSDictionary*)dict forKey:(id)key
{
    id bl = [dict objectForKey:key];
    if ( bl == nil || [bl isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return [self idToStr:bl];
}

+(NSArray*) arrayValue:(NSDictionary*)dict forKey:(id)key
{
    id bl = [dict objectForKey:key];
    if ( bl == nil || [bl isKindOfClass:[NSNull class]]) {
        return nil;
    }
    if ( [bl isKindOfClass:[NSArray class]]) {
        return (NSArray*)bl;
    }
    return nil;
}

+(NSDictionary*) dictionaryValue:(NSDictionary*)dict forKey:(id)key
{
    id bl = [dict objectForKey:key];
    if ( bl == nil || [bl isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return (NSDictionary*)bl;
}

+(id) noneNullValue:(NSDictionary*)dict forKey:(id)key
{
    id bl = [dict objectForKey:key];
    if ( bl == nil || [bl isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return bl;
}

+(BOOL) strEquals:(NSString*)str1 to:(NSString*)str2
{
    if ( str1 == nil || str2 == nil ) {
        return NO;
    }
    return [str1 compare:str2 options:NSCaseInsensitiveSearch] == NSOrderedSame;
}

+(BOOL) caseEquals:(NSString*)str1 to:(NSString*)str2
{
    return (str1 == nil || str2 == nil) ? NO : [str1 isEqualToString:str2];
}

+(BOOL) startWith:(NSString*)prefix forString:(NSString*)text;

{
    
    if ( text != nil && prefix != nil ) {
        
        if ( [prefix length] > [text length] ) {
            
            return NO;
        }
        NSString* prestr = [text substringToIndex:[prefix length]];
        if ( [self strEquals:prestr to:prefix] ) {
            return YES;
        }
    }
    return NO;
}

+(BOOL) endWith:(NSString*)suffix forString:(NSString*)text
{
    if ( text != nil && suffix != nil ) {
        if ( [suffix length] > [text length] ) {
            return NO;
        }
        NSInteger len = [text length] - [suffix length];
        NSString* sufstr = [text substringFromIndex:len];
        if ( [self caseEquals:sufstr to:suffix] ) {
            
            return YES;
        }
    }
    return NO;
}

+(BOOL) isURLStr:(NSString*)text
{
    if ( [text length] > 6 ) {
        
        NSString* prefix = [text substringToIndex:6];
        
        if ( [self strEquals:prefix to:@"http:/"] || [self strEquals:prefix to:@"https:"] ) {
            
            return YES;
            
        } else if ( [self strEquals:prefix to:@"local:" ] ) {
            
            return YES;
            
        }
        
    }
    
    if ( [self startWith:@"/" forString:text] ) {
        
        return YES;
        
    }
    
    return NO;
    
}


+(NSString*) refineUrl:(NSString*)url
{
    return url;
}

+(BOOL)  booleanToBool:(id)bobj

{
    
    if ( bobj == nil ) {
        
        return NO;
        
    }
    
    if ( [bobj isKindOfClass:[NSString class]] ) {
        
        return [bobj caseInsensitiveCompare:@"yes"] == 0 || [bobj caseInsensitiveCompare:@"true"] == 0;
        
    } else if ( [bobj respondsToSelector:@selector(boolValue)] ) {
        
        return [bobj boolValue];
        
    } else {
        
        return CFBooleanGetValue((CFBooleanRef)bobj);
        
    }
    
    
    return NO;
    
}

+(NSString *)getTimeStr:(int)time
{
    if(time<60)
        return  [NSString stringWithFormat:@"%d秒",time];
    else
        return [NSString stringWithFormat:@"%d分钟",time/60];
    
}


+(NSTimeInterval)strToTime:(NSString *)string{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:string];
    return [date timeIntervalSinceReferenceDate];
}

+(NSString *)strToDateStr:(NSString *)string withFormat:(NSString*)fmt
{
    NSDate *formatDate = [self strToDate:string withFormat:nil];
    return [self dateToStr:formatDate withStandardFormat:fmt];
}

+(NSDate *)strToDate:(NSString *)string withFormat:(NSString*)fmt{
    if([self isEmpty:string])
        return [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    NSString *dateFormat=@"yyyy-MM-dd HH:mm:ss";
    NSString* format = fmt == nil ? dateFormat : fmt;
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:string];
    return date;
}

+(NSString*) dateToStr:(NSDate*)date withFormat:(NSString*)fmt
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    NSString *dateFormat=@"yyyy-MM-dd'T'HH:mm:ss'Z'";
    NSString* format = fmt == nil ? dateFormat : fmt;
    [formatter setDateFormat:format];
    NSString* dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+(NSString*) dateToStr:(NSDate*)date withStandardFormat:(NSString*)fmt
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    NSString *dateFormat=@"yyyy-MM-dd HH:mm:ss";
    NSString* format = fmt == nil ? dateFormat : fmt;
    [formatter setDateFormat:format];
    NSString* dateStr = [formatter stringFromDate:date];
    return dateStr;
}
//获取今天日期
+(NSString*) getDateYmd
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:[NSDate date]];
}
//获取明天日期
+(NSString*) getTomorrowDateYmd
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:[[NSDate date] initWithTimeIntervalSinceNow:24 * 60 * 60]];
    
}

+(NSString*) getCurrentShortTime
{
    return [self getShortTime:[self dateToStr:[NSDate date] withStandardFormat:nil]];
}

+(NSString*) getShortTime:(NSString *)date
{
    NSDate *currentDay = [self strToDate:[self getDateYmd] withFormat:@"yyyy-MM-dd"];
    NSTimeInterval currentDayInterval = [currentDay timeIntervalSince1970];
    NSDate *time = [self strToDate:date withFormat:nil];
    if(time == nil) {
        return @"";
    }
    NSTimeInterval timeInterval = [time timeIntervalSince1970];
    if(timeInterval-currentDayInterval >=0)
    {
        return [self dateToStr:time withFormat:@"HH:mm"];
    } else if(currentDayInterval-timeInterval<24*60*60*1000) {
        return @"昨天";
    } else if(currentDayInterval-timeInterval<2*24*60*60*1000)
    {
        return @"前天";
    } else {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                              fromDate:time];
        if(comps!= nil)
            return [NSString stringWithFormat:@"%ld月%ld日",(long)comps.month,(long)comps.day];
        else
            return @"";
    }
    return date;
}

+(NSString*) encode:(NSString *)str
{
    return  (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, nil, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8));
}

+ (NSString*)getSplitMediaContent:(NSString *)content {
    if([StrUtil isEmpty:content])
        return nil;
    
    NSMutableString *resultStr = [[NSMutableString alloc] initWithString:@""];
    NSString *regTags = @"\\[media (.*?) /]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive                                                                              error:nil];
    NSArray *matches = [regex matchesInString:content options:0 range:NSMakeRange(0, [content length])];
    NSUInteger index =0;
    
    if (matches.count > 0) {
        for (NSTextCheckingResult *match in matches) {
            NSRange matchRange = [match range];
            NSUInteger start = matchRange.location;
            NSString *txt = [content substringWithRange:NSMakeRange(index, start-index)];
            if(![txt isEqualToString:@""]){
                [resultStr appendString:txt];
            }
            index = start+matchRange.length;
        }
    }else {
        [resultStr appendString:content];
    }
    
    //@用户
    regTags = @"(\\[@\\])[^(\\[/@\\])]+(\\[/@\\])";
    regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive                                                                              error:nil];
    matches = [regex matchesInString:resultStr options:0 range:NSMakeRange(0, [resultStr length])];
    index = 0;
    NSMutableString *userStr = [[NSMutableString alloc] initWithString:@""];
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match range];
        NSUInteger start = matchRange.location;
        NSString *txt = [resultStr substringWithRange:NSMakeRange(index, start-index)];
        NSString *rangStr = [resultStr substringWithRange:NSMakeRange(matchRange.location, matchRange.length)];
        if(![StrUtil isNull:txt] && ![[StrUtil nullToStr:txt] isEqualToString:@""]){
            [userStr appendString:txt];
        }
        if(![StrUtil isNull:rangStr] && ![[StrUtil nullToStr:rangStr] isEqualToString:@""]){
            rangStr = [rangStr stringByReplacingOccurrencesOfString:@"[@]" withString:@""];
            rangStr = [rangStr stringByReplacingOccurrencesOfString:@"[/@]" withString:@""];
            NSArray *arrInfo = [rangStr componentsSeparatedByString:@" "];
            if (![StrUtil isNull:arrInfo] && arrInfo.count > 1) {
                NSArray *subInfo = [[arrInfo objectAtIndex:1] componentsSeparatedByString:@"="];
                if (![StrUtil isNull:subInfo] && subInfo.count > 1) {
                    [userStr appendString:[NSString stringWithFormat:@" @%@ ",subInfo[1]]];
                }
            }
            
        }
        index = start+matchRange.length;
    }
    if (index< resultStr.length) {
        [userStr appendString:[resultStr substringWithRange:NSMakeRange(index, resultStr.length-index)]];
    }
    
//    //去除多余换行
//    regTags = @".+";
//    regex = [NSRegularExpression regularExpressionWithPattern:regTags
//                                                      options:NSRegularExpressionCaseInsensitive                                                                              error:nil];
//    matches = [regex matchesInString:userStr options:0 range:NSMakeRange(0, [userStr length])];
//    index = 0;
//    NSMutableString *lastStr = [[NSMutableString alloc] initWithString:@""];
//    for (NSTextCheckingResult *match in matches) {
//        NSRange matchRange = [match range];
//        NSUInteger start = matchRange.location;
//        NSString *txt = [userStr substringWithRange:NSMakeRange(index, start-index)];
//        NSString *rangStr = [userStr substringWithRange:NSMakeRange(matchRange.location, matchRange.length)];
//        if(![StrUtil isNull:txt] && ![[StrUtil nullToStr:txt] isEqualToString:@""]){
//            [lastStr appendString:txt];
////            [lastStr appendString:@"\n"];
//        }
//        
//        index = start+matchRange.length;
//    }
//    
//    resultStr = nil;
//    userStr = nil;
    
    return userStr;
}



+(NSString *)trimNextLine:(NSString *)content {
    if (content.length >= 2) {
        if ([content hasPrefix:@"\n"] || [content hasSuffix:@"\n"]) {
            
            if ([content hasPrefix:@"\n"]) {
                content = [content substringFromIndex:2];
            }else {
                content = [content substringToIndex:content.length-2];
            }
            
            content = [StrUtil trimNextLine:content];
        }
    }
    return content;
}


//获取图片高宽比
+(float)getImageRatio:(NSString *)url
{
    NSRange underlineRange = [url rangeOfString:@"_"];
    if (underlineRange.location != NSNotFound) {
        NSString *tempStr = [url  substringFromIndex:underlineRange.location+1];
        NSRange dotRange = [tempStr rangeOfString:@"."];
        if(dotRange.location != NSNotFound)
        {
            NSString *sizeStr = [tempStr substringToIndex: dotRange.location];
            NSArray *sizeArray = [sizeStr componentsSeparatedByString:@"x"];
            if([sizeArray count] == 2)
            {
                return (1.0*[StrUtil idToInt:[sizeArray objectAtIndex:1]])/[StrUtil idToInt:[sizeArray objectAtIndex:0]];
            }
        }
    }
    return 1;
}

- (NSString *)md5String:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+(NSMutableAttributedString *)getTopicAttributedString:(NSString *)string andSpaceing:(float)lineSpacing {
    if ([StrUtil isNull:string]) {
        return nil;
    }
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentLeft;
    [style setLineSpacing:lineSpacing];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, string.length)];
    return attributedString;
}


+(NSString *)getUUID{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return [uuidString stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

+(NSString *)getUUIDImgName{
    return [NSString stringWithFormat:@"%@.jpg",[self getUUID]];
}

+(NSString *)getUUIDImgName:(int)width height:(int)height{
    return [NSString stringWithFormat:@"%@_%dx%d.jpg",[self getUUID],width,height];
}


+ (BOOL)containsChinese:(NSString *)str {
    for(int i = 0; i < [str length]; i++) {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
            return TRUE;
    }
    return FALSE;
}

+ (BOOL)containsSpecialCharact:(NSString *)str {
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$€.,?"]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}

+ (BOOL)isTelePhone:(NSString *)str {
    NSString *regex = @"1[3|5|7|8|9|][0-9]{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}


+ (BOOL)isMediaUrl:(NSString *)url {
    if ([url rangeOfString:@".mp4" options:NSCaseInsensitiveSearch].location != NSNotFound ||
        [url rangeOfString:@".mov" options:NSCaseInsensitiveSearch].location != NSNotFound ||
        [url rangeOfString:@".flv" options:NSCaseInsensitiveSearch].location != NSNotFound ||
        [url rangeOfString:@".3gp" options:NSCaseInsensitiveSearch].location != NSNotFound) {
        return YES;
    }
    return NO;
}

+ (BOOL)isAllChineseString:(NSString *)str
{
    NSString *regex = @"^[\u4E00-\u9FA5]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}

@end
