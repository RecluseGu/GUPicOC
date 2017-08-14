//
//  MMCameraConfig.m
//  MMScanPic
//
//  Created by 王腾飞 on 2017/4/24.
//  Copyright © 2017年 王腾飞. All rights reserved.
//

#import "MMCameraConfig.h"


@implementation MMCameraConfig
@synthesize maxCount = _maxCount;
+(instancetype)shareConfig{
    static MMCameraConfig *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MMCameraConfig alloc] init];
    });
    return instance;
}
- (CGFloat)ratio_1_1_point_y {
    return 120;
}
- (CGFloat)ratio_1_1_width {
    return [UIScreen mainScreen].bounds.size.width;
}
- (CGFloat)ratio_1_1_height {
    return [UIScreen mainScreen].bounds.size.width;
}


- (CGFloat)ratio_3_4_point_y {
    return 64;
}
- (CGFloat)ratio_3_4_width {
    return [UIScreen mainScreen].bounds.size.width;
}
- (CGFloat)ratio_3_4_height {
    return [UIScreen mainScreen].bounds.size.width * (4 / 3.0);
}

- (CGFloat)ratio_full_point_y {
    return 0;
}
- (CGFloat)ratio_full_width {
    return [UIScreen mainScreen].bounds.size.width;
}
- (CGFloat)ratio_full_height {
    return [UIScreen mainScreen].bounds.size.height;
}

- (void)setMaxCount:(NSInteger)maxCount {
    _maxCount = maxCount;
}
- (NSInteger)maxCount {
    return _maxCount ?: 9;
}
@end
