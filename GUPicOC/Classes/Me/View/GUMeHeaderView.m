//
//  GUMeHeaderView.m
//  GUPicOC
//
//  Created by Recluse on 2017/7/19.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "GUMeHeaderView.h"

@interface GUMeHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userDescription;
@property (weak, nonatomic) IBOutlet UILabel *statusNum;
@property (weak, nonatomic) IBOutlet UILabel *followNum;
@property (weak, nonatomic) IBOutlet UILabel *fansNum;

@property (weak, nonatomic) IBOutlet UIButton *meCenterBtn;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (weak, nonatomic) IBOutlet UIButton *fansBtn;

@end

@implementation GUMeHeaderView

+(instancetype)loadFromNib {
    
    return [[NSBundle mainBundle] loadNibNamed:@"GUMeHeaderView" owner:nil options:nil].lastObject;
    
}

- (void)setUserDefaults:(NSUserDefaults *)userDefaults {
    _userDefaults = userDefaults;
    self.headImage.image = [UIImage imageNamed:[userDefaults stringForKey:@"APP_USER_IMAGEURL"]];
    self.userName.text = [userDefaults stringForKey:@"APP_USER_NAME"];
    
    NSString *motto = @"简介:";
    self.userDescription.text = [motto stringByAppendingString:[userDefaults stringForKey:@"APP_USER_MOTTO"]];
    self.statusNum.text = [userDefaults stringForKey:@"STATUS_NUM"];
    self.followNum.text = [userDefaults stringForKey:@"FOLLOW_NUM"];
    self.fansNum.text = [userDefaults stringForKey:@"FANS_NUM"];
    
    [self addAction];
    
}

- (void) addAction {
    
    [self.meCenterBtn addTarget:self action:@selector(jumpToMeCenterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.statusBtn addTarget:self action:@selector(jumpToStatusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.followBtn addTarget:self action:@selector(jumpToFollowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.fansBtn addTarget:self action:@selector(jumpToFansBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)jumpToMeCenterBtnClick:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(jumpToMeCenterVC:)]) {
        [self.delegate jumpToMeCenterVC:sender];
    }
}

- (void)jumpToStatusBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(jumpToStatusVC:)]) {
        [self.delegate jumpToStatusVC:sender];
    }
}
- (void)jumpToFollowBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(jumpToFollowVC:)]) {
        [self.delegate jumpToFollowVC:sender];
    }
}
- (void)jumpToFansBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(jumpToFansVC:)]) {
        [self.delegate jumpToFansVC:sender];
    }
}

@end
