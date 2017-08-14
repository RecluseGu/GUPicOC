//
//  GUVisitorView.m
//  GUPicOC
//
//  Created by Recluse on 2017/7/19.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "GUVisitorView.h"

@interface GUVisitorView()

@property (weak, nonatomic) IBOutlet UIImageView *vcImageView;
@property (weak, nonatomic) IBOutlet UILabel *vcDescLabel;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation GUVisitorView

+(instancetype)loadFromNib {
    
    return [[NSBundle mainBundle] loadNibNamed:@"GUVisitorView" owner:nil options:nil].lastObject;
    
}

- (void)setInfoWithImageName:(NSString *)imageName descTitle:(NSString *)descTitle {
    
    self.vcImageView.image = [UIImage imageNamed:imageName];
    self.vcDescLabel.text = descTitle;
    [self.vcDescLabel setFont:[UIFont systemFontOfSize:14]];
    [self.vcDescLabel setTextColor:[UIColor lightGrayColor]];
    [self.registerButton addTarget:self action:@selector(loginRegBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)loginRegBtnClick:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(jumpToLoginVC:)]) {
        [self.delegate jumpToLoginVC:sender];
    }
    
}


@end
