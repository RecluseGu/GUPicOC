//
//  GUFansViewController.m
//  GUPicOC
//
//  Created by Recluse on 2017/7/21.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "GUFansViewController.h"
#import "GUFollowCell.h"
#import <MJExtension.h>

static NSString *const fansID = @"follow";

@interface GUFansViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *users;


@end

@implementation GUFansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的粉丝";
    self.view.backgroundColor = GYLBGColor;
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.frame;
    tableView.backgroundColor = GYLBGColor;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GUFollowCell class]) bundle:nil] forCellReuseIdentifier:fansID];
    
    [self loadNewStatus];
}

- (void)loadNewStatus {
    
    NSArray *followUsers = @[
                             @{
                                 @"APP_USER_NAME":@"Cathy",
                                 @"APP_USER_IMAGEURL":@"headImage2",
                                 @"APP_USER_MOTTO":@"JumYiXia",
                                 @"APP_USER_FOLLOW":@"1",
                                 },
                             @{
                                 @"APP_USER_NAME":@"晴天",
                                 @"APP_USER_IMAGEURL":@"headImage3",
                                 @"APP_USER_MOTTO":@"有志者事竟成！",
                                 @"APP_USER_FOLLOW":@"1",
                                 },
                             @{
                                 @"APP_USER_NAME":@"风一声",
                                 @"APP_USER_IMAGEURL":@"mosaic",
                                 @"APP_USER_MOTTO":@"PhotoWord。",
                                 @"APP_USER_FOLLOW":@"2",
                                 },
                             @{
                                 @"APP_USER_NAME":@"LioMesii",
                                 @"APP_USER_IMAGEURL":@"headImage",
                                 @"APP_USER_MOTTO":@"我是梅球王！",
                                 @"APP_USER_FOLLOW":@"2",
                                 },
                             ];
    
    
    
    self.users = [GUAppUser mj_objectArrayWithKeyValuesArray:followUsers];
    GULog(@"%@",self.users);
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GUFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:fansID];
    cell.userType = @"fans";
    cell.followUser = self.users[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
