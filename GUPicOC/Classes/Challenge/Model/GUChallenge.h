//
//  GUChallenge.h
//  GUPicOC
//
//  Created by Recluse on 2017/7/25.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GUChallenge : NSObject

@property (nonatomic, copy) NSString *APP_CHALLENGE_NAME;
@property (nonatomic, copy) NSString *APP_CHALLENGE_AWARD;
@property (nonatomic, copy) NSString *APP_CHALLENGE_BACKURL;
@property (nonatomic, copy) NSString *APP_CHALLENGE_SPONSOR;
@property (nonatomic, copy) NSString *APP_CHALLENGE_ENDTIME;

@property (nonatomic, assign) CGFloat cellHeight;

@end
