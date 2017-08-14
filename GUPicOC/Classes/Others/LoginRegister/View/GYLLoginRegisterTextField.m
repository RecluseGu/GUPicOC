//
//  GYLLoginRegisterTextField.m
//  GUBaiSI
//
//  Created by 永亮 谷 on 7/27/16.
//  Copyright © 2016 Recluse. All rights reserved.
//

#import "GYLLoginRegisterTextField.h"
#import "UITextField+GYLExtension.h"

@interface GYLLoginRegisterTextField ()

@end

@implementation GYLLoginRegisterTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.tintColor = [UIColor whiteColor];      //设置光标颜色
    
    //修改默认占位符文字颜色
    self.placeholderColor = [UIColor grayColor];
    
}

- (BOOL)becomeFirstResponder
{
    self.placeholderColor = [UIColor whiteColor];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    self.placeholderColor = [UIColor grayColor];
    return [super resignFirstResponder];
}

@end
