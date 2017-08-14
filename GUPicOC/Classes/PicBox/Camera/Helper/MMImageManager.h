//
//  MMImageManager.h
//  MMScanPic
//
//  Created by 王腾飞 on 2017/4/24.
//  Copyright © 2017年 王腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MMImageManager : NSObject
+ (UIImage *)clipWithImageRect:(CGRect)clipRect clipImage:(UIImage *)clipImage;
+ (UIImage*) clipImageWithImage:(UIImage*)image inRect:(CGRect)rect;
@end
