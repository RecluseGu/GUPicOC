//
//  MMImageManager.m
//  MMScanPic
//
//  Created by 王腾飞 on 2017/4/24.
//  Copyright © 2017年 王腾飞. All rights reserved.
//

#import "MMImageManager.h"

@implementation MMImageManager

//返回裁剪区域图片,返回裁剪区域大小图片
+ (UIImage *)clipWithImageRect:(CGRect)clipRect clipImage:(UIImage *)clipImage
{
//    
//    CGFloat rate = clipImage.size.width / [UIScreen mainScreen].bounds.size.width;
////    CGFloat height = clipImage.size.height * rate;
//    
////    UIImage *rescaleImage = [MMImageManager rescaleImage:clipImage ToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, height)];
//    
//    UIGraphicsBeginImageContext(clipImage.size);
//    
//    [clipImage drawInRect:CGRectMake(clipRect.origin.x * rate, clipRect.origin.y * rate ,clipRect.size.width * rate,clipRect.size.height * rate)];
//    
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return  newImage;
    
    // 开启位图上下文

//    CGImageRef imageRef = CGImageCreateWithImageInRect([clipImage CGImage], CGRectMake(clipRect.origin.x, clipRect.origin.y * rate, clipRect.size.width * rate, clipRect.size.height * rate));
//    UIImage *res = [UIImage imageWithCGImage:imageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
//    CGImageRelease(imageRef);
//    return res;
    CIImage *imageRef = [[CIImage alloc]initWithImage:clipImage];
    CIImage *resultImage = [imageRef imageByCroppingToRect:CGRectMake(0, clipRect.origin.y, clipRect.size.height, clipRect.size.width)];
    return [UIImage imageWithCIImage:resultImage];
//    //imageView的宽高比
//    CGFloat imageViewWidthHeightRatio = clipRect.size.width / clipRect.size.height;
//    //屏幕分辨率
//    //    CGFloat imageScale = [[UIScreen mainScreen] scale];
//    
//    CGFloat imageScale = 1;
//    
//    CGFloat imageWith = clipImage.size.width*imageScale;
//    
//    CGFloat imageHeight = clipImage.size.height*imageScale;
//    
//    //image的宽高比
//    CGFloat imageWidthHeightRatio = imageWith / imageHeight;
//    
//    CGImageRef imageRef = nil;
//    
//    CGRect rect;
//    
//    //    NSLog(@"\nimageWith === %f\nimageHeight === %f\nImageView宽高比 == %f\nimageScale == %f",imageWith,imageHeight,imageViewWidthHeightRatio,imageScale);
//    
//    
//    if (imageWidthHeightRatio>imageViewWidthHeightRatio) {
//        
//        rect = CGRectMake((imageWith-imageHeight*imageViewWidthHeightRatio)/2, 0, imageHeight*imageViewWidthHeightRatio, imageHeight);
//        
//    }else if (imageWidthHeightRatio<imageViewWidthHeightRatio) {
//        
//        rect = CGRectMake(0, (imageHeight-imageWith/imageViewWidthHeightRatio)/2, imageWith, imageWith/imageViewWidthHeightRatio);
//        
//    }else {
//        rect = CGRectMake(0, 0, imageWith, imageHeight);
//    }
//    
//    imageRef = CGImageCreateWithImageInRect([clipImage CGImage], rect);
//    UIImage *res = [UIImage imageWithCGImage:imageRef scale:imageScale orientation:UIImageOrientationUp];
//    
//    /**
//     一定要，千万要release，否则等着内存泄露吧，稍微高清点的图一张图就是几M内存，很快App就挂了
//     */
//    CGImageRelease(imageRef);
//    return res;
}

+ (UIImage *)clipImageWithImage:(UIImage *)image inRect:(CGRect)rect {
  CGSize imageSize = image.size;
  // 中间最大正方形尺寸
  CGRect centerRect;
  CGFloat centerRectWH;
  
  //根据图片的大小计算出图片中间矩形区域的位置与大小
   if (imageSize.width > imageSize.height) {
       centerRectWH = imageSize.height;
       float leftMargin = (imageSize.width - imageSize.height) * 0.5;
       centerRect = CGRectMake(leftMargin,0,centerRectWH,centerRectWH);
    }else{
       centerRectWH = imageSize.width;
       float topMargin = (imageSize.height - imageSize.width)*0.5;
       centerRect = CGRectMake(0,topMargin,centerRectWH,centerRectWH);
    }
   
  CGImageRef imageRef = image.CGImage;
  //在最大正方形尺寸范围内截取
  CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, centerRect);
  UIImage *tmp = [[UIImage alloc] initWithCGImage:imageRefRect];
  CGImageRelease(imageRefRect);// tmp是截取之后的image
   return tmp;
}

@end
