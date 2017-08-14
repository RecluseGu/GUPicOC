//
//  UserInfoCell.m
//  GUPicOC
//
//  Created by Recluse on 2017/7/19.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "UserInfoCell.h"

@interface UserInfoCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIButton *editInfoButton;

@end

@implementation UserInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = GYLBGColor;
        
        [self addSubview:self.nameLabel];
        [self addSubview:self.infoLabel];
        [self addSubview:self.editInfoButton];
    }
    return self;
}


- (void)setUserDefaults:(NSUserDefaults *)userDefaults {
    
    _userDefaults = userDefaults;
    self.nameLabel.text = [userDefaults objectForKey:@"APP_USER_NAME"];
    self.infoLabel.text = [userDefaults objectForKey:@"APP_USER_MOTTO"];
    
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        _nameLabel.center = CGPointMake(kScreenWidth / 2, 60);
        _nameLabel.textAlignment = 1;
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return _nameLabel;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        _infoLabel.center = CGPointMake(kScreenWidth / 2, 99);
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.backgroundColor = [UIColor clearColor];
        _infoLabel.textColor = [UIColor darkTextColor];
        _infoLabel.numberOfLines = 0;
        _infoLabel.font = [UIFont systemFontOfSize:11];
    }
    return _infoLabel;
}

- (UIButton *)editInfoButton {
    if (!_editInfoButton) {
        _editInfoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _editInfoButton.frame = CGRectMake(0, 0, 86, 27);
        _editInfoButton.center = CGPointMake(kScreenWidth / 2, 145);
        [_editInfoButton setTitle:@"编辑个人资料" forState:UIControlStateNormal];
        _editInfoButton.titleLabel.font = [UIFont boldSystemFontOfSize:11];
        [_editInfoButton setTitleColor:HEXCOLOR(0x88e47a) forState:UIControlStateNormal];
        _editInfoButton.layer.borderColor = HEXCOLOR(0x88e47a).CGColor;
        _editInfoButton.layer.cornerRadius = 2;
        _editInfoButton.layer.borderWidth = 0.5f;
        [_editInfoButton addTarget:self action:@selector(handleEditAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editInfoButton;
}

- (void)handleEditAction:(UIButton *)sender {
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
