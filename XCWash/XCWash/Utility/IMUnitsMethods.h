//
//  IMUnitsMethods.h
//  BJXH-patient
//
//  Created by wu weili on 14-5-5.
//  Copyright (c) 2014年 archermind. All rights reserved.
//

/**
 *
 * Only Support Static Methodes !
 *
 **/

#import <Foundation/Foundation.h>
#import "NSString+Utility.h"

@interface IMUnitsMethods : NSObject

+ (NSString *)convertDateToDynamicShow:(NSString *)dateStr;

//导航左按钮
+(void)drawTheLeftBarBtn:(UIViewController *)control function:(SEL )funName  btnTitle:(NSString*)title;

+(void)drawTheLeftBarBtnWithNoTitle:(UIViewController *)control function:(SEL )funName;

//导航右按钮
//+(void)drawTheRightBarBtn:(UIViewController *)control function:(SEL )funName  btnTitle:(NSString*)title;

+(void)drawTheRightBarBtn:(UIViewController *)control function:(SEL )funName  btnTitle:(NSString*)title bgImage:(UIImage*)image;

//隐藏下面的Tabbar
+(void)hiddenTheTabbar:(BOOL)isHidden viewControler:(UIViewController *)viewControl orientation:(UIInterfaceOrientation)interfaceOrientation;

//保存图片以用户的id为图片命名
+(void)saveImage:(NSData*)imageData imageName:(NSString*)userId;

//获取原来大小的图片
+(UIImage*)getImageFromDoc:(NSString*)userId;

//获取压缩的图片
+(UIImage*)compressImage:(UIImage*)image scaledToSize:(CGSize)newSize;

//绘制导航栏back button item 有左箭头的
+ (void)drawBackBarBtnItem:(UIViewController *)controller function:(SEL)funName btnTitle:(NSString *)title;

+ (void)drawBackBarBtnItem:(UIViewController *)controller function:(SEL)funName btnTitle:(NSString *)title bgImage:(UIImage*)image;

// 获取当前用户文件目录（如没有则通过合抱用户id创建）
+ (NSString *)userFilePath;

#pragma mark  获取当前document文件目录
+ (NSString *)userDocumentPath;

//转换标准日期格式 至 信息界面显示格式（昨天，星期一……）
+ (NSString *)convertDateToMsgShow:(NSString *)dateStr WithDetail:(BOOL)flag;

+ (NSString *)convertDateToFriendCircleShow:(NSString *)dateStr;

//数组逆序
+(void)reverseArray:(NSMutableArray *)arr;

//动态详情时间显示格式化
+ (NSString *)convertDateToFriendCircleDetail:(NSString *)dateStr;

//我的动态详情发布 时间显示
+ (NSString *)convertDateToDetailDynamicShow:(NSString *)dateStr;

//设置视图不延伸到status bar和 NAV bar 下面
+ (void)setViewControllerProperty:(UIViewController *)controller;

//只有image的button
+(void)drawTheRightBarBtnImage:(UIViewController *)control function:(SEL )funName bgImage:(UIImage*)image withFrame:(CGRect)frame;

+(void)drawTheLeftBarBtn:(UIViewController *)control btnTitle:(NSString*)title;

+(void)drawTheBackBarBtn:(UIViewController *)control function:(SEL )funName  btnTitle:(NSString*)title titleColor:(UIColor *)color;

//屏蔽emoji表情输入 不适应九宫格输入法
+(BOOL)stringContainsEmoji:(NSString *)string;
//屏蔽emoji表情输入
+(NSString *)disable_emoji:(NSString *)text;

//判断输入长度  屏蔽系统表情及防止手写时崩溃
+(void)limitInputTextWithTextView:(UITextView *)textView limit:(NSInteger)limit;


//判断输入长度  屏蔽系统表情及防止手写时崩溃  UITextField
+(void)limitInputTextWithUITextField:(UITextField *)textField limit:(NSInteger)limit;

#pragma mark - 统计ASCII和Unicode混合文本长度的，看下来和新浪微博的统计结果是一致的
+(NSUInteger)unicodeLengthOfString:(NSString *)text;

#pragma mark -判断输入的邮箱格式是否正确
+(BOOL)checkInputEmail:(NSString*)text;

#pragma mark -判断输入的身高格式是否正确
+(BOOL)checkInputHeight:(NSString*)text;

#pragma mark -判断输入的体重格式是否正确
+(BOOL)checkInputWeigth:(NSString*)text;
#pragma mark 手机号码判断方法
+(BOOL)regexPhoneNumber:(NSString*)phoneNumber;
#pragma mark - 判断输入的军官证格式是否正确
+(BOOL)checkInputOfficeCertificate:(NSString*)text;

#pragma mark - 身份证判断方法
+(BOOL)regexIdCardToEighteenNumber:(NSString*)idCard;

//身份证判断方法
+(BOOL)regexPersonalIdentifierNum:(NSString *)value;

+ (NSString *)generateUUID;

+ (NSString *)createRecordPictureName;

//清空session
+(void)clearSession;

//获取User-Agent
+(NSString *)obtainUserAgent;

//加密  小写
+(NSString *)getMD5Str:(NSString *)str;

@end
