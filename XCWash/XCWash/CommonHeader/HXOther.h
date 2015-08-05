//
//  HXOther.h
//  BJXH-patient
//
//  Created by wu weili on 14-5-5.
//  Copyright (c) 2014年 archermind. All rights reserved.
//

/**
 *
 * Common macros
 *
 **/



//#define HX_CUSTOM_TAB //打开此宏表示用的自定义的tabbar 否则用的是系统自带的

//设备屏幕frame
#define kMainScreenFrameRect                          [[UIScreen mainScreen] bounds]
//状态栏高度
#define kMainScreenStatusBarFrameRect                 [[UIApplication sharedApplication] statusBarFrame]
#define kMainScreenHeight                             [[UIScreen mainScreen] bounds].size.height//[[UIScreen mainScreen] applicationFrame].size.height
#define kMainScreenWidth [[UIScreen mainScreen] applicationFrame].size.width
//减去状态栏的高度:应用有效高度-状态栏的高度
#define kScreenHeightNoStatusBarHeight                (kMainScreenFrameRect.size.height - kMainScreenStatusBarFrameRect.size.height)
//减去状态栏和导航栏的高度
#define kScreenHeightNoStatusAndNoNaviBarHeight       (kMainScreenFrameRect.size.height - kMainScreenStatusBarFrameRect.size.height-44.0f)

//减去状态栏和导航栏的高度和tabbar的高度
#define kScreenHeightNoStatusAndNoNaviBarNOTabBarHeight      (kMainScreenFrameRect.size.height - kMainScreenStatusBarFrameRect.size.height - 44.0f - 44.0f)

#define KScreenTabBarHeight  46

#define kScreenHeight                             [[UIScreen mainScreen] applicationFrame].size.height
//是否为 retina屏幕
#define IS_RETINA ([UIScreen instancesRespondToSelector:@selector(scale)] ? (2 == [[UIScreen mainScreen] scale]) : NO)

//当前设备是否为 iPhone5
#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define CurrentSystemVersion ([[[UIDevice currentDevice] systemVersion] floatValue])
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

// HEX Color
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorRef(red1,green1,blue1) [UIColor colorWithRed:red1/255.0f green:green1/255.0f blue:blue1/255.0f alpha:1.0f]


//user


#define USER_NAME    ([XCUserModel shareInstance].userId)




#define MAX_LEFT_SIDE_WIDTH          (kMainScreenWidth/320)*270



//color

#define  TABLE_BACKGROUND_COLOR  [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1]//[UIColor colorWithRed:225/255.0f green:224/255.0f blue:222/255.0f alpha:1.0]

#define BACKGROUND_COLOR    UIColorFromRGB(0xEFEFEF)// 浅灰色

#define A_LITTER_GRAY_COLOR    UIColorFromRGB(0xDFDFDF)// 稍微深点的浅灰色

#define TITLE_COLOR   UIColorRef(65, 188, 154)






////////////////////////

#define REGEX_EMAIL         @"^[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%&'*\" + \"+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?"

#define REGEX_Height  @"^[1-9][0-9]*$"//@"^[0-9]{2,3}?$"  //@"^[0-9]{2,3}+(.[0-9]{1,2})?$"  // ^\d{2}(.\d){0,2}$|^\d{3}(.\d){0,2}$

#define REGEX_Weigth  @"^[1-9][0-9]*$"  //@"^[0-9]{2,3}+(.[0-9]{1,2})?$"

#define REGEX_OfficeCertificate  @"^[0-9]{8}?$"


// font

#define HEL_8               [UIFont fontWithName:@"Helvetica" size:8]
#define HEL_10              [UIFont fontWithName:@"Helvetica" size:10]
#define HEL_11              [UIFont fontWithName:@"Helvetica" size:11]
#define HEL_12              [UIFont fontWithName:@"Helvetica" size:12]
#define HEL_13              [UIFont fontWithName:@"Helvetica" size:13]
#define HEL_14              [UIFont fontWithName:@"Helvetica" size:14]
#define HEL_15              [UIFont fontWithName:@"Helvetica" size:15]
#define HEL_16              [UIFont fontWithName:@"Helvetica" size:16]
#define HEL_17              [UIFont fontWithName:@"Helvetica" size:17]
#define HEL_18              [UIFont fontWithName:@"Helvetica" size:18]
#define HEL_19              [UIFont fontWithName:@"Helvetica" size:19]
#define HEL_20              [UIFont fontWithName:@"Helvetica" size:20]
#define HEL_22              [UIFont fontWithName:@"Helvetica" size:22]
#define HEL_26              [UIFont fontWithName:@"Helvetica" size:26]

#define HEL_BOLD_10         [UIFont fontWithName:@"Helvetica-Bold" size:10]
#define HEL_BOLD_11         [UIFont fontWithName:@"Helvetica-Bold" size:11]
#define HEL_BOLD_12         [UIFont fontWithName:@"Helvetica-Bold" size:12]
#define HEL_BOLD_13         [UIFont fontWithName:@"Helvetica-Bold" size:13]
#define HEL_BOLD_14         [UIFont fontWithName:@"Helvetica-Bold" size:14]
#define HEL_BOLD_16         [UIFont fontWithName:@"Helvetica-Bold" size:16]
#define HEL_BOLD_18         [UIFont fontWithName:@"Helvetica-Bold" size:18]
#define HEL_BOLD_19         [UIFont fontWithName:@"Helvetica-Bold" size:19]
#define HEL_BOLD_20         [UIFont fontWithName:@"Helvetica-Bold" size:20]
#define HEL_BOLD_24         [UIFont fontWithName:@"Helvetica-Bold" size:24]
#define HEL_BOLD_15         [UIFont fontWithName:@"Helvetica-Bold" size:15]


#define  kDEFAULT_DATE_TIME_FORMAT (@"yyyy-MM-dd HH:mm:ss")


///////////////////////////////////////////////
//----------------通知------------------------//
////////////////////////////////////////////////

/*
 *   退出账号
 */

#define  Notify_quit_success     @"Notify_quit_success"


/*
 *   更新头像
 */

#define  Notify_update_info_success     @"Notify_update_info_success"

/**
 *   网络状态变化通知
 */

#define  KNetworkStateChangedNotification         @"kNetworkStateChangedNotification"





/////////////////////////////////////////////
/*
 *  修改面诊单理由长度
 */

#define CHANGE_FACE_DIAGNOSE_LENGTH_MAX              50

#define RECIEVE_ADDRESS_LENGTH_MAX            50

#define SEND_ADDRESS_LENGTH_MAX            50

#define SEND_MESSAGE_LENGTH_MAX            50

#define REFUSE_REASON_LENGTH_MAX            50

#define USER_NICKNAME_LENGTH_MAX            50


