//
//  ViewController.m
//  APIDebugDemo
//
//  Created by Vols on 15/4/12.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import "ViewController.h"
#import <NSString+MKNetworkKitAdditions.h>
#import "VNetworkFunc.h"
#import "VDataCenter.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



- (IBAction)loginAction:(id)sender {
    [self loginRequest];
}


- (IBAction)registerAction:(id)sender {
    
}


#pragma mark - httpRequest

- (void)loginRequest{
    
    NSDictionary * dict = @{@"username":@"15701235332", @"userpass":[[@"111111" md5] md5]};
    
    [[VNetworkFunc sharedIntance] postFunc:dict path:@"user/login" sign:NO completion:^(id flag, NSError *error) {
        NSDictionary * dict = (NSDictionary *)flag;
        NSLog(@"Login success, --> %@", dict);
        
        if ([dict[@"code"] intValue] == 200) {
            [VDataCenter shared].curUserID = dict[@"data"][@"user_id"];
            [VDataCenter shared].curPassword = [[@"111111" md5] md5];
        }
        else{
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:dict[@"message"] delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
