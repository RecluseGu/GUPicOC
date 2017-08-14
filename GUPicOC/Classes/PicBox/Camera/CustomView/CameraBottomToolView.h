//
//  CameraBottomToolView.h
//  MMScanPic
//
//  Created by 王腾飞 on 2017/4/23.
//  Copyright © 2017年 王腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CameraBottomDelegate <NSObject>

//- (void)browsePhoto;
- (void)shutterCamera;

@end

@interface CameraBottomToolView : UIView
@property (nonatomic, assign)id<CameraBottomDelegate>delagate;
//@property (nonatomic, strong)UIImage *poster;
@end
