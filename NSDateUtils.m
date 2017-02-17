//
//  NSDateUtils.m
//  NumberOfNum
//
//  Created by kimsung jun on 2014. 5. 17..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "NSDateUtils.h"

@implementation NSDateUtils


+(int)getYear:(NSDate *)date{
//    NSDate* date = [NSDate date];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit |
                                    NSMonthCalendarUnit |
                                    NSDayCalendarUnit |
                                    NSHourCalendarUnit |
                                    NSMinuteCalendarUnit |
                                    NSSecondCalendarUnit fromDate:date];
    
    return [components year];
//    int month = [components month];
//    int day = [components day];
//    int hour = [components hour];
//    int minute = [components minute];
//    int second = [components second];
}
+(int)getMonth:(NSDate *)date{
//    NSDate* date = [NSDate date];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit |
                                    NSMonthCalendarUnit |
                                    NSDayCalendarUnit |
                                    NSHourCalendarUnit |
                                    NSMinuteCalendarUnit |
                                    NSSecondCalendarUnit fromDate:date];
    
    
    return [components month];
    
    
}
+(int)getDay:(NSDate *)date{
    
//    NSDate* date = [NSDate date];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit |
                                    NSMonthCalendarUnit |
                                    NSDayCalendarUnit |
                                    NSHourCalendarUnit |
                                    NSMinuteCalendarUnit |
                                    NSSecondCalendarUnit fromDate:date];
    
    
    return [components day];
   
    
}

+(int)getHour:(NSDate *)date{
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit |
                                    NSMonthCalendarUnit |
                                    NSDayCalendarUnit |
                                    NSHourCalendarUnit |
                                    NSMinuteCalendarUnit |
                                    NSSecondCalendarUnit fromDate:date];
    
    
    return [components hour];

    
    
}
+(int)getMin:(NSDate *)date{
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit |
                                    NSMonthCalendarUnit |
                                    NSDayCalendarUnit |
                                    NSHourCalendarUnit |
                                    NSMinuteCalendarUnit |
                                    NSSecondCalendarUnit fromDate:date];
    
    
    return [components minute];

    
}

+(NSString*)getDateStr:(NSDate*) date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy/MM/dd"];
    return [formatter stringFromDate:date];
    
}


+(NSDate*) getDateByFormat:(NSString*) dateStr
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    
    NSDate *date= [[NSDate alloc] init];
    date = [formatter dateFromString:dateStr];
    
    return date;
}


+(int) calculateDDayFromNow:(NSDate*)from
{
    NSDate *now = [NSDate date];
    return [self calculateDDay:from to:now];
}

+(int) calculateDDay:(NSDate*)from to:(NSDate*)to
{
    NSDateComponents *dcom = [[NSCalendar currentCalendar]components:NSDayCalendarUnit
                                                            fromDate:from
                                                              toDate:to
                                                             options:0];
    
    return [dcom day];
}

+(int)getDayOfWeek:(int)year month:(int)month day:(int)day
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:year];
    [dateComponents setMonth:month];
    [dateComponents setDay:day];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:dateComponents];
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    
    return [weekdayComponents weekday] - 1;
}

@end
