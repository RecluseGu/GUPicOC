//
//  CameraTopToolView.m
//  MMScanPic
//
//  Created by 王腾飞 on 2017/4/23.
//  Copyright © 2017年 王腾飞. All rights reserved.
//

#import "CameraTopToolView.h"

@interface CameraTopToolView ()
@property (nonatomic, strong)UIButton *rationBtn;
@end

@implementation CameraTopToolView
- (instancetype)initWithFrame:(CGRect)frame
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 4;

    self = [super initWithFrame:frame];
    if (self) {
        UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
        close.frame = CGRectMake(0, 0, width, 50);
        [close setImage:[UIImage imageNamed:@"style_default_edit_button_cancel"] forState:UIControlStateNormal];
        [close addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:close];
        
        UIButton *reverse = [UIButton buttonWithType:UIButtonTypeCustom];
        reverse.frame = CGRectMake(CGRectGetMaxX(close.frame), 0, width, 50);
        [reverse setImage:[UIImage imageNamed:@"style_default_camera_button_switch"] forState:UIControlStateNormal];
        [reverse addTarget:self action:@selector(reverse:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:reverse];
        
        UIButton *ratio = [UIButton buttonWithType:UIButtonTypeCustom];
        ratio.frame = CGRectMake(CGRectGetMaxX(reverse.frame), 0, width, 50);
        [ratio setImage:[UIImage imageNamed:@"style_default_camera_ratio_1_1"] forState:UIControlStateNormal];
        [ratio addTarget:self action:@selector(ratio:) forControlEvents:UIControlEventTouchUpInside];
        _rationBtn = ratio;
        [self addSubview:ratio];
        _ratio = StyleCameraRatio_1_1;
        
        UIButton *flash = [UIButton buttonWithType:UIButtonTypeCustom];
        flash.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - width, 0, width, 50);
        [flash setImage:[UIImage imageNamed:@"style_default_camera_flash_off"] forState:UIControlStateNormal];
        [flash setImage:[UIImage imageNamed:@"style_default_camera_flash_on"] forState:UIControlStateSelected];
        [flash addTarget:self action:@selector(flash:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:flash];
        
    }
    return self;
}

- (void)close {
    if ([self.delgate respondsToSelector:@selector(closeCamera)]) {
        [self.delgate closeCamera];
    }
}

- (void)reverse:(UIButton *)btn {
    if ([self.delgate respondsToSelector:@selector(reverseCamera:)]) {
        [self.delgate reverseCamera:YES];
    }
}

- (void)flash:(UIButton *)btn {
    btn.selected = !btn.selected;
    if ([self.delgate respondsToSelector:@selector(flashCamera:)]) {
        [self.delgate flashCamera:btn.selected];
    }
}
- (void)ratio:(UIButton *)btn {
    if (_ratio == Style_camera_ratio_full) {
        _ratio = StyleCameraRatio_1_1;
        [_rationBtn setImage:[UIImage imageNamed:@"style_default_camera_ratio_1_1"] forState:UIControlStateNormal];
    }else if (_ratio == Style_camera_ratio_3_4) {
        _ratio = Style_camera_ratio_full;
        [_rationBtn setImage:[UIImage imageNamed:@"style_default_camera_ratio_orgin"] forState:UIControlStateNormal];
    }else if (_ratio == StyleCameraRatio_1_1) {
        _ratio = Style_camera_ratio_3_4;
        [_rationBtn setImage:[UIImage imageNamed:@"style_default_camera_ratio_3_4"] forState:UIControlStateNormal];
    }
    if ([self.delgate respondsToSelector:@selector(cameraRatio:)]) {
        [self.delgate cameraRatio:_ratio];
    }
}

@end
