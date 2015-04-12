//
//  VConnection.h
//  APIDebugDemo
//
//  Created by Vols on 15/4/12.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kConnectMethodPost,
    kConnectMethodGet
}kConnectMethod;

typedef void (^RequestSuccess) (NSDictionary *object);
typedef void (^RequestFailed) (NSError *error);

@interface VConnection : NSObject

@property (nonatomic, copy) RequestSuccess success;
@property (nonatomic, copy) RequestFailed failed;

@property(nonatomic, readonly) kConnectMethod method;

- (id)initWithData:(NSDictionary *)data method:(kConnectMethod)method path:(NSString *)path;


- (kConnectMethod)method;

- (NSDictionary *)data;
- (NSString *)path;


- (void)didSuccess:(id)object;

- (void)didFailed:(NSError *)error;

@end
