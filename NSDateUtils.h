//
//  NSDateUtils.h
//  NumberOfNum
//
//  Created by kimsung jun on 2014. 5. 17..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateUtils : NSObject



+(int)getYear:(NSDate *)date;
+(int)getMonth:(NSDate *)date;
+(int)getDay:(NSDate *)date;
+(int)getHour:(NSDate *)date;
+(int)getMin:(NSDate *)date;

+(NSString*)getDateStr:(NSDate*) date;

+(NSDate*) getDateByFormat:(NSString*) dateStr;

+(int) calculateDDayFromNow:(NSDate*)from;

+(int) calculateDDay:(NSDate*)from to:(NSDate*)to;

+(int)getDayOfWeek:(int)year month:(int)month day:(int)day;

@end
