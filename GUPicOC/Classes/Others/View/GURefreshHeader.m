//
//  GURefreshHeader.m
//  GUPicOC
//
//  Created by Recluse on 2017/7/22.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "GURefreshHeader.h"

@implementation GURefreshHeader

- (void)prepare {
    [super prepare];
    
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.textColor = [UIColor orangeColor];
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"释放更新" forState:MJRefreshStatePulling];
    [self setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
}

@end
