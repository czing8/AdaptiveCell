//
//  ContentModel.m
//  VCellExample
//
//  Created by Vols on 2015/10/26.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import "ContentModel.h"
#import "ContentCell.h"

@implementation ContentModel

- (NSNumber *)cellHeight {

    if(!_cellHeight){
        ContentCell *cell=[[ContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kContentCellIdentifier];
         _cellHeight = [NSNumber numberWithFloat:[cell rowHeightWithCellModel:self]];
    }
    
    return _cellHeight;
}

//设置所有属性为可选（必须状态接口返回值为null会报错）
+(BOOL)propertyIsOptional:(NSString*)propertyName{
    return YES;
}


@end
