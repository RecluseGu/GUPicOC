//
//  GUStatus.m
//  GUPicOC
//
//  Created by Recluse on 2017/7/22.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "GUStatus.h"


@implementation GUStatus

static NSDateFormatter *fmt_;
static NSCalendar *calendar_;

+ (void)initialize
{
    fmt_ = [[NSDateFormatter alloc] init];
    calendar_ = [NSCalendar calendar];
}

- (NSString *)APP_STATUS_POSTTIME {
    // 获得发帖日期
    fmt_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate = [fmt_ dateFromString:_APP_STATUS_POSTTIME];
    
    if (createdAtDate.isThisYear) { // 今年
        if (createdAtDate.isToday) { // 今天
            // 手机当前时间
            NSDate *nowDate = [NSDate date];
            NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmps = [calendar_ components:unit fromDate:createdAtDate toDate:nowDate options:0];
            
            if (cmps.hour >= 1) { // 时间间隔 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间间隔 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 分钟
                return @"刚刚";
            }
        } else if (createdAtDate.isYesterday) { // 昨天
            fmt_.dateFormat = @"昨天 HH:mm:ss";
            return [fmt_ stringFromDate:createdAtDate];
        } else { // 其他
            fmt_.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt_ stringFromDate:createdAtDate];
        }
    } else { // 非今年
        return _APP_STATUS_POSTTIME;
    }
}

- (CGFloat)cellHeight {
    
    if(_cellHeight) return _cellHeight;
    
    // 1.topView
    _cellHeight = 55;
    
    // 2.statusTextLabel
    CGFloat textMaxWidth = ScreenWidth - 2 * 10;
    CGSize textMaxSize = CGSizeMake(textMaxWidth, MAXFLOAT);
    CGSize textSize = [self.APP_STATUS_CONTENT boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _cellHeight += textSize.height + 10;

    // 3.picture
    CGFloat pictureHeight = ScreenWidth * self.IMAGE_HEIGHT / self.IMAGE_WIDTH;
    _cellHeight += pictureHeight;
    // set picture frame
    self.pictureFrame = CGRectMake(0, _cellHeight, ScreenWidth, pictureHeight);
    
    // 4.bottom view
    _cellHeight += 35 + 10;
    return _cellHeight;
}

@end
