//
//  LDDataPermanentManager.h
//  DataPermanent
//
//  Created by Yanglixia on 16/9/26.
//  Copyright © 2016年 ylx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDNetworkManager.h"
#import "LDDataBaseManager.h"

@interface LDDataPermanentManager : NSObject

+ (instancetype)shareManager;

- (void)sendUserActionDataToServerForMin:(NSUInteger)minutes maxCount:(NSInteger)maxCount;

- (NSDictionary *)dataPrepare;


@end
