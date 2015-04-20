//
//  Log.m
//  BJXH-patient
//
//  Created by wu weili on 14-7-7.
//  Copyright (c) 2014年 archermind. All rights reserved.
//

// DDLog的简单调用控制
#import "Log.h"
#import <Foundation/Foundation.h>

@implementation Log

+ (Log *)logOpen
{
    static Log *shareLogInstance = nil;
    
    static dispatch_once_t doInit;
    dispatch_once(&doInit, ^{
        shareLogInstance = [[self alloc] init];
    });
    
    return shareLogInstance;
}

- (id)init
{
    if(self = [super init])
    {
#ifdef CONSOLE_LOG_ON
        [DDLog addLogger:[DDTTYLogger sharedInstance]];
#endif
        
#ifdef FILE_LOG_ON
        DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
        fileLogger.rollingFrequency = 60 * 60 * 4;  //记录2个小时的log
        fileLogger.logFileManager.maximumNumberOfLogFiles = 5;
        
        [DDLog addLogger:fileLogger];
#endif
        
//        if([self isFileLogIndicatorExist])
//        {
//            DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
//            fileLogger.rollingFrequency = 60 * 60 * 2;  //记录2个小时的log
//            fileLogger.logFileManager.maximumNumberOfLogFiles = 5;
//            
//            [DDLog addLogger:fileLogger];
//        }
    }
    return self;
}

- (BOOL)isFileLogIndicatorExist
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *FileLogIndicator = [docDir stringByAppendingString:LOG_INDICATOR_FILE_NAME];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:FileLogIndicator])
    {
        return TRUE;
    }

    return TRUE;
}

- (void)dealloc
{
}


@end
