//
//  Adaptive1Controller.h
//  VCellExample
//
//  Created by Vols on 2015/10/25.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, kAdaptiveCellType) {
    kAdaptiveCellTypeiOS7,         //手动
    kAdaptiveCellTypeiOS8          //iOS自动处理
};

@interface Adaptive1Controller : UIViewController

@property (nonatomic, assign) kAdaptiveCellType adaptiveCellType;

@end
