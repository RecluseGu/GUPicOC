//
//  MMPhotoViewController.h
//  MMScanPic
//
//  Created by 王腾飞 on 2017/4/23.
//  Copyright © 2017年 王腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMPhotoViewController : UIViewController
@property (nonatomic, strong)UIImage *image;
@property (nonatomic, assign)CGRect frame;
@property (nonatomic, copy)void(^retakeBlock)();
@end
