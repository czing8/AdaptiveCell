//
//  VNetworkFunc.h
//  APIDebugDemo
//
//  Created by Vols on 15/4/12.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Completion)(id flag, NSError *error);


@interface VNetworkFunc : NSObject

+ (id)sharedIntance;

//- (void)registerFunc:(NSDictionary *)data completion:(Completion)completion;
//- (void)loginFunc:(NSDictionary *)data completion:(Completion)completion;

//默认需要sign，为了兼容以前代码
- (void)postFunc:(NSDictionary *)data path:(NSString *)path completion:(Completion)completion;

- (void)postFunc:(NSDictionary *)data path:(NSString *)path sign:(BOOL)sign completion:(Completion)completion;


//记录用户的操作日志
- (void)logFunc:(NSDictionary *)data completion:(Completion)completion;


@end
