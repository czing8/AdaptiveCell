//
//  NetworkFunc.h
//  SANQUAN
//
//  Created by Vols on 14-10-22.
//  Copyright (c) 2014年 SANQUAN. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Completion)(id flag, NSError *error);

@interface NetworkFunc : NSObject

+ (id)sharedIntance;

//默认需要sign，为了兼容以前代码
- (void)postFunc:(NSDictionary *)data path:(NSString *)path completion:(Completion)completion;

- (void)postFunc:(NSDictionary *)data path:(NSString *)path sign:(BOOL)sign completion:(Completion)completion;

- (void)modifyTokenCompletion:(Completion)completion;


//记录用户的操作日志
- (void)logFunc:(NSDictionary *)data completion:(Completion)completion;

/*

- (void)registerFunc:(NSDictionary *)data completion:(Completion)completion;

- (void)loginFunc:(NSDictionary *)data completion:(Completion)completion;

*/



@end
