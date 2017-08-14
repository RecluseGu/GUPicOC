//
//  GUMessageViewController.m
//  GUPicOC
//
//  Created by Recluse on 2017/7/17.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "GUMessageViewController.h"
#import "GUVisitorView.h"
#import "GYLLoginRegisterViewController.h"
#import "WRCellView.h"

#define WRCellViewHeight  60
#define WRCellViewTitleHeight  25

@interface GUMessageViewController () <VisitorJumpDelegate>

@property (nonatomic, strong) UIScrollView* containerView;
@property(nonatomic, strong)WRCellView* followCellView;
@property(nonatomic, strong)WRCellView* commentCellView;
@property(nonatomic, strong)WRCellView* favourCellView;

@end

@implementation GUMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
    
    if ([GUUserHelper isUserLogin]) {
        
        self.containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, self.view.bounds.size.height)];
        self.containerView.backgroundColor = GYLBGColor;
        self.containerView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight + 100);
        self.automaticallyAdjustsScrollViewInsets = NO;
        [self.view addSubview:self.containerView];
        
        [self addViews];
        [self setCellFrame];
        [self onClickEvent];
        
    } else {
        GUVisitorView *visitorView = [GUVisitorView loadFromNib];
        visitorView.frame = self.view.frame;
        visitorView.backgroundColor = GYLBGColor;
        [visitorView setInfoWithImageName:@"visitordiscover_image_message" descTitle:@"登陆后，别人评论、点赞、收藏您的图片，都会在这里收到通知"];
        visitorView.delegate = self;
        self.view = visitorView;
    }

}

- (void)addViews {
    [self.containerView addSubview:self.followCellView];
    [self.containerView addSubview:self.commentCellView];
    [self.containerView addSubview:self.favourCellView];
}

- (void)setCellFrame {
    self.followCellView.frame = CGRectMake(0, 0, ScreenWidth, WRCellViewHeight);
    self.commentCellView.frame = CGRectMake(0, _followCellView.gyl_bottom, ScreenWidth, WRCellViewHeight);
    self.favourCellView.frame = CGRectMake(0, _commentCellView.gyl_bottom, ScreenWidth, WRCellViewHeight);
}

- (void)onClickEvent {
    __weak typeof(self) weakSelf = self;
    
    self.followCellView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        [pThis openNewVCWithTitle:@"关注"];
    };
    
    self.commentCellView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        [pThis openNewVCWithTitle:@"评论"];
    };
    
    self.favourCellView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        [pThis openNewVCWithTitle:@"赞"];
    };
}

- (void)openNewVCWithTitle:(NSString *)title
{
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = GYLBGColor;
    vc.title = title;
    [self.navigationController pushViewController:vc animated:YES];
}


- (WRCellView *)followCellView {
    if (_followCellView == nil) {
        _followCellView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_Indicator];
        _followCellView.leftLabel.text = @"关注";
        _followCellView.leftIcon.image = [UIImage imageNamed:@"messagescenter_follow"];
        [_followCellView setLineStyleWithLeftZero];
    }
    return _followCellView;
}

- (WRCellView *)commentCellView {
    if (_commentCellView == nil) {
        _commentCellView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_Indicator];
        _commentCellView.leftLabel.text = @"评论";
        _commentCellView.leftIcon.image = [UIImage imageNamed:@"messagescenter_comments"];
        [_commentCellView setLineStyleWithLeftZero];
    }
    return _commentCellView;
}

- (WRCellView *)favourCellView {
    if (_favourCellView == nil) {
        _favourCellView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_Indicator];
        _favourCellView.leftLabel.text = @"赞";
        _favourCellView.leftIcon.image = [UIImage imageNamed:@"messagescenter_good"];
        [_favourCellView setLineStyleWithLeftZero];
    }
    return _favourCellView;
}


- (void)jumpToLoginVC:(UIButton *)sender {
    
    [self presentViewController:[[GYLLoginRegisterViewController alloc] init] animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
