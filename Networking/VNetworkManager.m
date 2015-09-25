//
//  VNetworkManager.m
//  APIDebugDemo
//
//  Created by Vols on 15/4/12.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import "VNetworkManager.h"

#import "SignedAlgo.h"
//#import <MKNetworkKit.h>
#import "DataCenter.h"

#import "NSString+MKNetworkKitAdditions.h"

#import <AFNetworking.h>

#define kIOS_CLIENT         @"IOS"

@interface VNetworkManager ()


@end

@implementation VNetworkManager{
  //  MKNetworkEngine *engine;
}

+ (id)sharedClient {
    
    static VNetworkManager *_sharedClient = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        _sharedClient = [[VNetworkManager alloc] init];
    });
    
    return _sharedClient;
}

- (id)init {
    self = [super init];
    
    if (self) {
        
    }
    return self;
}

- (void)processOperation:(VConnection *)connection sign:(BOOL)sign{
    
    NSString * hostURL = kBaseURL;
    
    if ([connection.path isEqualToString:@"interface/useroplog"]) {
        hostURL = kLogURL;
    }
    
    NSURL * baseURL = [NSURL URLWithString:hostURL];
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    
    //登陆，发送验证码需要特殊sign
    if ([connection.path isEqualToString:@"user/login"] || [connection.path isEqualToString:@"sms/sendAuthCodeV2"]) {
        
        dict = [self handlerSpecialParamsDic:connection.data];
    }else{
        dict = [self handlerWithParamsDic:connection.data sign:sign];
    }
    
    NSLog(@"%@, params --> %@", connection.path, dict);
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:connection.path parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject == nil) {
            NSDictionary * dict = @{@"code":@"-100",@"message":@"请稍后再试"};
            [connection didSuccess:dict];
        }
        else{
            [connection didSuccess:responseObject];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [connection didFailed:error];
    }];
    
    /*
    engine = [[MKNetworkEngine alloc] initWithHostName:hostURL customHeaderFields:@{@"User-Agent":@"SANQUAN_iOS"}];

    MKNetworkOperation* op = [engine operationWithPath:connection.path params:dict httpMethod:method];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([completedOperation responseJSON] == nil) {
            NSDictionary * dict = @{@"code":@"-100",@"message":@"服务器数据错误"};
            [connection didSuccess:dict];
        }
        else{
            NSDictionary * dict = (NSDictionary *)[completedOperation responseJSON];
            [connection didSuccess:dict];
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [connection didFailed:error];
    }];
    
    [engine enqueueOperation:op];
    */
}


- (NSMutableDictionary *)handlerWithParamsDic:(NSDictionary *)dic sign:(BOOL)sign{
    
    NSMutableDictionary * params=[NSMutableDictionary dictionaryWithDictionary:dic];
    [params setObject:kIOS_CLIENT forKey:@"client"];        //before signed
    
    //需要签名的
    if (sign) {
        NSString * sign = [SignedAlgo getSignWithDic:params];
        [params setObject:sign forKey:@"sign"];
        
        if ([DataCenter shared].curUserID != nil) {
            [params setObject:[DataCenter shared].curUserID forKey:@"u"];
        }
    }
    
    [params setObject:[self unixtime] forKey:@"timestamp"];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    [params setObject: [infoDictionary objectForKey:@"CFBundleVersion"] forKey:@"v"];
    
    return params;
}


//特殊签名，登录跟获取手机验证码时调用
- (NSMutableDictionary *)handlerSpecialParamsDic:(NSDictionary *)dic{
    
    NSMutableDictionary * params=[NSMutableDictionary dictionaryWithDictionary:dic];
    
    [params setObject:kIOS_CLIENT forKey:@"client"];
    [params setObject:[self unixtime] forKey:@"timestamp"];
    [params setObject:[self signtime] forKey:@"sign"];      //这一项不同。
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    [params setObject: [infoDictionary objectForKey:@"CFBundleVersion"] forKey:@"v"];
    
    return params;
}

-(NSString *)unixtime
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval ad=[dat timeIntervalSince1970];
    NSString *timeSp = [NSString stringWithFormat:@"%.0f", ad];//转为字符型
    
    int s = [[timeSp substringFromIndex:timeSp.length-3] intValue];
    
    if(s == 0){
        ad++;
    }
    timeSp = [NSString stringWithFormat:@"%.0f", ad]; //转为字符型
    
    return timeSp;
}

-(NSString *)signtime
{
    NSString *timeSp=[self unixtime];
    
    //sign: 需要特殊处理，已删掉
    return sign;
}

@end