//
//  AppDelegate.h
//  XCWash
//
//  Created by 吴伟庆 on 15/3/11.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XCAPPDELEGATE   ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,assign)BOOL isLogin;

@end

