//
//  VHttpHelper.h
//  VCellExample
//
//  Created by Vols on 2015/10/25.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock)(id responseObject);
typedef void (^FailureBlock)(NSError *error);

typedef void (^PercentBlock)(float percent);



@interface VHttpHelper : NSObject

+ (id)shared;

- (void)post:(NSDictionary *)data path:(NSString *)path success:(SuccessBlock)success failue:(FailureBlock)failure;
- (void)get:(NSDictionary *)data path:(NSString *)path success:(SuccessBlock)success failue:(FailureBlock)failure;

- (NSURLSessionDownloadTask *)down:(NSString *)URL percent:(PercentBlock)percent success:(void(^)(id flag, id filePath))success failue:(FailureBlock)failure;

- (void)cancel;

@end
