//
//  GUStatusPublishController.m
//  GUPicOC
//
//  Created by Recluse on 2017/8/5.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "GUStatusPublishController.h"
#import "WRCellView.h"

#define MainCellViewHeight  45

@interface GUStatusPublishController ()

@property (nonatomic, strong) UIScrollView* containerView;
@property (nonatomic, strong) WRCellView* addTagView;
@property (nonatomic, strong) WRCellView* addPositionView;
@property (nonatomic, strong) WRCellView* shareWeiboView;
@property (nonatomic, strong) UISwitch *weiboSwitch;
@property (nonatomic, strong) WRCellView* shareWeixinView;
@property (nonatomic, strong) UISwitch *weixinSwitch;
@property (nonatomic, strong) WRCellView* shareQQZoneView;
@property (nonatomic, strong) UISwitch *qqSwitch;


@end

@implementation GUStatusPublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分享动态";
    self.view.backgroundColor = GYLBGColor;
    
    [[UINavigationBar appearance] setTintColor:[UIColor orangeColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(clostBtnClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(publishBtnClick)];
    
    self.containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHeight)];
    self.containerView.backgroundColor = GYLBGColor;
    self.containerView.contentSize = CGSizeMake(ScreenWidth, self.view.gyl_height);
    self.containerView.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.containerView];
    
    [self addContainerSubViews];
    [self setContainerSubViewFrame];
    
    [self addSwitchToWeiboView];
    [self addSwitchToWeixinView];
    [self addSwitchToqqZoneView];

    
}
- (void) addContainerSubViews {
    
    
    [self.containerView addSubview:self.addTagView];
    [self.containerView addSubview:self.addPositionView];
    [self.containerView addSubview:self.shareWeiboView];
    [self.containerView addSubview:self.shareWeixinView];
    [self.containerView addSubview:self.shareQQZoneView];
    
}

- (void) setContainerSubViewFrame {
    
    self.addTagView.frame = CGRectMake(0, 150, ScreenWidth, MainCellViewHeight);
    
    self.addPositionView.frame = CGRectMake(0, self.addTagView.gyl_bottom + 10, ScreenWidth, MainCellViewHeight);
    
    self.shareWeiboView.frame = CGRectMake(0, self.addPositionView.gyl_bottom + 10, ScreenWidth, MainCellViewHeight);
    self.shareWeixinView.frame = CGRectMake(0, self.shareWeiboView.gyl_bottom, ScreenWidth, MainCellViewHeight);
    self.shareQQZoneView.frame = CGRectMake(0, self.shareWeixinView.gyl_bottom, ScreenWidth, MainCellViewHeight);
}

- (void)addSwitchToWeiboView
{
    self.weiboSwitch = [[UISwitch alloc] init];
    [self.shareWeiboView addSubview:self.weiboSwitch];
    CGRect frame = self.weiboSwitch.frame;
    frame.origin.x = ScreenWidth - frame.size.width - 16;
    frame.origin.y = (self.shareWeiboView.bounds.size.height - frame.size.height) / 2;
    self.weiboSwitch.frame = frame;
    self.weiboSwitch.on = YES;
}

- (void)addSwitchToWeixinView
{
    self.weixinSwitch = [[UISwitch alloc] init];
    [self.shareWeixinView addSubview:self.weixinSwitch];
    CGRect frame = self.weixinSwitch.frame;
    frame.origin.x = ScreenWidth - frame.size.width - 16;
    frame.origin.y = (self.shareWeixinView.bounds.size.height - frame.size.height) / 2;
    self.weixinSwitch.frame = frame;
//    self.weixinSwitch.on = YES;
}

- (void)addSwitchToqqZoneView
{
    self.qqSwitch = [[UISwitch alloc] init];
    [self.shareQQZoneView addSubview:self.qqSwitch];
    CGRect frame = self.qqSwitch.frame;
    frame.origin.x = ScreenWidth - frame.size.width - 16;
    frame.origin.y = (self.shareQQZoneView.bounds.size.height - frame.size.height) / 2;
    self.qqSwitch.frame = frame;
    //    self.weixinSwitch.on = YES;
}

- (WRCellView *)addTagView {
    if (_addTagView == nil) {
        _addTagView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_Indicator];
        _addTagView.leftLabel.text = @"添加标签";
        _addTagView.leftIcon.image = [UIImage imageNamed:@"add_tag"];
        [_addTagView setHideBottomLine:YES];
    }
    return _addTagView;
}

- (WRCellView *)addPositionView {
    if (_addPositionView == nil) {
        _addPositionView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_Indicator];
        _addPositionView.leftLabel.text = @"添加地点";
        _addPositionView.leftIcon.image = [UIImage imageNamed:@"add_position"];
        [_addPositionView setHideBottomLine:YES];
    }
    return _addPositionView;
}

- (WRCellView *)shareWeiboView {
    if (_shareWeiboView == nil) {
        _shareWeiboView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_Icon];
        _shareWeiboView.leftLabel.text = @"新浪微博";
        _shareWeiboView.leftIcon.image = [UIImage imageNamed:@"share_sina"];
        [_shareWeiboView setLineStyleWithLeftEqualLabelLeft];
    }
    return _shareWeiboView;
}

- (WRCellView *)shareWeixinView {
    if (_shareWeixinView == nil) {
        _shareWeixinView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_Icon];
        _shareWeixinView.leftLabel.text = @"微信朋友圈";
        _shareWeixinView.leftIcon.image = [UIImage imageNamed:@"share_weixin"];
        [_shareWeixinView setLineStyleWithLeftEqualLabelLeft];
    }
    return _shareWeixinView;
}

- (WRCellView *)shareQQZoneView {
    if (_shareQQZoneView == nil) {
        _shareQQZoneView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_Icon];
        _shareQQZoneView.leftLabel.text = @"QQ空间";
        _shareQQZoneView.leftIcon.image = [UIImage imageNamed:@"share_qzone"];
        [_addPositionView setLineStyleWithLeftZero];
    }
    return _shareQQZoneView;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)clostBtnClick {
    
}

- (void)publishBtnClick {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分享" message:@"图片以保存，是否分享？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
