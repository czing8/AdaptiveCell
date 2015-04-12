//
//  VDataCenter.h
//  APIDebugDemo
//
//  Created by Vols on 15/4/12.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VDataCenter : NSObject

@property (nonatomic, assign) BOOL loginStatus;     //登陆状态

@property (nonatomic, strong) NSString * curUserID;
@property (nonatomic, strong) NSString * curPassword;

@property (nonatomic, strong) NSString * latitude;     //纬度
@property (nonatomic, strong) NSString * longitude;

+ (VDataCenter *)shared;

- (void) clearData;     //清除指定的NSUserDefaults数据。
- (void) clearAllData;  //清除所有的NSUserDefaults数据，包括 引导页 标志。

@end
