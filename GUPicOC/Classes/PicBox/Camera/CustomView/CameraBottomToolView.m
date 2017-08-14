//
//  CameraBottomToolView.m
//  MMScanPic
//
//  Created by 王腾飞 on 2017/4/23.
//  Copyright © 2017年 王腾飞. All rights reserved.
//

#import "CameraBottomToolView.h"


@interface CameraBottomToolView ()
//@property (nonatomic, strong)UIButton *allPhotoBtn;
//@property (nonatomic, strong)UIImageView *imageView;
@end
@implementation CameraBottomToolView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat albumBtnSize = 68;
        //CGFloat albumSize = 45;
        UIButton *albumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        albumBtn.frame = CGRectMake((self.frame.size.width - albumBtnSize) / 2, (self.frame.size.height - albumBtnSize) / 2, albumBtnSize, albumBtnSize);
        [albumBtn setImage:[UIImage imageNamed:@"photograph"] forState: UIControlStateNormal];
        [albumBtn setImage:[UIImage imageNamed:@"photograph_Select"] forState:UIControlStateNormal];
        [albumBtn addTarget:self action:@selector(shutterCamera) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:albumBtn];
        
        /*
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMinY(albumBtn.frame) + (albumBtnSize - albumSize) / 2, albumSize, albumSize)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        _imageView.layer.cornerRadius = 3;
        _imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _imageView.layer.borderWidth = 2;
        _imageView.userInteractionEnabled = YES;
        [self addSubview:_imageView];
        
        UIButton *allPhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        allPhotoBtn.frame = CGRectMake(0, 0, albumSize, albumSize);
        [allPhotoBtn addTarget:self action:@selector(browsePhoto) forControlEvents:UIControlEventTouchUpInside];
        [allPhotoBtn setTitle:@"相册" forState:UIControlStateNormal];
        allPhotoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [allPhotoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        allPhotoBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        [_imageView addSubview:allPhotoBtn];
        _allPhotoBtn = allPhotoBtn;
         */

    }
    return self;
}

- (void)shutterCamera {
    if ([self.delagate respondsToSelector:@selector(shutterCamera)]) {
        [self.delagate shutterCamera];
    }
}

/*
- (void)browsePhoto {
    if ([self.delagate respondsToSelector:@selector(browsePhoto)]) {
        [self.delagate browsePhoto];
    }

}


- (void)setPoster:(UIImage *)poster {
    _imageView.image = poster;
}
 */
@end
