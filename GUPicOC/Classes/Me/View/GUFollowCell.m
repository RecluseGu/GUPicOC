//
//  GUFollowCell.m
//  GUPicOC
//
//  Created by Recluse on 2017/8/3.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "GUFollowCell.h"

@interface GUFollowCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIButton *userNameBtn;
@property (weak, nonatomic) IBOutlet UILabel *mottoLabel;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;

@end

@implementation GUFollowCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)folllowBtnClick:(id)sender {
    
    [self.followBtn setSelected:!self.followBtn.isSelected];
    

    if (self.followBtn.isSelected) {
        self.followBtn.backgroundColor = GYLCOLOR(83, 187, 54);
        [self.followBtn.layer setMasksToBounds:YES];
        [self.followBtn.layer setCornerRadius:3];
        [self.followBtn.layer setBorderWidth:0];
        [self.followBtn setTitle:@"关注" forState:UIControlStateNormal] ;
        [self.followBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        [self.followBtn.layer setMasksToBounds:YES];
        [self.followBtn.layer setCornerRadius:3];
        [self.followBtn.layer setBorderWidth:1.0];
        [self.followBtn.layer setBorderColor:GYLCOLOR(213, 213, 213).CGColor];
        self.followBtn.backgroundColor = [UIColor whiteColor];
        if (self.followBtn.tag == 11) {
            [self.followBtn setTitle:@"互相关注" forState:UIControlStateNormal];
        } else if(self.followBtn.tag == 12) {
            [self.followBtn setTitle:@"已关注" forState:UIControlStateNormal];
        } else if (self.followBtn.tag == 13) {
            [self.followBtn setTitle:@"互相关注" forState:UIControlStateNormal];
        }
        
        [self.followBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
   
    
}

- (void)setFollowUser:(GUAppUser *)followUser {
    _followUser = followUser;
    
        self.headImage.image = [UIImage imageNamed:followUser.APP_USER_IMAGEURL];
        [self.userNameBtn setTitle:followUser.APP_USER_NAME forState:UIControlStateNormal];
        self.mottoLabel.text = followUser.APP_USER_MOTTO;
        GULog(@"%@: %@", followUser.APP_USER_NAME, followUser.APP_USER_FOLLOW);
        
        if ([followUser.APP_USER_FOLLOW isEqualToString:@"1"]) {
            // 1 互相关注
            [self.followBtn.layer setMasksToBounds:YES];
            [self.followBtn.layer setCornerRadius:3];
            [self.followBtn.layer setBorderWidth:1.0];
            [self.followBtn.layer setBorderColor:GYLCOLOR(213, 213, 213).CGColor];
            [self.followBtn setTitle:@"互相关注" forState:UIControlStateNormal];
            self.followBtn.tag = 11;
        }else if ([followUser.APP_USER_FOLLOW isEqualToString:@"0"]){
            // 0 已关注
            [self.followBtn.layer setMasksToBounds:YES];
            [self.followBtn.layer setCornerRadius:3];
            [self.followBtn.layer setBorderWidth:1.0];
            [self.followBtn.layer setBorderColor:GYLCOLOR(213, 213, 213).CGColor];
            [self.followBtn setTitle:@"已关注" forState:UIControlStateNormal];
            self.followBtn.tag = 12;
        }else if ([followUser.APP_USER_FOLLOW isEqualToString:@"2"]){
            // 2 未关注
            self.followBtn.backgroundColor = GYLCOLOR(83, 187, 54);
            [self.followBtn.layer setMasksToBounds:YES];
            [self.followBtn.layer setCornerRadius:3];
            [self.followBtn.layer setBorderWidth:0];
            [self.followBtn setTitle:@"关注" forState:UIControlStateNormal] ;
            [self.followBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.followBtn setSelected:YES];
            self.followBtn.tag = 13;
        }
}

- (void)setFrame:(CGRect)frame {
    frame.size.height -= 10;
    frame.origin.y += 10;
    
    [super setFrame: frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
