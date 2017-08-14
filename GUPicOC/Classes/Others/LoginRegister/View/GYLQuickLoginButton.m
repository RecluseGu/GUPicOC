//
//  GYLQuickLoginButton.m
//  GUBaiSI
//
//  Created by 永亮 谷 on 7/21/16.
//  Copyright © 2016 Recluse. All rights reserved.
//

#import "GYLQuickLoginButton.h"
#import "UIView+GYLExtension.h"

@implementation GYLQuickLoginButton

 - (void)awakeFromNib
{
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.gyl_y = 0;
    self.imageView.gyl_centerX = self.gyl_width * 0.5;
    
    self.titleLabel.gyl_x = 0;
    self.titleLabel.gyl_y = self.imageView.gyl_height;
    self.titleLabel.gyl_width = self.gyl_width;
    self.titleLabel.gyl_height = self.gyl_height - self.imageView.gyl_height;
    
}


@end
