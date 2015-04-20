//
//  Log.h
//  BJXH-patient
//
//  Created by wu weili on 14-7-7.
//  Copyright (c) 2014年 archermind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDLog.h"
#import "DDFileLogger.h"
#import "DDTTYLogger.h"


/**
 *	文件log控制开发，Documents目录下有此文件名时候，会输出文件Log，否则的话无文件log
 */
#define LOG_INDICATOR_FILE_NAME   @"IMFileLog.Open.BJYB"

/******************************
 * 默认LOG等级，由开发者调试时候设置
 *******************************/

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@interface Log : NSObject

+ (Log *)logOpen;

- (id)init;

- (void)dealloc;

@end
