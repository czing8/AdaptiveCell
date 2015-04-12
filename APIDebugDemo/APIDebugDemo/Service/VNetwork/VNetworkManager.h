//
//  VNetworkManager.h
//  APIDebugDemo
//
//  Created by Vols on 15/4/12.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VConnection.h"

@interface VNetworkManager : NSObject

+ (id)sharedClient;

- (void)processOperation:(VConnection *)connection sign:(BOOL)sign;       //是否加签名sign


@end
