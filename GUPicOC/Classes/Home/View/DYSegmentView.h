//
//  DYSegmentView.h
//  DYScrollSegmentDemo
//
//  Created by Daniel Yao on 17/4/10.
//  Copyright © 2017年 Daniel Yao. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol DYSegmentDelegate;
@interface DYSegmentView : UIView
//segment 文字数组
@property(nonatomic,strong)NSArray *titleArray;
//segment 文字颜色
@property(nonatomic,strong)UIColor *titleNormalColor;
//segment 选中时文字颜色
@property(nonatomic,strong)UIColor *titleSelectColor;
//segment 文字字体，默认15
@property(nonatomic,strong)UIFont  *titleFont;
//segment 默认选中按钮/视图 1
@property(nonatomic,assign)NSInteger defaultSelectIndex;
//segment 点击按钮触发事件代理
@property(nonatomic,assign)id<DYSegmentDelegate> delegate;

//视图偏移时，控件随着发生变化
-(void)dyDidScrollChangeTheTitleColorWithContentOfSet:(CGFloat)width;

@end

@protocol DYSegmentDelegate <NSObject>

@required
-(void)dySegment:(DYSegmentView *)segment didSelectIndex:(NSInteger)index;
@end
