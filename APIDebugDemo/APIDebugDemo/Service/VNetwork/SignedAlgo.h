//
//  SignedAlgo.h
//  SANQUAN
//
//  Created by Vols on 14-10-22.
//  Copyright (c) 2014年 SANQUAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignedAlgo : NSObject

+ (NSString *)getSignWithDic:(NSMutableDictionary *)parameterDic;

@end
