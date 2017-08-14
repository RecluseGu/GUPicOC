//
//  GUTabBarController.m
//  GUPicOC
//
//  Created by Recluse on 2017/7/17.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "GUTabBarController.h"
#import "GUNavigationController.h"
#import "GUTabBar.h"
#import "GUHomeViewController.h"
#import "GUMessageViewController.h"
#import "GUMeViewController.h"
#import "GUChallengeTableViewController.h"
#import "HyPopMenuView.h"
#import "popMenvTopView.h"
#import "MMCameraViewController.h"
#import "GUStyleLearningController.h"
#import "GUStatusPublishController.h"

@interface GUTabBarController () <GUTabBarDelegate, HyPopMenuViewDelegate>

@property (nonatomic, strong) HyPopMenuView* menu;

@end

@implementation GUTabBarController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = (id)self;
    
    [self setupAllChildViewControllers];
    [self setupCustomTabBar];
    
    [self loadMenu];
}

- (void)loadMenu {
    
    _menu = [HyPopMenuView sharedPopMenuManager];
    PopMenuModel *model1 = [PopMenuModel  allocPopMenuModelWithImageNameString:@"tabbar_compose_camera"
                                         AtTitleString:@"拍摄"
                                         AtTextColor:[UIColor grayColor]
                                         AtTransitionType:PopMenuTransitionTypeCustomizeApi
                                         AtTransitionRenderingColor:nil];
    PopMenuModel *model2 = [PopMenuModel  allocPopMenuModelWithImageNameString:@"tabbar_compose_photo"
                                          AtTitleString:@"相册"
                                          AtTextColor:[UIColor grayColor]
                                          AtTransitionType:PopMenuTransitionTypeCustomizeApi
                                          AtTransitionRenderingColor:nil];
    PopMenuModel *model3 = [PopMenuModel  allocPopMenuModelWithImageNameString:@"tabbar_compose_hua"
                                          AtTitleString:@"动态发布"
                                          AtTextColor:[UIColor grayColor]
                                          AtTransitionType:PopMenuTransitionTypeCustomizeApi
                                          AtTransitionRenderingColor:nil];
    PopMenuModel *model4 = [PopMenuModel  allocPopMenuModelWithImageNameString:@"tabbar_compose_pingtu"
                                          AtTitleString:@"拼图"
                                          AtTextColor:[UIColor grayColor]
                                          AtTransitionType:PopMenuTransitionTypeCustomizeApi
                                          AtTransitionRenderingColor:nil];
    PopMenuModel *model5 = [PopMenuModel  allocPopMenuModelWithImageNameString:@"tabbar_compose_style"
                                          AtTitleString:@"风格上传"
                                          AtTextColor:[UIColor grayColor]
                                          AtTransitionType:PopMenuTransitionTypeCustomizeApi
                                          AtTransitionRenderingColor:nil];
    
    PopMenuModel *model6 = [PopMenuModel  allocPopMenuModelWithImageNameString:@"tabbar_compose_haha"
                                          AtTitleString:@"哈哈镜"
                                          AtTextColor:[UIColor grayColor]
                                          AtTransitionType:PopMenuTransitionTypeCustomizeApi
                                          AtTransitionRenderingColor:nil];
    
    _menu.dataSource = @[ model1, model2, model3, model4, model5, model6 ];
    _menu.delegate = self;
    _menu.popMenuSpeed = 12.0f;
    _menu.automaticIdentificationColor = false;
    _menu.animationType = HyPopMenuViewAnimationTypeViscous;
    
    popMenvTopView* topView = [popMenvTopView popMenvTopView];
    topView.frame = CGRectMake(0, 44, CGRectGetWidth(self.view.frame), 92);
    _menu.topView = topView;
    
}


- (void)setupAllChildViewControllers {
    [self setupOneChildViewController:[[GUHomeViewController alloc] init] title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_highlighted"];
    [self setupOneChildViewController:[[GUChallengeTableViewController alloc] init] title:@"挑战" image:@"tabbar_challenge" selectedImage:@"tabbar_challenge_highlighted"];
    [self setupOneChildViewController:[[GUMessageViewController alloc] init] title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_highlighted"];
    [self setupOneChildViewController:[[GUMeViewController alloc] init] title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_highlighted"];
    
}

- (void)setupCustomTabBar
{
    GUTabBar *customTabBar = [[GUTabBar alloc] init];
    
    [self setValue:customTabBar forKeyPath:@"tabBar"];
}

- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
    
    //设置文字
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [vc.tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [vc.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    //设置图片
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    GUNavigationController * nav = [[GUNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}

- (void)tabBarDidClickAtCenterButton:(GUTabBar *)tabbar {
    
    _menu.backgroundType = HyPopMenuViewBackgroundTypeLightBlur;
    [_menu openMenu];

}

- (void)popMenuView:(HyPopMenuView*)popMenuView didSelectItemAtIndex:(NSUInteger)index
{
    GULog(@"pop menu index = %lu", index);
    if (index == 0) {
        MMCameraViewController *cameraVC = [[MMCameraViewController alloc] init];
        
        GUNavigationController *nav = [[GUNavigationController alloc] initWithRootViewController:cameraVC];
        [self presentViewController:nav animated:YES completion:nil];
    } else if (index == 2) {
        GUStatusPublishController *statusVC = [[GUStatusPublishController alloc] init];
        
        GUNavigationController *nav = [[GUNavigationController alloc] initWithRootViewController:statusVC];
        [self presentViewController:nav animated:YES completion:nil];
    } else if (index == 4) {
        GUStyleLearningController *styleVC = [[GUStyleLearningController alloc] init];
        
        GUNavigationController *nav = [[GUNavigationController alloc] initWithRootViewController:styleVC];
        [self presentViewController:nav animated:YES completion:nil];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
