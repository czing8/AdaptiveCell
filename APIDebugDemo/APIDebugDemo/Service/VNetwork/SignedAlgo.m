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
    
    keyArray = [keyArray sortedArrayUsingSelector:@selector(compare:)];
    NSString *parametersStr = @"";
    
    for (int i = 0; i< [keyArray count]; i++){
        
        NSString *keyStr = [keyArray objectAtIndex:i];
        NSString *valueStr = [parameterDic objectForKey:keyStr];

        NSString *keyandvalue = [[NSString alloc]initWithFormat:@"%@%@",keyStr,valueStr];
        parametersStr = [parametersStr stringByAppendingString:keyandvalue];
    }
    
    NSString * password = [kUSER_DEFAULT objectForKey:@"password"];
    
    NSString *signStr = [NSString stringWithFormat:@"%@%@%@",password, parametersStr, password];

    NSLog(@"signString --> %@", signStr);
    
    NSString * urlMD5 = [[signStr md5] uppercaseString];

    return urlMD5;
}

@end
