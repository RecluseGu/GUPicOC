//
//  GUStyleLearningController.m
//  GUPicOC
//
//  Created by Recluse on 2017/8/4.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "GUStyleLearningController.h"
#import "GUStyleLearningCell.h"
#import <MJExtension.h>

static NSString *const styleID = @"style";

@interface GUStyleLearningController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *styles;

@end

@implementation GUStyleLearningController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"风格上传";
    self.view.backgroundColor = GYLBGColor;
    
    [[UINavigationBar appearance] setTintColor:[UIColor orangeColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(clostBtnClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上传" style:UIBarButtonItemStylePlain target:self action:@selector(uploadBtnClick)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GUStyleLearningCell class]) bundle:nil] forCellReuseIdentifier:styleID];
    
    [self loadNewStatus];
}

- (void)loadNewStatus {
    
    NSArray *styles = @[
                             @{
                                 @"APP_STYLE_NAME":@"Picasso",
                                 @"APP_STYLE_STATUS":@"1",
                                 @"APP_STYLE_IMAGE":@"Picasso",
                                 },
                             @{
                                 @"APP_STYLE_NAME":@"Van Gogh",
                                 @"APP_STYLE_STATUS":@"0",
                                 @"APP_STYLE_IMAGE":@"Van Gogh",
                                 },
                             ];
    
    
    
    self.styles = [GUStyle mj_objectArrayWithKeyValuesArray:styles];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.styles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GUStyleLearningCell *cell = [tableView dequeueReusableCellWithIdentifier:styleID];
    
    cell.style = self.styles[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

- (void)clostBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadBtnClick {
    
}

@end
