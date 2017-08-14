//
//  UIView+GYLExtension.m
//  GUBaiSI
//
//  Created by 永亮 谷 on 7/21/16.
//  Copyright © 2016 Recluse. All rights reserved.
//

#import "UIView+GYLExtension.h"
#import <objc/message.h>

@interface UIView ()

@property void(^clickedAction)(id);

@end


@implementation UIView (GYLExtension)

-(CGFloat)gyl_x
{
    return self.frame.origin.x;
}

-(void)setGyl_x:(CGFloat)gyl_x
{
    CGRect frame = self.frame;
    frame.origin.x = gyl_x;
    self.frame = frame;
}

-(CGFloat)gyl_y
{
    return self.frame.origin.y;
}

-(void)setGyl_y:(CGFloat)gyl_y
{
    CGRect frame = self.frame;
    frame.origin.y = gyl_y;
    self.frame = frame;
}

-(CGFloat)gyl_width
{
    return self.frame.size.width;
}

-(void)setGyl_width:(CGFloat)gyl_width
{
    CGRect frame = self.frame;
    frame.size.width = gyl_width;
    self.frame = frame;
}

-(CGFloat)gyl_height
{
    return self.frame.size.height;
}

-(void)setGyl_height:(CGFloat)gyl_height
{
    CGRect frame = self.frame;
    frame.size.height = gyl_height;
    self.frame = frame;
}

-(CGSize)gyl_size
{
    return self.frame.size;
}

-(void)setGyl_size:(CGSize)gyl_size
{
    CGRect frame = self.frame;
    frame.size.width = gyl_size.width;
    frame.size.height = gyl_size.height;
    self.frame = frame;
}

-(CGPoint)gyl_origin
{
    return self.frame.origin;
}

-(void)setGyl_origin:(CGPoint)gyl_origin
{
    CGRect frame = self.frame;
    frame.origin.x = gyl_origin.x;
    frame.origin.y = gyl_origin.y;
    self.frame = frame;
}

-(CGFloat)gyl_centerX
{
    return self.center.x;
}

-(void)setGyl_centerX:(CGFloat)gyl_centerX
{
    CGPoint center = self.center;
    center.x = gyl_centerX;
    self.center = center;
}

-(CGFloat)gyl_centerY
{
    return self.center.y;
}

-(void)setGyl_centerY:(CGFloat)gyl_centerY
{
    CGPoint center = self.center;
    center.y = gyl_centerY;
    self.center = center;
}

-(CGPoint)gyl_center
{
    return self.center;
}

-(void)setGyl_center:(CGPoint)gyl_center
{
    CGPoint center = self.center;
    center.x = gyl_center.x;
    center.y = gyl_center.y;
    self.center = gyl_center;
}

- (CGFloat)gyl_right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setGyl_right:(CGFloat)gyl_right
{
    self.gyl_x = gyl_right - self.gyl_width;
}

- (CGFloat)gyl_bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setGyl_bottom:(CGFloat)gyl_bottom
{
    self.gyl_y = gyl_bottom - self.gyl_height;
}


- (void)setClickedAction:(void (^)(id))clickedAction{
    objc_setAssociatedObject(self, @"AddClickedEvent", clickedAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(id))clickedAction{
    return objc_getAssociatedObject(self, @"AddClickedEvent");
}

- (void)addClickedBlock:(void(^)(id obj))clickedAction{
    self.clickedAction = clickedAction;
    // hy:先判断当前是否有交互事件，如果没有的话。。。所有gesture的交互事件都会被添加进gestureRecognizers中
    if (![self gestureRecognizers]) {
        self.userInteractionEnabled = YES;
        // hy:添加单击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
    }
}

- (void)tap{
    if (self.clickedAction) {
        self.clickedAction(self);
    }
}


@end
