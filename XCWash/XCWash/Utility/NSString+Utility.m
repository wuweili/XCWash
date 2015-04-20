//
//  NSString+Utility.m
//  IOS-IM
//
//  Created by zhujun on 13-10-16.
//  Copyright (c) 2013年 archermind. All rights reserved.
//

#import "NSString+Utility.h"
#import "HXOther.h"
@implementation NSString (Utility)

+(NSString *)stringWithoutNull:(id)str
{
    NSString *tempStr = [NSString stringWithFormat:@"%@",str];
    if ([NSString isBlankString:tempStr])
    {
        return @"";
    }
    else
    {
        return tempStr;
    }
    
    
}

+ (BOOL)isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL ) {
        
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"])
    {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
        
    }
    return NO;
}

/////////////////
+(BOOL)isBlankNSData:(NSData *)data
{
    if (data == nil || data == NULL) {
        
        return YES;
    }
    if ([data isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
   
    return NO;
}


//////////////////////////////////////////
//add by wuweili 这个判空不会处理空格的
+ (BOOL)isBlankStringButCanHaveSpace:(NSString *)string
{
    
    if (string == nil || string == NULL) {
        
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES; 
    }
    return NO;
}




+(NSString *)getAstroWithMonthDay:(NSString *)birthday
{
#define ASTRO_STAR_1   NSLocalizedString(@"魔蝎座", @"")
#define ASTRO_STAR_2   NSLocalizedString(@"水瓶座", @"")
#define ASTRO_STAR_3   NSLocalizedString(@"双鱼座", @"")
#define ASTRO_STAR_4   NSLocalizedString(@"白羊座", @"")
#define ASTRO_STAR_5   NSLocalizedString(@"金牛座", @"")
#define ASTRO_STAR_6   NSLocalizedString(@"双子座", @"")
#define ASTRO_STAR_7   NSLocalizedString(@"巨蟹座", @"")
#define ASTRO_STAR_8   NSLocalizedString(@"狮子座", @"")
#define ASTRO_STAR_9   NSLocalizedString(@"处女座", @"")
#define ASTRO_STAR_10  NSLocalizedString(@"天秤座", @"")
#define ASTRO_STAR_11  NSLocalizedString(@"天蝎座", @"")
#define ASTRO_STAR_12  NSLocalizedString(@"射手座", @"")

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *birthDate = [dateFormat  dateFromString:birthday];
    if (!birthDate) {
        return nil;
    }
    NSString *rightBirthday = [dateFormat stringFromDate:birthDate];
    
    NSString *theMonth = [rightBirthday substringWithRange:NSMakeRange(5, 2)];
    int m = [theMonth intValue];
    
    NSString *theDay = [rightBirthday substringWithRange:NSMakeRange(8, 2)];
    int d = [theDay intValue];
    
    const NSArray * astroArray = [NSArray arrayWithObjects:ASTRO_STAR_1,ASTRO_STAR_2,ASTRO_STAR_3,ASTRO_STAR_4,ASTRO_STAR_5,ASTRO_STAR_6,ASTRO_STAR_7,ASTRO_STAR_8,ASTRO_STAR_9,ASTRO_STAR_10,ASTRO_STAR_11,ASTRO_STAR_12,ASTRO_STAR_1,nil];
    const NSString *astroFormat = @"102123444543";

    
    if (m<1||m>12||d<1||d>31){
        return nil;
    }
    
    if(m==2 && d>29)
    {
        return nil;
    }else if(m==4 || m==6 || m==9 || m==11) {
        
        if (d>30) {
            return nil;
        }
    }
    NSUInteger index = m - (d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19));
    return astroArray[index];
}

+ (NSString *)getAge:(NSString *)bornStr
{
    NSInteger xage = 0;
    
    if([NSString isBlankString:bornStr])
    {
        return nil;
    }
    
    NSDateFormatter *formeatter=[[NSDateFormatter alloc] init];
    [formeatter setDateFormat:@"yyyy"];
    
    NSString *curYear = [[formeatter stringFromDate:[NSDate  date]] substringToIndex:4];
    xage = [curYear integerValue] - [[bornStr substringToIndex:4] integerValue];
    xage = (xage > 149) ? 150 : xage;
    xage = (xage < 0) ? 0 : xage;
        
    return [NSString stringWithFormat:@"%d",xage];
}

+ (NSString *)phonetic:(NSString *)sourceString
{
    NSMutableString *source = [sourceString mutableCopy];

     /*Transformation	                 Input	        Output
     *********************************************************
     CFString​Transform: wiki http://nshipster.com/cfstringtransform/
     kCFStringTransformMandarinLatin	中文	            zhōng wén 
     kCFStringTransformStripDiacritics  zhōng wén       zhong wen
     kCFStringTransformToLatin          中文 or chinese  zhōng wén or chinese
     */
    //string参数是要转换的string，比如要转换的中文，同时它是mutable的，因此也直接作为最终转换后的字符串。
    //range是要转换的范围，同时输出转换后改变的范围，如果为NULL，视为全部转换。
    //transform可以指定要进行什么样的转换，这里可以指定多种语言的拼写转换。
    //reverse指定该转换是否必须是可逆向转换的。如果转换成功就返回true，否则返回false
    Boolean isFinish = CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformToLatin, NO);
//    DDLogInfo(@"第一步转换%@:------>\n%@",isFinish?@"成功":@"失败",source);
    isFinish = CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
//    DDLogInfo(@"第二步转换%@:------>\n%@",isFinish?@"成功":@"失败",source);
    return source;
}

-(BOOL)searchResult:(NSString *)searchStr{
	NSComparisonResult result = [self compare:searchStr options:NSCaseInsensitiveSearch
											   range:NSMakeRange(0, searchStr.length)];
	if (result == NSOrderedSame)
		return YES;
	else
		return NO;
}

+ (CGSize) sizeForString:(NSString *)value
                    font:(UIFont *)font
           textAlignment:(NSTextAlignment)alignment
                andWidth:(float)width
           lineBreakMode:(NSInteger)lineMode
{
    NSMutableParagraphStyle *paragraph=[[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = lineMode;
    paragraph.alignment = alignment;
    
    NSAttributedString *attributeText=[[NSAttributedString alloc] initWithString:value attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraph}];
    //options 有多个参数，详见苹果官方解释
    CGSize sizeToFit =[attributeText boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    return sizeToFit;
}


- (NSString *)trimWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


- (NSString *)URLENcoding
{
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)trim
{
    return
    [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)containOfString:(NSString *)aString
{
    return [self rangeOfString:aString].length > 0;
}

@end
