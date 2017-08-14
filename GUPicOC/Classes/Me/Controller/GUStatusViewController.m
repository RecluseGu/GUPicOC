//
//  GUStatusViewController.m
//  GUPicOC
//
//  Created by Recluse on 2017/7/21.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "GUStatusViewController.h"
#import "GUStatus.h"
#import "GUHTTPSessionManager.h"
#import "GUStatusCell.h"
#import <MJExtension.h>
#import "GUVisitorView.h"
#import "GYLLoginRegisterViewController.h"

static NSString *const myStatusCellID = @"status";

@interface GUStatusViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray<GUStatus *> *statuses;

@end

@implementation GUStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的动态";
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

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GUStatusCell class]) bundle:nil] forCellReuseIdentifier:myStatusCellID];
    
    [self loadNewStatus];

}

- (void)loadNewStatus {
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"StatusList" ofType:@"plist"];
    NSMutableDictionary *statusDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    //读取手动创建的plist文件的属性的值。
    NSArray<GUStatus *> *tempArray = [GUStatus mj_objectArrayWithKeyValuesArray:statusDic[@"list"]];
    NSMutableArray<GUStatus *> *statusArray = [NSMutableArray array];
    for (GUStatus *item in tempArray) {
        
        if ([item.APP_USER_NAME isEqualToString:@"Recluse"]) {
            [statusArray addObject:item];
        }
    }
    self.statuses = statusArray;
    GULog(@"%@",self.statuses);
    
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
    GUStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:myStatusCellID];
    cell.status = self.statuses[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.statuses[indexPath.row].cellHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
