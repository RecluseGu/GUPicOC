//
//  GUVisitorView.h
//  GUPicOC
//
//  Created by Recluse on 2017/7/19.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VisitorJumpDelegate <NSObject>

- (void)jumpToLoginVC:(UIButton *)sender;

@end

@interface GUVisitorView : UIView

@property(nonatomic, weak) id<VisitorJumpDelegate> delegate;

- (void)setInfoWithImageName:(NSString *)imageName descTitle:(NSString *)descTitle;

+(instancetype)loadFromNib;

@end
