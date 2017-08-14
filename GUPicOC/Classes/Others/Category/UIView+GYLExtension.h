//
//  UIView+GYLExtension.h
//  GUBaiSI
//
//  Created by 永亮 谷 on 7/21/16.
//  Copyright © 2016 Recluse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GYLExtension)

@property(nonatomic,assign)CGFloat gyl_x;
@property(nonatomic,assign)CGFloat gyl_y;

@property(nonatomic,assign)CGFloat gyl_width;
@property(nonatomic,assign)CGFloat gyl_height;

@property(nonatomic,assign)CGSize gyl_size;

@property(nonatomic,assign)CGPoint gyl_origin;

@property(nonatomic,assign)CGFloat gyl_centerX;
@property(nonatomic,assign)CGFloat gyl_centerY;
@property(nonatomic,assign)CGPoint gyl_center;

@property(nonatomic, assign)CGFloat gyl_right;
@property(nonatomic, assign)CGFloat gyl_bottom;



- (void)addClickedBlock:(void(^)(id obj))tapAction;

@end
