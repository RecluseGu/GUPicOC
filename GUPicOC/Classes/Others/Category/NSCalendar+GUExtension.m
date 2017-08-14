//
//  NSCalendar+GUExtension.m
//  GUPicOC
//
//  Created by Recluse on 2017/7/24.
//  Copyright © 2017年 Recluse. All rights reserved.
//

#import "NSCalendar+GUExtension.h"

@implementation NSCalendar (GUExtension)

+ (instancetype)calendar
{
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    } else {
        return [NSCalendar currentCalendar];
    }
}

@end
