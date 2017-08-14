//
//  GUHeaderView.h
//  GUPicOC
//
//  Created by Recluse on 2017/7/19.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickHeaderBlock) ();

@interface GUHeaderView : UIView

/**
 * @property image: 头像图片
 */
@property (nonatomic, strong) UIImage *image;

/**
 * @property borderColor: 边框颜色
 */
@property (nonatomic, strong) UIColor *borderColor;


/**
 * 初始化方法
 */
- (instancetype)init;

/** 初始化方法
 * @param image 头像图片
 */
- (instancetype)initWithImage:(UIImage *)image;

/** 更新头像大小
 * @param scrollView 滚动视图
 */
- (void)reloadSizeWithScrollView:(UIScrollView *)scrollView;

/**
 * 点击头像回调
 */
- (void)handleClickActionWithBlock:(ClickHeaderBlock)block;

@end
