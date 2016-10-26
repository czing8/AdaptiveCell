//
//  Content2Cell.h
//  VCellExample
//
//  Created by Vols on 2015/10/26.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import "ContentModel.h"

#define kContent2CellIdentifier @"kContent2CellIdentifier"

@interface Content2Cell : UITableViewCell

@property (nonatomic,strong) ContentModel *model;

@end
