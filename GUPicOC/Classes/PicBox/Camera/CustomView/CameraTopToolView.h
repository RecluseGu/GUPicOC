//
//  CameraTopToolView.h
//  MMScanPic
//
//  Created by 王腾飞 on 2017/4/23.
//  Copyright © 2017年 王腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    StyleCameraRatio_1_1,
    Style_camera_ratio_3_4,
    Style_camera_ratio_full,
} StyleCameraRatio;


@protocol CameraTopToolDelgate <NSObject>

- (void)closeCamera;
- (void)reverseCamera:(BOOL)isOn;
- (void)flashCamera:(BOOL)isOn;
- (void)cameraRatio:(StyleCameraRatio)ratio;
@end

@interface CameraTopToolView : UIView
@property (nonatomic, assign)id<CameraTopToolDelgate>delgate;
@property (nonatomic, assign)StyleCameraRatio ratio;
@end
