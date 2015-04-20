//
//  AppDelegate.m
//  XCWash
//
//  Created by 吴伟庆 on 15/3/11.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "AppDelegate.h"
#import "XCLeftSideViewController.h"
#import "XCCenterFirstPageViewController.h"
#import "MMDrawerController.h"

@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [self initGlobalSettings];
    
    _isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:AccountLoginResult];
    
    if (_isLogin)
    {
        [XCUserModel shareInstance].userId = [[NSUserDefaults standardUserDefaults]objectForKey:LOGIN_SUCCESS_USER_ID];
        
        [XCUserModel shareInstance].userName = [[NSUserDefaults standardUserDefaults]objectForKey:LOGIN_SUCCESS_USER_NAME];
        
        [XCUserModel shareInstance].userPictureUrl = [[NSUserDefaults standardUserDefaults]objectForKey:LOGIN_SUCCESS_USER_URL];
    }
    

    
//    _isLogin = YES;
    
    if(CurrentSystemVersion >= 7.0)
    {
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
    
    
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x1190e9)];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20.0f]}];


    
    

    UIViewController *leftSideViewController = [[XCLeftSideViewController alloc]init];
    
    UINavigationController *leftSideNav = [[UINavigationController alloc]initWithRootViewController:leftSideViewController];
    
    UIViewController *centerViewController = [[XCCenterFirstPageViewController alloc]init];
    
    UINavigationController *centerNav = [[UINavigationController alloc]initWithRootViewController:centerViewController];
//    [centerNav.navigationBar setBackgroundImage:ICON_NAV_BAR forBarMetrics:UIBarMetricsDefault];
    
    
    MMDrawerController * drawerController = [[MMDrawerController alloc]
                                             initWithCenterViewController:centerNav
                                             leftDrawerViewController:leftSideNav
                                             rightDrawerViewController:nil];

    
    [drawerController setMaximumLeftDrawerWidth:MAX_LEFT_SIDE_WIDTH];

    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:drawerController];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}


- (void)initGlobalSettings
{
    
    [Log logOpen];

    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//禁止横屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}


@end
