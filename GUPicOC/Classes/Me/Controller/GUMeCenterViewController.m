//
//  GUMeCenterViewController.m
//  GUPicOC
//
//  Created by Recluse on 2017/7/21.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "GUMeCenterViewController.h"
#import "GUHeaderView.h"
#import "UserInfoCell.h"
#import "GUAppUser.h"
#import "GUImageCell.h"

static NSString *const kUserInfoCellId = @"kUserInfoCellId";
static NSString *const blankCellId = @"blank";

@interface GUMeCenterViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) GUHeaderView *headerView;
@property(nonatomic ,strong) NSArray *listArray;

@end

@implementation GUMeCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
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
    
    self.headerView = [[GUHeaderView alloc] initWithImage:[UIImage imageNamed:[user objectForKey:@"APP_USER_IMAGEURL"]]];
    [self.headerView reloadSizeWithScrollView:self.tableView];
    self.navigationItem.titleView = self.headerView;
    
    /*
    [self.headerView handleClickActionWithBlock:^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您点击了头像" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }];
     */
    
    [self loadImageData];

}

- (void)loadImageData {
    
    NSArray * photoImages=@[
                            @{
                                @"id": @"1",
                                @"imagePath": @"messi"
                                },
                            @{
                                @"id": @"2",
                                @"imagePath": @"headImage"
                                },
                            @{
                                @"id": @"3",
                                @"imagePath": @"headImage3"
                                },
                            
                            @{
                                @"id": @"4",
                                @"imagePath": @"candy"
                                },
                            @{
                                @"id": @"5",
                                @"imagePath": @"feathers"
                                },
                            @{
                                @"id": @"6",
                                @"imagePath": @"mosaic"
                                },
                            @{
                                @"id": @"7",
                                @"imagePath": @"udnie"
                                },
                            @{
                                @"id": @"8",
                                @"imagePath": @"status2"
                                },
                            @{
                                @"id": @"9",
                                @"imagePath": @"status9"
                                },
                            @{
                                @"id": @"6",
                                @"imagePath": @"status10"
                                },
                            @{
                                @"id": @"7",
                                @"imagePath": @"status7"
                                },
                            @{
                                @"id": @"8",
                                @"imagePath": @"status2"
                                },
                            @{
                                @"id": @"9",
                                @"imagePath": @"messi"
                                },
                            @{
                                @"id": @"6",
                                @"imagePath": @"messi"
                                },
                            @{
                                @"id": @"7",
                                @"imagePath": @"messi"
                                },
                            @{
                                @"id": @"8",
                                @"imagePath": @"messi"
                                },
                            @{
                                @"id": @"9",
                                @"imagePath": @"messi"
                                }
                            ];

    self.listArray = photoImages;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    GULog(@"%f",ceil(self.listArray.count / 3.0));
    return ceil(self.listArray.count / 3.0) + 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 183.f;
    } else if (indexPath.row == 1) {
        return 30.f;
    }
    return ScreenWidth / 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserInfoCellId];
        if (!cell) {
            cell = [[UserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kUserInfoCellId];
           
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            cell.userDefaults = user;
        
        }
        return cell;
    }else if(indexPath.row == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:blankCellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:blankCellId];
            cell.backgroundColor = GYLBGColor;
        }
        return cell;
    }
    
    int  maxCol = 3;
    CGFloat imageWidth = (ScreenWidth - 6) / maxCol;
    CGFloat imageHeight = imageWidth;
    
    NSUInteger count = self.listArray.count;
    GUImageCell *cell = [GUImageCell cellWithTableView:tableView];
    for (int i = 0; i < maxCol; i++) {
        
        NSArray *photoCellList;
        NSDictionary *image;
        if (indexPath.row == ceil(count / 3.0) + 1) {
            photoCellList = [self.listArray subarrayWithRange:NSMakeRange((indexPath.row - 2) * 3, count % 3)];
            if (i > count % 3 - 1) {
                break;
            }
            image = [photoCellList objectAtIndex:i];
        }else {
            photoCellList = [self.listArray subarrayWithRange:NSMakeRange((indexPath.row - 2) * 3, maxCol)];
            image = [photoCellList objectAtIndex:i];

        }
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [cell addSubview:imageView];
        imageView.image = [UIImage imageNamed:[image objectForKey:@"imagePath"]];
        if (i > 0) {
            imageView.gyl_x = (i % maxCol) * imageWidth + i * 3;
        }else {
                imageView.gyl_x = (i % maxCol) * imageWidth;
        }
        imageView.gyl_y = 0;
        imageView.gyl_width = imageWidth;
        imageView.gyl_height = imageHeight - 1;
    }

    cell.backgroundColor = GYLBGColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
