//
//  VNetworkFunc.m
//  APIDebugDemo
//
//  Created by Vols on 15/4/12.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import "VNetworkFunc.h"
#import "VConnection.h"
#import "VNetworkManager.h"

@implementation VNetworkFunc

+ (id)sharedIntance {
    
    static VNetworkFunc *sharedIntance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedIntance = [[VNetworkFunc alloc] init];
    });
    
    return sharedIntance;
}


- (void)postFunc:(NSDictionary *)data path:(NSString *)path completion:(Completion)completion{
    [self postFunc:data path:path sign:YES completion:completion];
}


- (void)postFunc:(NSDictionary *)data path:(NSString *)path sign:(BOOL)sign completion:(Completion)completion{
    
    VConnection * connection = [[VConnection alloc] initWithData:data method:kConnectMethodPost path:path];
    
    connection.success = ^(NSDictionary *data_){
        NSLog(@"request success, %@ --> %@", path, data_);
        
        completion(data_, nil);
    };
    
    connection.failed =  ^(NSError *error) {
        NSLog(@"connect faild");
        completion(nil, error);
    };
    
    [[VNetworkManager sharedClient] processOperation:connection sign:sign];
}



- (void)logFunc:(NSDictionary *)data completion:(Completion)completion{
    
    VConnection * connection = [[VConnection alloc] initWithData:data method:kConnectMethodPost path:@"interface/useroplog"];
    
    connection.success = ^(NSDictionary *data_){
        NSLog(@"success, log --> %@", data_);
        completion(data_, nil);
    };
    
    connection.failed =  ^(NSError *error) {
        NSLog(@"connect faild");
        completion(nil, error);
    };
    
    [[VNetworkManager sharedClient] processOperation:connection sign:YES];
}


@end
