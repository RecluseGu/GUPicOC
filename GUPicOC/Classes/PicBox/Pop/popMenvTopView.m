//
//  popMenvTopView.m
//  HyPopMenuView
//
//  Created by Hy_Mac on 16/7/15.
//  Copyright © 2016年 ouy.Aberi. All rights reserved.
//

#import "popMenvTopView.h"
#import "HyPopMenuView.h"

#define RGB(r, g, b)    [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1]
#define drakColor RGB(60, 60, 60)
#define lightColor RGB(249, 247, 234)


@interface popMenvTopView ()
@property (strong, nonatomic) NSArray *datas;
@property (nonatomic, assign) NSUInteger idx;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) HyPopMenuView* menu;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *weakDayLabel;


@end

@implementation popMenvTopView

+ (instancetype)popMenvTopView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"popMenvTopView" owner:self options:nil] firstObject];
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _idx = 0;
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
//    _timer = [NSTimer scheduledTimerWithTimeInterval:2.4f target:self selector:@selector(changeImage) userInfo:nil repeats:true];
//    [self changeImage];
    
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSDate *date = [NSDate date];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
    
    NSDateComponents *components =[calendar components:unit fromDate:date];
    
    self.dayLabel.text = [NSString stringWithFormat:@"%lu",components.day];
    self.monthYearLabel.text = [NSString stringWithFormat:@"%lu/%lu",components.month, components.year];
    self.weakDayLabel.text = [NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:components.weekday - 1]];

    
    NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(HyPopMenuViewWillShowNotification:) name:HyPopMenuViewWillShowNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(HyPopMenuViewWillHideNotification:) name:HyPopMenuViewWillHideNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(HyPopMenuViewDidShowNotification:) name:HyPopMenuViewDidShowNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(HyPopMenuViewDidHideNotification:) name:HyPopMenuViewDidHideNotification object:nil];
}

- (void)HyPopMenuViewWillShowNotification:(NSNotification *)notification
{
    _menu = [notification object];
    if (_menu.backgroundType == HyPopMenuViewBackgroundTypeDarkBlur ||
        _menu.backgroundType == HyPopMenuViewBackgroundTypeDarkTranslucent) {
        self.label1.textColor = lightColor;
        self.label2.textColor = lightColor;
        self.label3.textColor = lightColor;
        self.label4.textColor = lightColor;
    } else {
        self.label1.textColor = drakColor;
        self.label2.textColor = drakColor;
        self.label3.textColor = drakColor;
        self.label4.textColor = drakColor;
    }
}

- (void)HyPopMenuViewWillHideNotification:(NSNotification *)notification
{
//...
}

- (void)HyPopMenuViewDidShowNotification:(NSNotification *)notification
{
//...
}

- (void)HyPopMenuViewDidHideNotification:(NSNotification *)notification
{
//...
}

- (void)changeImage
{
    if (![_menu isOpenMenu]) return ;
    
    _idx ++;
    if (_idx > 6) {
        _idx = 1;
    }
    __weak popMenvTopView *weak = self;
    [UIView animateWithDuration:0.2 animations:^{
        
        weak.imageView.alpha = 0;
        
    } completion:^(BOOL finished) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"img-%zd",weak.idx]];
        weak.imageView.image = image;
        [UIView animateWithDuration:0.2 animations:^{
            weak.imageView.alpha = 1;
        }];
    }];
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
}

- (void)dealloc
{
    
}

@end
