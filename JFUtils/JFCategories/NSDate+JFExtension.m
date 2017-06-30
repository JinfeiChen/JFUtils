//
//  NSDate+JFExtension.m
//  CJF
//
//  Created by cjf on 2017/5/25.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import "NSDate+JFExtension.h"

@implementation NSDate (JFExtension)

- (NSInteger)year {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)month {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)day {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)hour {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)minute {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)second {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)nanosecond {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] nanosecond];
}

@end


@implementation NSDate (JFValidate)

- (BOOL)isToday {
    if (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24) {
        return NO;
    }
    return [NSDate new].day == self.day;
}

- (BOOL)isYesterday {
    
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 86400 * 1;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return [newDate isToday];
}

@end
