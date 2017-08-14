//
//  GUHotStatusTableViewController.m
//  GUPicOC
//
//  Created by Recluse on 2017/7/22.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "GUHotStatusTableViewController.h"
#import "GUStatus.h"
#import "GUHTTPSessionManager.h"
#import "GUStatusCell.h"
#import <MJExtension.h>
#import "GUVisitorView.h"
#import "GYLLoginRegisterViewController.h"

static NSString *const hotStatusCellID = @"status";

@interface GUHotStatusTableViewController ()

@property(nonatomic, strong) NSMutableArray<GUStatus *> *statuses;
@property(nonatomic, weak) UILabel *refreshLabel;
@property(nonatomic, copy) NSString *maxTime;


@end

@implementation GUHotStatusTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([GUUserHelper isUserLogin]) {
        
        [self setupTableView];
        //    [self setupRefresh];
        
        [self loadNewStatus];
    }else {
        GUVisitorView *visitorView = [GUVisitorView loadFromNib];
        visitorView.frame = self.view.frame;
        visitorView.backgroundColor = GYLBGColor;
        [visitorView setInfoWithImageName:@"visitordiscover_feed_image_house" descTitle:@"登陆后，您所关注的人的状态都会在这里显示！"];
        visitorView.delegate = (id)self;
        self.view = visitorView;
    }
    
    
}

- (void)setupTableView {
    self.tableView.backgroundColor = GYLBGColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GUStatusCell class]) bundle:nil] forCellReuseIdentifier:hotStatusCellID];
}

/*
 -(void)setupRefresh {
 
 }
 */

- (void)loadNewStatus {
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"StatusList" ofType:@"plist"];
    NSMutableDictionary *statusDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    //读取手动创建的plist文件的属性的值。
    self.statuses = [GUStatus mj_objectArrayWithKeyValuesArray:statusDic[@"list"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GUStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:hotStatusCellID];
    cell.status = self.statuses[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.statuses[indexPath.row].cellHeight;
}

- (void)jumpToLoginVC:(UIButton *)sender {
    
    [self presentViewController:[[GYLLoginRegisterViewController alloc] init] animated:YES completion:nil];
    
}
@end
