//
//  GUMeHeaderView.h
//  GUPicOC
//
//  Created by Recluse on 2017/7/19.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GUAppUser.h"

@protocol MineJumpToMeCenterDelegate <NSObject>


- (void)jumpToMeCenterVC:(UIButton *)sender;
- (void)jumpToStatusVC:(UIButton *)sender;
- (void)jumpToFollowVC:(UIButton *)sender;
- (void)jumpToFansVC:(UIButton *)sender;

@end


@interface GUMeHeaderView : UIView

@property(nonatomic, weak) id<MineJumpToMeCenterDelegate> delegate;
@property(nonatomic, strong) NSUserDefaults* userDefaults;

+ (instancetype) loadFromNib;

@end
