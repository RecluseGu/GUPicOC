//
//  GUTabBar.h
//  GUPicOC
//
//  Created by Recluse on 2017/7/17.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GUTabBar;

@protocol GUTabBarDelegate <NSObject>

- (void)tabBarDidClickAtCenterButton:(GUTabBar *)tabbar;

@end

@interface GUTabBar : UITabBar

@property(nonatomic, weak) id<GUTabBarDelegate> delegate;

@end
