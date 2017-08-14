//
//  GUAppUser.h
//  GUPicOC
//
//  Created by Recluse on 2017/7/20.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GUAppUser : NSObject

@property(nonatomic, copy) NSString *APP_USER_NAME;
@property(nonatomic, copy) NSString *APP_USER_PHONE;
@property(nonatomic, copy) NSString *APP_USER_PASSWORD;
@property(nonatomic, copy) NSString *APP_USER_MOTTO;
@property(nonatomic, copy) NSString *APP_USER_IMAGEURL;
@property(nonatomic, copy) NSString *APP_USER_FOLLOW;
@property(assign) int STATUS_NUM;
@property(assign) int FOLLOW_NUM;
@property(assign) int FANS_NUM;

@end
