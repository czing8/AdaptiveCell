//
//  VDateTools.m
//  VCellExample
//
//  Created by Vols on 2015/10/26.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import "VDateTools.h"

@implementation VDateTools

+ (NSString *)dateStringFromTimeInterval:(NSString *)timestamp {
    NSDate *theDate = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]];
    return  [self stringFromDate:theDate];
}

//zz
+ (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+ (NSDate *)dateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}


@end
