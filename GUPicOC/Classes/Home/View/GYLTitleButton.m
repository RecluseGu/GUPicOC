//
//  GYLTitleButton.m
//  GUBaiSI
//
//  Created by 永亮 谷 on 8/4/16.
//  Copyright © 2016 Recluse. All rights reserved.
//

#import "GYLTitleButton.h"

@implementation GYLTitleButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:GYLCOLOR(148, 148, 148) forState:UIControlStateNormal];
        [self setTitleColor:GYLCOLOR(48, 48, 48) forState:UIControlStateSelected];
        
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        
    }
    
    return self;
}

@end
