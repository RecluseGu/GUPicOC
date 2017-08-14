//
//  MMCameraConfig.h
//  MMScanPic
//
//  Created by 王腾飞 on 2017/4/24.
//  Copyright © 2017年 王腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MMCameraConfig : NSObject
+(instancetype)shareConfig;
@property (nonatomic, assign)CGFloat ratio_1_1_point_y;
@property (nonatomic, assign)CGFloat ratio_1_1_width;
@property (nonatomic, assign)CGFloat ratio_1_1_height;

@property (nonatomic, assign)CGFloat ratio_3_4_point_y;
@property (nonatomic, assign)CGFloat ratio_3_4_width;
@property (nonatomic, assign)CGFloat ratio_3_4_height;

@property (nonatomic, assign)CGFloat ratio_full_point_y;
@property (nonatomic, assign)CGFloat ratio_full_width;
@property (nonatomic, assign)CGFloat ratio_full_height;

@property (nonatomic, assign)NSInteger maxCount;
@end
