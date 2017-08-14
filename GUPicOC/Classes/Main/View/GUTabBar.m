//
//  GUTabBar.m
//  GUPicOC
//
//  Created by Recluse on 2017/7/17.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "GUTabBar.h"

@interface GUTabBar ()

@property(nonatomic, weak)UIButton *composeButton;

@end

@implementation GUTabBar


// 懒加载 就不用initWIthFrame方法
- (UIButton *)composeButton {
    if(!_composeButton) {
        UIButton *composeButton = [[UIButton alloc] init];
        [composeButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [composeButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [composeButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateSelected];
        [composeButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateSelected];
        
        [composeButton addTarget:self action:@selector(composeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:composeButton];
        _composeButton = composeButton;
    }
    return _composeButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setupAllTabBarButtonsFrame];
    [self setupPublishButtonFrame];
    
}

- (void)setupAllTabBarButtonsFrame
{
    int index = 0;
    
    for (UIView *tabBarButton in self.subviews) {
        
        if (tabBarButton.class  != NSClassFromString(@"UITabBarButton")) continue;
        
        [self setupSingleTabBarButtonFrame:tabBarButton atIndex:index];
        
        index ++;
    }
}


- (void)setupPublishButtonFrame
{
    
    self.composeButton.gyl_width = self.gyl_width / 5;
    self.composeButton.gyl_height = self.gyl_height;
    self.composeButton.gyl_center = CGPointMake(self.gyl_width * 0.5, self.gyl_height * 0.5);
}

- (void)setupSingleTabBarButtonFrame:(UIView *)tabBarButton atIndex:(int)index
{
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    CGFloat buttonX;
    
    if (index >= 2) {
        buttonX = buttonW * (index + 1);
    }else
    {
        buttonX = buttonW * index;
    }
    
    tabBarButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
}

- (void)composeButtonClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarDidClickAtCenterButton:)]) {
        [self.delegate tabBarDidClickAtCenterButton:self];
    }
}

@end
