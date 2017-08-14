//
//  UIBarButtonItem+GUExtension.h
//  GUPicOC
//
//  Created by Recluse on 2017/7/17.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (GUExtension)

+ (instancetype)itemWithImage: (NSString *)image highImage:(NSString *)highImage target:(id) target action:(SEL) action;

@end
