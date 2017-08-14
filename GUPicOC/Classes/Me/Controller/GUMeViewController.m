//
//  GUMeViewController.m
//  GUPicOC
//
//  Created by Recluse on 2017/7/17.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "GUMeViewController.h"
#import "GUVisitorView.h"
#import "GYLLoginRegisterViewController.h"
#import "GUMeHeaderView.h"
#import "GUAppUser.h"
#import "WRCellView.h"
#import "GUMeCenterViewController.h"
#import "GUStatusViewController.h"
#import "GUFollowViewController.h"
#import "GUFansViewController.h"

#define SeCellViewHeight  10
#define MainCellViewHeight  45

@interface GUMeViewController () <VisitorJumpDelegate, MineJumpToMeCenterDelegate>

@property (nonatomic, strong) UIScrollView* containerView;

@property (nonatomic, strong) GUMeHeaderView* headerView;


@property(nonatomic, strong)WRCellView* myPhotos;
@property(nonatomic, strong)WRCellView* myCollections;
@property(nonatomic, strong)WRCellView* myChallenges;

@property(nonatomic, strong)WRCellView* vipCellView;
@property(nonatomic, strong)WRCellView* shopCellView;

//@property(nonatomic, strong)WRCellView* nightPattern;
@property(nonatomic, strong)WRCellView* shareApp;
@property(nonatomic, strong)WRCellView* helpAndSuggest;
@property(nonatomic, strong)WRCellView* giveScroe;

@end

@implementation GUMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigation];
    
    if ([GUUserHelper isUserLogin]) {
        
        self.containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, self.view.bounds.size.height)];
        self.containerView.backgroundColor = GYLBGColor;
        self.containerView.contentSize = CGSizeMake(ScreenWidth, self.view.gyl_height + 100);
        self.containerView.showsVerticalScrollIndicator = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
        [self.view addSubview:self.containerView];
        
        GUMeHeaderView *headerView = [GUMeHeaderView loadFromNib];
        self.headerView = headerView;
        headerView.delegate = self;
        
        [self addContainerSubViews];
        [self setContainerSubViewFrame];
        
        //set data
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        self.headerView.userDefaults = userDefaults;
        
        
    } else {
        
        GUVisitorView *visitorView = [GUVisitorView loadFromNib];
        visitorView.frame = self.view.frame;
        visitorView.backgroundColor = GYLBGColor;
        [visitorView setInfoWithImageName:@"visitordiscover_image_profile" descTitle:@"登陆后，您的文字说说、相册、个人资料都会在这里展示"];
        visitorView.delegate = self;
        self.view = visitorView;

    }
}


- (void) addContainerSubViews {
    

    [self.containerView addSubview:self.headerView];

    [self.containerView addSubview:self.myPhotos];
    [self.containerView addSubview:self.myCollections];
    [self.containerView addSubview:self.myChallenges];

    [self.containerView addSubview:self.vipCellView];
    [self.containerView addSubview:self.shopCellView];

//    [self.containerView addSubview:self.nightPattern];
    [self.containerView addSubview:self.shareApp];
    [self.containerView addSubview:self.helpAndSuggest];
    [self.containerView addSubview:self.giveScroe];
    
}

- (void) setContainerSubViewFrame {
    
    self.headerView.frame = CGRectMake(0, 10, ScreenWidth, self.headerView.gyl_height);
    
    self.myPhotos.frame = CGRectMake(0, self.headerView.gyl_bottom + 10, ScreenWidth, MainCellViewHeight);
    self.myCollections.frame = CGRectMake(0, self.myPhotos.gyl_bottom, ScreenWidth, MainCellViewHeight);
    self.myChallenges.frame = CGRectMake(0, self.myCollections.gyl_bottom, ScreenWidth, MainCellViewHeight);
    
    self.vipCellView.frame = CGRectMake(0, self.myChallenges.gyl_bottom + 10, ScreenWidth, MainCellViewHeight);
    self.shopCellView.frame = CGRectMake(0, self.vipCellView.gyl_bottom, ScreenWidth, MainCellViewHeight);
    
//    self.nightPattern.frame = CGRectMake(0, self.seCellView4.gyl_bottom, ScreenWidth, MainCellViewHeight);
    self.shareApp.frame = CGRectMake(0, self.shopCellView.gyl_bottom + 10, ScreenWidth, MainCellViewHeight);
    self.helpAndSuggest.frame = CGRectMake(0, self.shareApp.gyl_bottom, ScreenWidth, MainCellViewHeight);
    self.giveScroe.frame = CGRectMake(0, self.helpAndSuggest.gyl_bottom, ScreenWidth, MainCellViewHeight);


    
}


- (void)setupNavigation {
    
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"me_setting_iconN" highImage:@"me_setting_icon_clickN" target:self action:@selector(settingClick)];
    self.navigationItem.rightBarButtonItem = settingItem;
    
}


- (WRCellView *)myPhotos {
    if (_myPhotos == nil) {
        _myPhotos = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_Indicator];
        _myPhotos.leftLabel.text = @"我的图片";
        _myPhotos.leftIcon.image = [UIImage imageNamed:@"me_photo"];
//        [_myPhotos setShowTopLine:YES];
        [_myPhotos setLineStyleWithLeftEqualLabelLeft];
    }
    return _myPhotos;
}

- (WRCellView *)myCollections {
    if (_myCollections == nil) {
        _myCollections = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_Indicator];
        _myCollections.leftLabel.text = @"收藏的图片";
        _myCollections.leftIcon.image = [UIImage imageNamed:@"me_collection"];
//        [_myCollections setShowTopLine:YES];
        [_myCollections setLineStyleWithLeftEqualLabelLeft];
    }
    return _myCollections;
}

- (WRCellView *)myChallenges {
    if (_myChallenges == nil) {
        _myChallenges = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_Indicator];
        _myChallenges.leftLabel.text = @"关注的挑战";
        _myChallenges.leftIcon.image = [UIImage imageNamed:@"me_challenge"];
//        [_myChallenges setShowTopLine:YES];
//        [_myChallenges setLineStyleWithLeftZero];
        [_myChallenges setHideBottomLine:YES];
    }
    return _myChallenges;
}

- (WRCellView *)vipCellView {
    if (_vipCellView == nil) {
        _vipCellView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_Indicator];
        _vipCellView.leftLabel.text = @"会员中心";
        _vipCellView.leftIcon.image = [UIImage imageNamed:@"me_vip"];
//        [_vipCellView setShowTopLine:YES];
        [_vipCellView setLineStyleWithLeftEqualLabelLeft];
    }
    return _vipCellView;
}

- (WRCellView *)shopCellView {
    if (_shopCellView == nil) {
        _shopCellView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_Indicator];
        _shopCellView.leftLabel.text = @"道具商城";
        _shopCellView.leftIcon.image = [UIImage imageNamed:@"me_shop"];
//        [_shopCellView setShowTopLine:YES];
//        [_shopCellView setLineStyleWithLeftZero];
        [_shopCellView setHideBottomLine:YES];
    }
    return _shopCellView;
}


- (WRCellView *)shareApp {
    if (_shareApp == nil) {
        _shareApp = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Indicator];
        _shareApp.leftLabel.text = @"分享PhotoWord";
    }
    return _shareApp;
}

- (WRCellView *)helpAndSuggest {
    if (_helpAndSuggest == nil) {
        _helpAndSuggest = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Indicator];
        _helpAndSuggest.leftLabel.text = @"帮助与反馈";
    }
    return _helpAndSuggest;
}

- (WRCellView *)giveScroe {
    if (_giveScroe == nil) {
        _giveScroe = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Indicator];
        _giveScroe.leftLabel.text = @"给PhotoWord评分";
        [_giveScroe setLineStyleWithLeftZero];
    }
    return _giveScroe;
}

- (void)jumpToLoginVC:(UIButton *)sender {
    
    [self presentViewController:[[GYLLoginRegisterViewController alloc] init] animated:YES completion:nil];
    
}

- (void)jumpToMeCenterVC:(UIButton *)sender {
    
    [self.navigationController pushViewController:[GUMeCenterViewController new] animated:YES];
}

- (void)jumpToStatusVC:(UIButton *)sender {
    
    [self.navigationController pushViewController:[GUStatusViewController new] animated:YES];
}

- (void)jumpToFollowVC:(UIButton *)sender {
    [self.navigationController pushViewController:[GUFollowViewController new] animated:YES];
}

- (void)jumpToFansVC:(UIButton *)sender {
    [self.navigationController pushViewController:[GUFansViewController new] animated:YES];
}

- (void)settingClick {
    GULog(@"settingClick");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
