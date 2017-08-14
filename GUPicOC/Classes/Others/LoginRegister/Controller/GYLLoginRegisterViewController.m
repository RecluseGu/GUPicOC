//
//  GYLLoginRegisterViewController.m
//  GUBaiSI
//
//  Created by 永亮 谷 on 7/21/16.
//  Copyright © 2016 Recluse. All rights reserved.
//

#import "GYLLoginRegisterViewController.h"
#import "UIView+GYLExtension.h"

@interface GYLLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;

@end

@implementation GYLLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (UIStatusBarStyle) preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showLoginOrRegister:(UIButton *)button
{
    [self.view endEditing:YES];
    
    if (self.leftMargin.constant)
    {
        self.leftMargin.constant = 0;
        [button setTitle:@"注册账号" forState:UIControlStateNormal];
    }else
    {
        self.leftMargin.constant = - self.view.gyl_width;
        [button setTitle:@"已有账号？" forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (IBAction)cancelLoginClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
