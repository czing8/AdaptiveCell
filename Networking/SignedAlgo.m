//
//  SignedAlgo.m
//  SANQUAN
//
//  Created by Vols on 14-10-22.
//  Copyright (c) 2014年 SANQUAN. All rights reserved.
//

#import "SignedAlgo.h"

#import "NSString+MKNetworkKitAdditions.h"

@implementation SignedAlgo

NSInteger alphabeticSort(id string1, id string2, void *reverse)
{
    if (*(BOOL *)reverse == YES) {
        return [string2 localizedCaseInsensitiveCompare:string1];
    }
    return [string1 localizedCaseInsensitiveCompare:string2];
}


+ (NSString *)getSignWithDic:(NSMutableDictionary *)parameterDic
{
//    BOOL reverseSort = NO;  //正序排列
    
    NSArray *keyArray= [parameterDic allKeys];
//    keyArray= [keyArray sortedArrayUsingFunction:alphabeticSort context:&reverseSort];
    
/*
    签名算法
 
 */
    return urlMD5;
}

@end
