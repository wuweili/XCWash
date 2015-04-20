//
//  NSString+Utility.h
//  BJXH-patient
//
//  Created by wu weili on 14-5-5.
//  Copyright (c) 2014年 archermind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utility)

+(NSString *)stringWithoutNull:(id)str;


//判断TextField等控件输入字符串是否为空——空指针或者空字符
+ (BOOL)isBlankString:(NSString *)string;

//获取星座
+(NSString *)getAstroWithMonthDay:(NSString *)birthday;
//获取年龄
+ (NSString *)getAge:(NSString *)bornStr;

//汉子转字母
+ (NSString *)phonetic:(NSString *)sourceString;
//是否与searchT相等
-(BOOL)searchResult:(NSString *)searchStr;
+ (BOOL)isBlankStringButCanHaveSpace:(NSString *)string;

+ (CGSize) sizeForString:(NSString *)value
                    font:(UIFont *)font
           textAlignment:(NSTextAlignment)alignment
                andWidth:(float)width
           lineBreakMode:(NSInteger)lineMode;



//判断NSDATA是否为空
+ (BOOL)isBlankNSData:(NSData *)data;
- (NSString *)trimWhitespace;

- (NSString *)trim;

- (NSString *)URLENcoding;

- (BOOL)containOfString:(NSString *)aString;

@end
