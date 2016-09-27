// LDNetworkManager.h
// 网络请求工具类
//
//  Created by fuchun on 16/9/26.
//  Copyright © 2016年 ylx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>


typedef void(^successBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void(^failureBlock)(NSURLSessionDataTask *task, NSError *error);


@interface LDNetworkManager : NSObject

///接口地址
@property (nonatomic,copy,readonly) NSString *baseURLString;
///令牌 
@property (nonatomic,copy) NSString *authToken;
/// 当前连接网络类似
@property (nonatomic, assign, readonly) AFNetworkReachabilityStatus networkStatus;

+ (instancetype)shareManager;

- (BOOL)checkNetworkStatus;

/**
 *  GET请求
 *
 *  @param Url             接口路径(例:user/login)
 *  @param params          参数
 *  @param successCallBack 成功回调
 *  @param failureCallBack 失败回调
 *
 *  @return 请求操作
 */
- (NSURLSessionDataTask *)getWithUrl:(NSString *)Url
                              params:(NSDictionary *)params
                             success:(successBlock)successCallBack
                             failure:(failureBlock)failureCallBack;

/**
 *  POST请求
 *
 *  @param Url             接口路径(例:user/login)
 *  @param params          参数
 *  @param successCallBack 成功回调
 *  @param failureCallBack 失败回调
 *
 *  @return 请求操作
 */
- (NSURLSessionDataTask *)postWithUrl:(NSString *)Url
                               params:(NSDictionary *)params
                              success:(successBlock)successCallBack
                              failure:(failureBlock)failureCallBack;

/**
 *  POST上传图片
 *
 *  @param Url          接口路径(例如:user/login)
 *  @param params          参数
 *  @param imageFileDatas  图片文件数据
 *  @param successCallBack 成功回调
 *  @param failureCallBack 失败回调
 *
 *  @return 请求操作
 */
- (NSURLSessionDataTask *)postWithUrl:(NSString *)Url
                               params:(NSDictionary *)params
                            imageFileDatas:(NSDictionary *)fileDatas
                              success:(successBlock)successCallBack
                              failure:(failureBlock)failureCallBack;

/**
 *  POST上传文件
 *
 *  @param Url          接口路径(例:user/login)
 *  @param params          参数
 *  @param block           构造表单回调
 *  @param successCallBack 成功回调
 *  @param failureCallBack 失败回调
 *
 *  @return 请求操作
 */
- (NSURLSessionDataTask *)postWithUrl:(NSString *)Url
                               params:(NSDictionary *)params
            constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                              success:(successBlock)successCallBack
                              failure:(failureBlock)failureCallBack;



@end
