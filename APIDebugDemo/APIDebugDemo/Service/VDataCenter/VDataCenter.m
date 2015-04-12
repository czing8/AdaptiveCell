//
//  VDataCenter.m
//  APIDebugDemo
//
//  Created by Vols on 15/4/12.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import "VDataCenter.h"

#define kUserID             @"userid"
#define kLoginStatus        @"loginstatus"

@implementation VDataCenter

+ (VDataCenter *)shared{
    
    static VDataCenter *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (id)init{
    self = [super init];
    
    if (self) {
    }
    return self;
}

- (void)clearData{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLoginStatus];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"nickname"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phone"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)clearAllData{
    NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    
    for(NSString* key in [dictionary allKeys]){
        [[NSUserDefaults standardUserDefaults]  removeObjectForKey:key];
        [[NSUserDefaults standardUserDefaults]  synchronize];
    }
}

#pragma mark setter/getter

- (void)setLoginStatus:(BOOL)loginStatus{
    
    [[NSUserDefaults standardUserDefaults] setBool:loginStatus forKey:kLoginStatus];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)loginStatus{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kLoginStatus];
}

- (NSString *)curUserID{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserID];
}

- (void)setCurUserID:(NSString *)curUserID{
    [[NSUserDefaults standardUserDefaults] setObject:curUserID forKey:kUserID];
}


- (NSString *)curPassword{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
}


- (void)setCurPassword:(NSString *)curPassword{
    [[NSUserDefaults standardUserDefaults] setObject:curPassword forKey:@"password"];
}


- (void)setLatitude:(NSString *)latitude{
    [[NSUserDefaults standardUserDefaults] setObject:latitude forKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)latitude{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"];
}


- (void)setLongitude:(NSString *)longitude{
    [[NSUserDefaults standardUserDefaults] setObject:longitude forKey:@"longitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)longitude{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"];
}



@end
