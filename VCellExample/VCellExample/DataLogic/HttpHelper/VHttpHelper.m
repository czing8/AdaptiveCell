//
//  VHttpHelper.m
//  VCellExample
//
//  Created by Vols on 2015/10/25.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import "VHttpHelper.h"
#import <AFNetworking.h>

@interface VHttpHelper()

@property (nonatomic, strong) NSURLSessionDownloadTask * downloadTask;

@end

@implementation VHttpHelper

+ (id)shared {
    
    static VHttpHelper *_sharedClient = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        _sharedClient = [[self alloc] init];
    });
    
    return _sharedClient;
}

- (void)post:(NSDictionary *)data path:(NSString *)path success:(SuccessBlock)success failue:(FailureBlock)failure{
    
    NSString * hostURL = kQSBaseURL;
    
    NSMutableDictionary * params = [self handlerWithParamsDic:data];
    
    AFHTTPSessionManager *manager = [VHttpHelper managerWithBaseURL:hostURL sessionConfiguration:NO];
    
    NSLog(@"request path: %@, parameters --> %@", path, params);
    
    [manager POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject == nil)
            success(@{@"code":@"-100",@"message":@"没有返回数据，可能服务器错误"});
        else
            success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"error --> %@", error);
    }];
}

- (void)get:(NSDictionary *)data path:(NSString *)path success:(SuccessBlock)success failue:(FailureBlock)failure{
    
    NSString * hostURL = kQSBaseURL;
    
    NSMutableDictionary * params = [self handlerWithParamsDic:data];
    
    AFHTTPSessionManager *manager = [VHttpHelper managerWithBaseURL:hostURL sessionConfiguration:NO];
    
    NSLog(@"request path: %@, parameters --> %@", path, params);
    
    [manager GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if (responseObject == nil)
             success(@{@"code":@"-100",@"message":@"没有返回数据，可能服务器错误"});
         else
             success(responseObject);
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         failure(error);
         NSLog(@"error --> %@", error);
     }];
}


- (NSURLSessionDownloadTask *)down:(NSString *)downURL percent:(PercentBlock)percent success:(void (^)(id, id))success failue:(FailureBlock)failure{
    
    AFHTTPSessionManager *manager = [VHttpHelper managerWithBaseURL:nil sessionConfiguration:YES];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:downURL]];
    
    NSURLSessionDownloadTask *downloadtask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        percent(downloadProgress.fractionCompleted);
        NSLog(@"localizedDescription = %@",downloadProgress.localizedDescription);
        NSLog(@"localizedAdditionalDescription = %@",downloadProgress.localizedAdditionalDescription);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            failure(error);
        }else{
            success(response,filePath);
        }
    }];
    
    [downloadtask resume];
    
    _downloadTask = downloadtask;
    return downloadtask;
}



- (void)cancel{
    [_downloadTask cancel];
}

#pragma mark - Private

- (NSMutableDictionary *)handlerWithParamsDic:(NSDictionary *)dic{
    
    if (dic == nil) {
        return nil;
    }
    
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    return params;
}

+ (AFHTTPSessionManager *)managerWithBaseURL:(NSString *)URLString  sessionConfiguration:(BOOL)isconfiguration{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFHTTPSessionManager *manager = nil;
    
    NSURL *baseURL = [NSURL URLWithString:URLString];
    
    if (isconfiguration) {
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:configuration];
    }else{
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    }
    
    //    manager.requestSerializer = [AFJSONResponseSerializer serializer];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];//报接受类型不一致替换为一致text/html或别的

    return manager;
}



@end
