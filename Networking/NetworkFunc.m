//
//  NetworkFunc.m
//  SANQUAN
//
//  Created by Vols on 14-10-22.
//  Copyright (c) 2014年 SANQUAN. All rights reserved.
//

#import "NetworkFunc.h"
#import "DataCenter.h"

#import "VNetworkManager.h"
#import "VConnection.h"

@implementation NetworkFunc

+ (id)sharedIntance {
    
    static NetworkFunc *sharedIntance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedIntance = [[NetworkFunc alloc] init];
    });
    
    return sharedIntance;
}


#pragma mark - Common Method

- (void)postFunc:(NSDictionary *)data path:(NSString *)path completion:(Completion)completion{
    [self postFunc:data path:path sign:YES completion:completion];
}


- (void)postFunc:(NSDictionary *)data path:(NSString *)path sign:(BOOL)sign completion:(Completion)completion{
    
    VConnection * connection = [[VConnection alloc] initWithData:data method:kConnectMethodPost path:path];

    connection.success = ^(NSDictionary *data_){
        NSLog(@"request success, %@ --> %@", path, data_);
        
        if ([data_[@"code"] intValue] == 401) {
            [DataCenter shared].loginStatus = NO;
        }
        
        completion(data_, nil);
    };
    
    connection.failed =  ^(NSError *error) {
        NSLog(@"connect faild");
        completion(nil, error);
    };
    
    [[VNetworkManager sharedClient] processOperation:connection sign:sign];
}


#pragma mark - Specific Method

- (void)setActivityMachine:(NSString *)machineCode type:(BOOL)type{
    
}



- (void)modifyTokenCompletion:(Completion)completion{
    
    NSDictionary *data = @{@"token":[DataCenter shared].deviceToken==nil?@"token":[DataCenter shared].deviceToken};
    
    VConnection * connection = [[VConnection alloc] initWithData:data method:kConnectMethodPost path:@"user/modifyToken"];
    
    connection.success = ^(NSDictionary *data_){
        NSLog(@"success, log --> %@", data_);
        completion(data_, nil);
    };
    
    connection.failed =  ^(NSError *error) {
        NSLog(@"connect faild");
        completion(nil, error);
    };
    
    [[VNetworkManager sharedClient] processOperation:connection sign:NO];
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





/*
- (void)registerFunc:(NSDictionary *)data completion:(Completion)completion{
    
    Connection * connection = [[Connection alloc] initWithData:data method:kConnectMethodPost path:@"user/signup2"];
    
    connection.success = ^(NSDictionary *data_){
        completion(data_, nil);
    };
    
    connection.failed =  ^(NSError *error) {
        NSLog(@"connect faild");
        completion(nil, error);
    };
    
    [[NetworkManager sharedClient] processOperation:connection sign:NO];
}

- (void)loginFunc:(NSDictionary *)data completion:(Completion)completion {
    
    Connection * connection = [[Connection alloc] initWithData:data method:kConnectMethodPost path:@"user/login"];
    
    connection.success = ^(NSDictionary *data_){
        completion(data_, nil);
    };
    
    connection.failed =  ^(NSError *error) {
        NSLog(@"connect faild");
        completion(nil, error);
    };
    
    [[NetworkManager sharedClient] processOperation:connection sign:NO];
}

- (void)postFunc:(NSDictionary *)data path:(NSString *)path completion:(Completion)completion{
    
    Connection * connection = [[Connection alloc] initWithData:data method:kConnectMethodPost path:path];
    
    connection.success = ^(NSDictionary *data_){
        NSLog(@"success, %@ --> %@", path, data_);
        
        completion(data_, nil);
    };
    
    connection.failed =  ^(NSError *error) {
        NSLog(@"connect faild");
        completion(nil, error);
    };
    
    [[NetworkManager sharedClient] processOperation:connection sign:YES];
}



- (void)logFunc:(NSDictionary *)data completion:(Completion)completion{
    
    Connection * connection = [[Connection alloc] initWithData:data method:kConnectMethodPost path:@"interface/useroplog"];
    
    connection.success = ^(NSDictionary *data_){
        NSLog(@"success, log --> %@", data_);
        completion(data_, nil);
    };
    
    connection.failed =  ^(NSError *error) {
        NSLog(@"connect faild");
        completion(nil, error);
    };
    
    [[NetworkManager sharedClient] processOperation:connection sign:YES];
}

 */

@end
