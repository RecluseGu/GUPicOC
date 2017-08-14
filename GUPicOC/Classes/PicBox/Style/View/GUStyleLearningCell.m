//
//  GUStyleLearningCell.m
//  GUPicOC
//
//  Created by Recluse on 2017/8/4.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "GUStyleLearningCell.h"

@interface GUStyleLearningCell()

@property (weak, nonatomic) IBOutlet UIImageView *styleImageView;
@property (weak, nonatomic) IBOutlet UILabel *styleNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *styleStatusBtn;


@end

@implementation GUStyleLearningCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setStyle:(GUStyle *)style {
    
    _style = style;
    self.styleImageView.image = [UIImage imageNamed:style.APP_STYLE_IMAGE];
    self.styleNameLabel.text = style.APP_STYLE_NAME;
    self.styleStatusBtn.layer.masksToBounds = YES;
    [self.styleStatusBtn.layer setCornerRadius:3];
//    [self.styleStatusBtn.layer setBorderWidth:2.0];
//    [self.styleStatusBtn.layer setBorderColor:GYLCOLOR(213, 213, 213).CGColor];
    [self.styleStatusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if ([style.APP_STYLE_STATUS isEqualToString:@"1"]) {
        self.styleStatusBtn.backgroundColor = GYLCOLOR(83, 187, 54);
        [self.styleStatusBtn setTitle:@"使用" forState:UIControlStateNormal];
    } else {
        self.styleStatusBtn.backgroundColor = [UIColor brownColor];
        [self.styleStatusBtn setTitle:@"学习中" forState:UIControlStateNormal];
        self.styleStatusBtn.enabled = NO;
    }
    
}

- (void)setFrame:(CGRect)frame {
    frame.size.height -= 10;
    frame.origin.y += 10;
    
    [super setFrame: frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
