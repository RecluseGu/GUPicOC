//
//  GUFollowCell.h
//  GUPicOC
//
//  Created by Recluse on 2017/8/3.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GUAppUser.h"

@interface GUFollowCell : UITableViewCell

@property(nonatomic, strong) GUAppUser* followUser;
@property(nonatomic, strong) NSString* userType;

@end
