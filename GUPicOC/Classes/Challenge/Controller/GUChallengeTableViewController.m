//
//  GUChallengeTableViewController.m
//  GUPicOC
//
//  Created by Recluse on 2017/7/25.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "GUChallengeTableViewController.h"
#import "GUChallenge.h"
#import "GUChallengeCell.h"
#import <MJExtension.h>

static NSString *const challengeCellID = @"challenge";

@interface GUChallengeTableViewController ()

@property(nonatomic, strong) NSMutableArray<GUChallenge *> *challenges;

@end

@implementation GUChallengeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"挑战";
    self.tableView.backgroundColor = GYLBGColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;

    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GUChallengeCell class]) bundle:nil] forCellReuseIdentifier:challengeCellID];
    
    
    [self loadNewData];
}

- (void)loadNewData {
    NSArray *challenges = @[
                        @{
                            @"APP_CHALLENGE_NAME":@"红蓝军团",
                            @"APP_CHALLENGE_AWARD":@"666元",
                            @"APP_CHALLENGE_BACKURL":@"challenge1",
                            @"APP_CHALLENGE_SPONSOR":@"Recluse",
                            @"APP_CHALLENGE_ENDTIME":@"2017年12月31日"
                            },
                        @{@"APP_CHALLENGE_NAME":@"我的八月",
                          @"APP_CHALLENGE_AWARD":@"128元",
                          @"APP_CHALLENGE_BACKURL":@"challenge2",
                          @"APP_CHALLENGE_SPONSOR":@"Amy",
                          @"APP_CHALLENGE_ENDTIME":@"2017年8月31日"},
                        @{@"APP_CHALLENGE_NAME":@"暑假生活",
                          @"APP_CHALLENGE_AWARD":@"268元",
                          @"APP_CHALLENGE_BACKURL":@"challenge3",
                          @"APP_CHALLENGE_SPONSOR":@"Lily",
                          @"APP_CHALLENGE_ENDTIME":@"2017年9月1日"},
                        @{@"APP_CHALLENGE_NAME":@"暑假生活",
                          @"APP_CHALLENGE_AWARD":@"268元",
                          @"APP_CHALLENGE_BACKURL":@"challenge4",
                          @"APP_CHALLENGE_SPONSOR":@"PhotoWord",
                          @"APP_CHALLENGE_ENDTIME":@"2017年9月1日"}
                        ];
    
    self.challenges = [GUChallenge mj_objectArrayWithKeyValuesArray:challenges];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.challenges.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GUChallengeCell *cell = [tableView dequeueReusableCellWithIdentifier:challengeCellID];
    
    cell.challenge = self.challenges[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.challenges[indexPath.row].cellHeight;
}



@end
