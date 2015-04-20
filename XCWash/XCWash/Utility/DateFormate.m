//
//  DateFormate.m
//  XCWash
//
//  Created by 吴伟庆 on 15/3/12.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "DateFormate.h"

@implementation DateFormate


+ (NSString *)getCurrentDateToString
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];

    
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}


@end
