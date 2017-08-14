//
//  GUHomeViewController.m
//  GUPicOC
//
//  Created by Recluse on 2017/7/17.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "GUHomeViewController.h"
#import "GYLTitleButton.h"
#import "GUFollowStatusTableViewController.h"
#import "GUHotStatusTableViewController.h"
#import <AFHTTPSessionManager.h>


@interface GUHomeViewController () <UIScrollViewDelegate>

@property(nonatomic, weak)GYLTitleButton *selectedButton;
@property(nonatomic, weak)UIView *underView;
@property(nonatomic, weak)UIScrollView *scrollView;
@property(nonatomic, weak)UIView *titlesView;

@end

@implementation GUHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = GYLBGColor;
    
    //self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navi_toolbox" highImage:@"navi_toolbox_highlighted" target:self action:@selector(searchClick)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navi_discover" highImage:@"navi_discover_highlighted" target:self action:@selector(toolBoxClick)];

    
    [self setupChildControllers];
    [self setupScrollView];
    [self setupTitlesView];
    
    [self addChildVCView];
    
    //[self loadStatus];
    
}

- (void)searchClick {
    GULog(@"search Click");
}

- (void)toolBoxClick {
    GULog(@"toolbox Click");
}

/*
- (void) loadStatus {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [responseObject writeToFile:@"/Users/Recluse/Desktop/new_topics.plist" atomically:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        GULog(@"请求失败 - %@", error);
        
    }];
    
}
 */

- (void)setupChildControllers
{
    GUFollowStatusTableViewController *all = [[GUFollowStatusTableViewController alloc] init];
    [self addChildViewController:all];
    
    GUHotStatusTableViewController *video = [[GUHotStatusTableViewController alloc] init];
    [self addChildViewController:video];
    
}


- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = GYLBGColor;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //set frame
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    scrollView.delegate = self;
    
    [self.view addSubview:scrollView];
    
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * scrollView.gyl_width, 0);
    
    
    self.scrollView = scrollView;
}

- (void)setupTitlesView
{
    NSArray *titles = @[@"关注",@"热门"];
    UIView *titlesView = [[UIView alloc] init];
    
    titlesView.frame = CGRectMake(0, 0, ScreenWidth / 6 * titles.count, 35);
    self.titlesView = titlesView;
    self.navigationItem.titleView = titlesView;

    
    CGFloat buttonW = ScreenWidth / 6;
    CGFloat buttonH = titlesView.gyl_height;
    
    for (NSUInteger i = 0; i < titles.count; i++) {
        
        GYLTitleButton *button = [GYLTitleButton buttonWithType:UIButtonTypeCustom];
        
        button.tag = i;
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [titlesView addSubview:button];
        
        [button setTitle:titles[i] forState:UIControlStateNormal];
        
        button.frame = CGRectMake(i * buttonW, 0, buttonW, buttonH);
    }
    
    GYLTitleButton *firstButton = titlesView.subviews.firstObject;
    
    UIView *underView = [[UIView alloc] init];
    
    underView.gyl_height = 2;
    underView.gyl_y = titlesView.gyl_height - underView.gyl_height;
    underView.backgroundColor = [UIColor orangeColor];
    
    [titlesView addSubview:underView];
    
    self.underView = underView;
    
    // 立刻根据文字内容计算label的宽度
    [firstButton.titleLabel sizeToFit];
    underView.gyl_width = firstButton.titleLabel.gyl_width - 10;
    underView.gyl_centerX = firstButton.gyl_centerX;
    
    // 默认情况 : 选中最前面的标题按钮
    firstButton.selected = YES;
    self.selectedButton = firstButton;
    
}

- (void)buttonClick:(GYLTitleButton *)titleButton
{
    self.selectedButton.selected = NO;
    titleButton.selected = YES;
    self.selectedButton = titleButton;
    
    [UIView animateWithDuration:0.1 animations:^{
        
        self.underView.gyl_width = titleButton.titleLabel.gyl_width - 10;
        self.underView.gyl_centerX = titleButton.gyl_centerX;
        
    }];
    
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = titleButton.tag * self.scrollView.gyl_width;
    [self.scrollView setContentOffset:offset animated:YES];
    
    
}

- (void)addChildVCView
{
    NSUInteger index = self.scrollView.contentOffset.x / self.scrollView.gyl_width;
    UIViewController *childVC = self.childViewControllers[index];
    
    if (childVC.view.superview) return;
    
    childVC.view.frame = self.scrollView.bounds;
    //    self.scrollView.contentOffset = self.scrollView.bounds.origin;
    
    [self.scrollView addSubview:childVC.view];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildVCView];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger index = self.scrollView.contentOffset.x / self.scrollView.gyl_width;
    GYLTitleButton *button = self.titlesView.subviews[index];
    [self buttonClick:button];
    
    [self addChildVCView];
}
@end
