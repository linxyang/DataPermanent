//
//  LDUploadFile.m
//  DataPermanent
//
//  Created by fuchun on 16/9/26.
//  Copyright © 2016年 ylx. All rights reserved.
//

#import "LDUploadFile.h"

@interface LDUploadFile()

@end

@implementation LDUploadFile


- (instancetype)initWithType:(LDUploadFileType)type data:(NSData *)data key:(NSString *)key
{
    if(self = [super init])
    {
        _data = [data copy];
        _type = type;
        _key = [key copy];
        self.fileName = [LDUploadFile guidString];//生成唯一字符串
        NSString *ps = @"";
        
        switch (type)
        {
            case LDUploadFileTypeImage:
                self.fileName = [self.fileName stringByAppendingPathExtension:@"jpg"];
                self.mimeType = @"image/jpeg";
                CGSize size = [UIImage imageWithData:data].size;
                ps = [NSString stringWithFormat:@"?pw=%ld&ph=%ld",(long)size.width,(long)size.height];//这个根据情况来定
                break;
                
            case LDUploadFileTypeAudio:
                self.fileName = [self.fileName stringByAppendingPathExtension:@"amr"];
                self.mimeType = @"audio/amr";
                break;
                
            case LDUploadFileTypeVideo:
                self.fileName = [self.fileName stringByAppendingPathExtension:@"mp4"];
                self.mimeType = @"video/mp4";
                break;
                
            default:
                break;
        }
        self.fileName = [NSString stringWithFormat:@"ios_%@",self.fileName];//文件名
        
        NSString *tmp = NSTemporaryDirectory();
        self.localPath = [tmp stringByAppendingPathComponent:self.fileName];//用来存本地时的路径
        _remotePath = [NSString stringWithFormat:@"http://img2.liandan100.com/@%@%@",self.fileName,ps];//url地址
    }
    return self;
}

- (BOOL)saveToTemp
{
    if(self.data)
    {
        return [self.data writeToFile:self.localPath atomically:YES];
    }
    return NO;
}

+ (instancetype)uploadFileWihType:(LDUploadFileType)type data:(NSData *)data key:(NSString *)key
{
    return [[self alloc] initWithType:type data:data key:key];
}


// 生成唯一字符串
+ (NSString *)guidString
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    uuidString = [uuidString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    uuidString = [uuidString lowercaseString];
    return uuidString ;
}

@end
