//
//  MMPhotoViewController.m
//  MMScanPic
//
//  Created by 王腾飞 on 2017/4/23.
//  Copyright © 2017年 王腾飞. All rights reserved.
//

#import "MMPhotoViewController.h"
#import "MMImageManager.h"
#import "UIImage+GUExtension.h"

@interface MMPhotoViewController ()
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, assign)BOOL isSave;
@end

@implementation MMPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = GYLCOLOR(38, 38, 37);
    self.navigationController.navigationBarHidden = YES;
    
    UIImage *fixImage = [_image fixOrientation];
    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    _imageView.backgroundColor = [UIColor redColor];
    _imageView.image = fixImage;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.clipsToBounds = YES;
    [self.view addSubview:_imageView];
    
    
    UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
    close.frame = CGRectMake(0, 0, 50, 50);
    [close setImage:[UIImage imageNamed:@"style_default_filter_back"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:close];
    
    
    UIButton *savePhoto = [UIButton buttonWithType:UIButtonTypeCustom];
    savePhoto.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 64, 64, 64);
    [savePhoto setImage:[UIImage imageNamed:@"style_default_filter_online"] forState:UIControlStateNormal];
    [savePhoto addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:savePhoto];
}

- (void)save {
    if (_isSave) {
//        [UIView showTipsWithHUD:@"图片已经保存" showTime:1];
        return;
    }
//    UIImage *resultImage = [MMImageManager clipWithImageRect:self.frame clipImage:_image];
//    UIImage *resultImage = [MMImageManager clipImageWithImage:_image inRect:self.frame];
    UIImage *fixImage = [_image fixOrientation];

    UIImageWriteToSavedPhotosAlbum(fixImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
//    _imageView.image = resultImage;
}
// 指定回调方法

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败";
//        [UIView showTipsWithHUD:msg showTime:1];
    }else{
        msg = @"保存图片成功";
//        [UIView showTipsWithHUD:msg showTime:1];
        _isSave = YES;
    }
}
- (void)dismiss {
    if (_retakeBlock) {
        _retakeBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
