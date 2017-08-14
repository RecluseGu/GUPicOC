//
//  GUStatusCell.m
//  GUPicOC
//
//  Created by Recluse on 2017/7/23.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "GUStatusCell.h"

@interface GUStatusCell()

@property (weak, nonatomic) IBOutlet UIImageView *userHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusPictureView;
@property (weak, nonatomic) IBOutlet UIButton *zanButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;


@end

@implementation GUStatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homeCellBackground"]];
    
    self.autoresizingMask = UIViewAutoresizingNone;
    self.statusPictureView.userInteractionEnabled = YES;
    
    [self.statusPictureView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictureImageClick)]];
}


- (void)setStatus:(GUStatus *)status {
    
    _status = status;
    self.userHeadImageView.image = [UIImage imageNamed:status.APP_USER_IMAGEURL];
    self.userNameLabel.text = status.APP_USER_NAME;
    self.postTimeLabel.text = status.APP_STATUS_POSTTIME;
    self.statusTextLabel.text = status.APP_STATUS_CONTENT;
    
//    [self.zanButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
//    [self.zanButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
//    
//    [self.commentButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
//    [self.commentButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
//    
//    [self.collectButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
//    [self.collectButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    
    [self setupButtonTitle:self.zanButton number:status.ZAN_NUM placeholder:@"赞"];
    [self setupButtonTitle:self.commentButton number:status.COMMENT_NUM placeholder:@"评论"];
    [self setupButtonTitle:self.collectButton number:status.COLLECT_NUM placeholder:@"收藏"];
    
    self.statusPictureView.frame = status.pictureFrame;
    self.statusPictureView.image = [UIImage imageNamed:status.APP_STATUS_PICTURE];
    
    
}

- (void)pictureImageClick {
    GULog(@"pictureClick to big image");
}

- (void)setupButtonTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}
    
- (IBAction)moreClick:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    if (![GUUserHelper isUserLogin]) {
        [alert addAction:[UIAlertAction actionWithTitle:@"添加关注" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            GULog(@"关注");
        }]];
    }
    
    [alert addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        GULog(@"收藏");
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        GULog(@"分享");
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消关注" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        GULog(@"取消关注");
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        GULog(@"举报");
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        GULog(@"取消");
    }]];
    
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    
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
