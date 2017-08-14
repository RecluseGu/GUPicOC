//
//  GUUserHelper.m
//  GUPicOC
//
//  Created by Recluse on 2017/7/19.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "GUUserHelper.h"

@implementation GUUserHelper

+ (BOOL)isUserLogin {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefaults objectForKey:@"APP_USER_NAME"];
    if (userName != nil && userName != NULL) {
        return YES;
    }
    return NO;
}

@end
