//
//  XCBaseCenterViewController.m
//  XCWash
//
//  Created by 吴伟庆 on 15/3/11.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCBaseCenterViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "IMUnitsMethods.h"
#import "XCCenterFirstPageViewController.h"
#import "MBProgressHUD.h"
#import "XCMyOrderViewController.h"




@interface XCBaseCenterViewController ()<UIGestureRecognizerDelegate>
{
    MBProgressHUD *_progressHUD;
    NSTimer * _xmppTimer;

}

@end

@implementation XCBaseCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xe6e6e6);

    [self setupLeftMenuButton];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];

    
    // Do any additional setup after loading the view.
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter ]removeObserver:self];
}


-(void)setupLeftMenuButton
{
    if ([self isKindOfClass:[XCCenterFirstPageViewController class]])
    {
        [IMUnitsMethods drawTheLeftBarBtn:self function:@selector(leftDrawerButtonPress:) btnTitle:nil ];
        [IMUnitsMethods drawTheRightBarBtn:self function:@selector(rightDrawerButtonPress:) btnTitle:nil bgImage:XC_rightNavButton_bg_image];
        
    }
    else
    {
        [IMUnitsMethods drawTheLeftBarBtnWithNoTitle:self function:@selector(clickLeftNavMenu)];
        
    }
}

-(void)leftDrawerButtonPress:(id)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)rightDrawerButtonPress:(id)sender
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:AccountLoginResult])
    {
        //未登录
        [self clickButtonWhenUnlogin];
    }
    else
    {
        //已登录
        XCMyOrderViewController*orderMVC = [[XCMyOrderViewController alloc]init];
        UINavigationController *orderNav = [[UINavigationController alloc]initWithRootViewController:orderMVC];
        
        orderNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self.navigationController presentViewController:orderNav animated:YES completion:^{
            
        }];
        
        
    }

}


-(void)clickButtonWhenUnlogin
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)clickLeftNavMenu
{
    
}


#pragma mark tap action
-(void)tapAction:(id)sender
{
    [self.view endEditing:YES];
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (![touch.view isKindOfClass:[UITextField class]] &&
        ![touch.view isKindOfClass:[UITextView class]] &&
        ![touch.view isKindOfClass:[UIButton class]] 
        )
    {
        [self.view endEditing:YES];
    }
    return NO;
}


-(void)hideKeyBoardShow
{
    //私有api关闭键盘方法
    /*
     Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
     id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
     [activeInstance performSelector:@selector(dismissKeyboard)];
     */
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}


#pragma mark - MBHUDProgress and NSTime
-(void)initMBHudWithTitle:(NSString *)title
{
    if (_progressHUD != nil)
    {
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
    }
    
    _progressHUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    if (![NSString isBlankString:title])
    {
        _progressHUD.mode = MBProgressHUDModeText;
        
        _progressHUD.detailsLabelText = title;
        if (title.length > 12)
        {
            _progressHUD.detailsLabelFont = HEL_14;
        }
        else
        {
            _progressHUD.detailsLabelFont = HEL_16;
        }
        
        
    }
    
    _progressHUD.removeFromSuperViewOnHide = YES;
    
    _xmppTimer = [NSTimer timerWithTimeInterval:30
                                         target:self
                                       selector:@selector(timeoutFailed)
                                       userInfo:nil
                                        repeats:NO];
    [[NSRunLoop currentRunLoop]addTimer:_xmppTimer forMode:NSRunLoopCommonModes];
    
}

-(void)initMBHudBecauseNetWorkUnavailable
{
    _progressHUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    _progressHUD.mode = MBProgressHUDModeText;
    _progressHUD.labelText = STR_NET_ERROR;
    [_progressHUD show:YES];
    _progressHUD.removeFromSuperViewOnHide = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:_progressHUD];
    
    
    [self performSelector:@selector(hideProgress) withObject:nil afterDelay:1.0];
}

-(void)displaySomeInfoWithInfo:(NSString *)infoStr finsh:(void (^)(void))finshBlock
{
    _progressHUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    _progressHUD.mode = MBProgressHUDModeText;
    
    
    _progressHUD.detailsLabelText = infoStr;
    if (infoStr.length > 12)
    {
        _progressHUD.detailsLabelFont = HEL_14;
    }
    else
    {
        _progressHUD.detailsLabelFont = HEL_16;
    }
    
    
    [_progressHUD show:YES];
    _progressHUD.removeFromSuperViewOnHide = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:_progressHUD];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideProgress];
        
        if (finshBlock)
        {
            finshBlock();
        }
        
    });
    
}



-(void)stopMBHudAndNSTimerWithmsg:(NSString *)msg finsh:(void (^)(void))finshBlock
{
    
    if (_xmppTimer)
    {
        [_xmppTimer invalidate];
        _xmppTimer = nil;
    }
    
    /*
     *  目前是如果停止时又文字显示，那就有一个回调block
     *
     */
    
    if (msg != nil)
    {
        _progressHUD.mode =  MBProgressHUDModeText;
        //        _progressHUD.labelText = msg;
        
        
        _progressHUD.detailsLabelText = msg;
        if (msg.length > 12)
        {
            _progressHUD.detailsLabelFont = HEL_14;
        }
        else
        {
            _progressHUD.detailsLabelFont = HEL_16;
        }
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideProgress];
            
            if (finshBlock)
            {
                finshBlock();
            }
            
            
        });
        
        //        [self performSelector:@selector(hideProgress) withObject:nil afterDelay:1.0];
    }else
    {
        
        
        [self hideProgress];
        
        if (finshBlock)
        {
            finshBlock();
        }
    }
}

-(void)hideProgress
{
    //    _progressHUD.hidden = YES;
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
    if (_progressHUD != nil) {
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
    }
    
}

-(void)timeoutFailed
{
    if (_xmppTimer)
    {
        [_xmppTimer invalidate];
        _xmppTimer = nil;
    }
    
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
    if (_progressHUD != nil) {
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
    }
    
    
    _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_progressHUD];
    _progressHUD.labelText = @"操作超时，请重试!";
    _progressHUD.mode = MBProgressHUDModeText;
    
    
    [_progressHUD showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
        
    }];
    
    //    _progressHUD.mode = MBProgressHUDModeText;
    //    _progressHUD.labelText = @"操作超时，请重试!";
    //    [self performSelector:@selector(hideProgress) withObject:nil afterDelay:1.0];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
