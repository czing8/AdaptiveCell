//
//  UserModel.h
//  VCellExample
//
//  Created by Vols on 2015/10/26.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import "JSONModel.h"

@interface UserModel : JSONModel

@property (nonatomic,copy) NSString *avatar_updated_at; //
@property (nonatomic,copy) NSString *uid;               //
@property (nonatomic,copy) NSString *last_visited_at;   //
@property (nonatomic,copy) NSString *created_at;        //
@property (nonatomic,copy) NSString *state;             //
@property (nonatomic,copy) NSString *last_device;       //
@property (nonatomic,copy) NSString *role;              //
@property (nonatomic,copy) NSString *login;             //
@property (nonatomic,assign) int id;                    //
@property (nonatomic,copy) NSString *icon;              //

@end
