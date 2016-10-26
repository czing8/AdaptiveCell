//
//  ContentCell.h
//  VCellExample
//
//  Created by Vols on 2015/10/26.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import "ContentModel.h"

#define kContentCellIdentifier @"kContentCellIdentifier"

@interface ContentCell : UITableViewCell

@property (nonatomic,strong) ContentModel *model;

- (CGFloat)rowHeightWithCellModel:(ContentModel *)model;

@end
