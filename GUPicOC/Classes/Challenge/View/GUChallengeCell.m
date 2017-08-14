//
//  GUChallengeCell.m
//  GUPicOC
//
//  Created by Recluse on 2017/7/25.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "GUChallengeCell.h"

@interface GUChallengeCell()

@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *awardLabel;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UILabel *sponsorLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;


@end

@implementation GUChallengeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homeCellBackground"]];
    
}

- (void)setChallenge:(GUChallenge *)challenge {
    
    GULog(@"%@", challenge.APP_CHALLENGE_NAME);
    _challenge = challenge;
    NSString *theme = @"主题:";
    self.themeNameLabel.text = [theme stringByAppendingString:challenge.APP_CHALLENGE_NAME];
    NSString *award = @"奖金:";
    self.awardLabel.text = [award stringByAppendingString:challenge.APP_CHALLENGE_AWARD];
    [self.imageButton setBackgroundImage:[UIImage imageNamed:challenge.APP_CHALLENGE_BACKURL] forState:UIControlStateNormal];
    NSString *sponsor = @"发起人:";
    self.sponsorLabel.text = [sponsor stringByAppendingString:challenge.APP_CHALLENGE_SPONSOR];
    NSString *endtime = @"结束时间:";
    self.endTimeLabel.text = [endtime stringByAppendingString:challenge.APP_CHALLENGE_ENDTIME];
    
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
