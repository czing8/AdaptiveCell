//
//  VDateTools.h
//  VCellExample
//
//  Created by Vols on 2015/10/26.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VDateTools : NSObject

+ (NSString *)dateStringFromTimeInterval:(NSString *)timestamp;
+ (NSString *)stringFromDate:(NSDate *)date;               //data -> string
+ (NSDate *)dateFromString:(NSString *)dateString;         //string -> data

@end
