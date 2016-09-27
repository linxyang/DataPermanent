//
//  LDUploadFile.h
//  DataPermanent
//
//  Created by fuchun on 16/9/26.
//  Copyright © 2016年 ylx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,LDUploadFileType)
{
    LDUploadFileTypeImage = 1,
    LDUploadFileTypeVideo = 2,
    LDUploadFileTypeAudio = 3,
    LDUploadFileTypeHolder= 4,
};

@interface LDUploadFile : NSObject
/// 本地临时路径temp
@property (nonatomic,copy) NSString *localPath;
/// 文件远程地址
@property (nonatomic,readonly) NSString *remotePath;
/// 文件名(包括扩展名)
@property (nonatomic,copy) NSString *fileName;
@property (nonatomic,copy) NSString *mimeType;
@property (nonatomic,readonly) NSData *data;
@property (nonatomic,readonly) LDUploadFileType type;
@property (nonatomic,readonly) NSString *key;// 暂时无大用

+ (instancetype)uploadFileWihType:(LDUploadFileType)type data:(NSData *)data key:(NSString *)key;

@end
