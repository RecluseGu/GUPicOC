//
//  GUStatus.h
//  GUPicOC
//
//  Created by Recluse on 2017/7/22.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GUStatus : NSObject

@property (nonatomic, copy) NSString *APP_USER_NAME;
@property (nonatomic, copy) NSString *APP_USER_IMAGEURL;
@property (nonatomic, copy) NSString *APP_STATUS_CONTENT;
@property (nonatomic, copy) NSString *APP_STATUS_PICTURE;
@property (nonatomic, copy) NSString *APP_STATUS_POSTTIME;
@property (nonatomic, assign) NSInteger ZAN_NUM;
@property (nonatomic, assign) NSInteger COMMENT_NUM;
@property (nonatomic, assign) NSInteger COLLECT_NUM;

//图片真实宽度 高度
@property (nonatomic, assign) CGFloat IMAGE_WIDTH;
@property (nonatomic, assign) CGFloat IMAGE_HEIGHT;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect pictureFrame;

@end
