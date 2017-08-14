//
//  GUImageCell.m
//  GUPicOC
//
//  Created by Recluse on 2017/7/21.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "GUImageCell.h"

@interface GUImageCell()


@property (weak, nonatomic) IBOutlet UIView *imageCellView;

@end

@implementation GUImageCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"imageCell";
    GUImageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell.backgroundColor = GYLBGColor;
        cell = [[NSBundle mainBundle] loadNibNamed:@"GUImageCell" owner:nil options:nil].lastObject;
    
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
