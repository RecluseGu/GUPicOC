//
//  MMMoveDrawView.h
//  CircleAnimation
//
//  Created by 王腾飞 on 2017/4/22.
//  Copyright © 2017年 王腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMMoveDrawView : UIView
- (instancetype)initWithFrame:(CGRect)frame pointList:(NSArray <NSValue *>*)pointList;
@property (nonatomic, strong, readonly)NSArray <NSValue *>*pointList;
@property (nonatomic, strong)UIImage *img;
@end
