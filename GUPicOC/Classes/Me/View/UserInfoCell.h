//
//  UserInfoCell.h
//  GUPicOC
//
//  Created by Recluse on 2017/7/19.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GUAppUser.h"

#define HEXCOLOR(hexValue) [UIColor colorWithRed : ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0 green : ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0 blue : ((CGFloat)(hexValue & 0xFF)) / 255.0 alpha : 1.0]
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface UserInfoCell : UITableViewCell

@property(nonatomic, strong) NSUserDefaults* userDefaults;

@end
