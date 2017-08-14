//
//  MMCameraViewController.h
//  MMScanPic
//
//  Created by 王腾飞 on 2017/4/23.
//  Copyright © 2017年 王腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMCameraViewController : UIViewController
/**
 * 设置要接受最后选取的图片数组的UIViewController
 * 设置该值后续接受JSSelectedCompleteDelegete, 并实现其代理方法
 * - (void)selectedPhotosComplete:(NSArray <UIImage *>*)photoList;
 */
@property (nonatomic, strong)id delegate;
@end
