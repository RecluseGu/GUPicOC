//
//  UITextField+GYLExtension.m
//  GUBaiSI
//
//  Created by 永亮 谷 on 7/27/16.
//  Copyright © 2016 Recluse. All rights reserved.
//

#import "UITextField+GYLExtension.h"

static NSString * const GYLPLACEHOLDERKEY = @"placeholderLabel.textColor";

@implementation UITextField (GYLExtension)

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    //placeholderLabel是采用懒加载的方式创建的，通过以下方式保证无论何时使用该属性都能使颜色修改成功
    // 提前设置占位文字, 目的 : 让它提前创建placeholderLabel
    NSString *oldPlaceholder = self.placeholder;
    self.placeholder = @" ";
    self.placeholder = oldPlaceholder;
    
    // 恢复到默认的占位文字颜色
    if (placeholderColor == nil) {
        placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    
    // 设置占位文字颜色
    [self setValue:placeholderColor forKeyPath:GYLPLACEHOLDERKEY];

    
}


- (UIColor *)placeholderColor
{
    return [self valueForKeyPath:GYLPLACEHOLDERKEY];
}

@end
