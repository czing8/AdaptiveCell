//
//  VConnection.m
//  APIDebugDemo
//
//  Created by Vols on 15/4/12.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import "VConnection.h"

@interface VConnection(){
    kConnectMethod _method;
    NSDictionary *_data;
    NSString * _path;
}

@end

@implementation VConnection

- (id)initWithData:(NSDictionary *)data method:(kConnectMethod)method path:(NSString *)path{
    
    self = [super init];
    
    if (self) {
        _data = [data mutableCopy];
        _method = method;
        _path = path;
    }
    
    return self;
}

- (kConnectMethod)method {
    return _method;
}

- (NSDictionary *)data {
    return _data;
}

- (NSString *)path {
    return _path;
}

- (void)didSuccess:(NSDictionary *)object {
    
    if (_success) {
        _success(object);
    }
}

- (void)didFailed:(NSError *)error{
    if (_failed) {
        _failed(error);
    }
}



@end
