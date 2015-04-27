//
//  XCLeftSideViewController.m
//  XCWash
//
//  Created by 吴伟庆 on 15/3/11.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCLeftSideViewController.h"
#import "IMUnitsMethods.h"
#import "XCLeftSideTableViewCell.h"
#import "XCUserInfoViewController.h"
#import "XCAddressManagerViewController.h"
#import "XCMyScoreViewController.h"
#import "XCMessageCenterViewController.h"
#import "XCAboutMeViewController.h"
#import "XCMyOrderViewController.h"
#import "XCSerciveProvisionViewController.h"

@interface XCLeftSideViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIView *_unLoginView;
    UITableView *_loginTableView;
    
    UITextField *_telTextField;
    UIButton *_verifyButton;
    UITextField *_verifyCodeField;
    UIButton *_startButton;
    
    NSTimer *_timer;
    
    NSInteger countDownValue;
    
    NSArray *_dataArray;
    NSArray *_imageArray;
    
}

@end

@implementation XCLeftSideViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyQuitSuccess) name:Notify_quit_success object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyUpdateInfoSuccess) name:Notify_update_info_success object:nil];
    
    [self initUI];
    
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_loginTableView)
    {
        [_loginTableView reloadData];
    }
}

-(void)initUI
{
    self.view.backgroundColor = UIColorFromRGB(0xe6e6e6);
    
    if (CurrentSystemVersion>=7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight;
        
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    
    if (XCAPPDELEGATE.isLogin)
    {
        self.title = @"个人中心";


        [self setLoginView];

    }
    else
    {
        self.title = @"手机验证";

        
        [self setViewWhenUnLogin];


    }
        
    
    
}

-(void)setViewWhenUnLogin
{
    _unLoginView = [[UIView alloc]initWithFrame:CGRectMake(0,0,MAX_LEFT_SIDE_WIDTH ,kScreenHeightNoStatusAndNoNaviBarHeight)];
    
    _unLoginView.backgroundColor = UIColorFromRGB(0xe6e6e6);
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, self.view.bounds.size.width -20, 20)];
    titleLabel.text = @"为方便金牌服务员联系您，请验证手机~";
    titleLabel.font = HEL_14;
    titleLabel.textColor = UIColorFromRGB(0x666666);
    [_unLoginView addSubview:titleLabel];
    
    _telTextField = [[UITextField alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + titleLabel.frame.size.height +10, 160, 45.0)];
    _telTextField.placeholder=@"请输入手机号";
    _telTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _telTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _telTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _telTextField.returnKeyType = UIReturnKeyDone;
    _telTextField.font = HEL_15;
    _telTextField.delegate = self;
    _telTextField.layer.borderColor=[UIColorFromRGB(0xffad38) CGColor];
    _telTextField.layer.cornerRadius = 4.0;
    _telTextField.layer.borderWidth = 1.0;
    _telTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    [_unLoginView addSubview:_telTextField];
    
    _verifyButton = [[UIButton alloc]initWithFrame:CGRectMake(_telTextField.frame.origin.x +_telTextField.frame.size.width+11, _telTextField.frame.origin.y, 80, 45)];
    
    [_verifyButton setBackgroundImage:VerifyBtn_orange_bg forState:UIControlStateNormal];
    
    [_verifyButton setBackgroundImage:VerifyBtn_gray_bg forState:UIControlStateHighlighted];
    [_verifyButton setBackgroundImage:VerifyBtn_gray_bg forState:UIControlStateDisabled];
    
    _verifyButton.enabled = YES;
    
    [_verifyButton setTitle:@"验证" forState:UIControlStateNormal];
    [_verifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_verifyButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    [_verifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    
    [_verifyButton addTarget:self action:@selector(clickVerifyButton) forControlEvents:UIControlEventTouchUpInside];
    [_unLoginView addSubview:_verifyButton];
    
    _verifyCodeField = [[UITextField alloc] initWithFrame:CGRectMake(_telTextField.frame.origin.x, _telTextField.frame.origin.y + _telTextField.frame.size.height +10, 250, 45.0)];
    _verifyCodeField.placeholder=@"请输入验证码";
    _verifyCodeField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _verifyCodeField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _verifyCodeField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _verifyCodeField.returnKeyType = UIReturnKeyDone;
    _verifyCodeField.font = HEL_15;
    _verifyCodeField.layer.borderColor=[UIColorFromRGB(0xcccccc) CGColor];
    _verifyCodeField.layer.cornerRadius = 4.0;
    _verifyCodeField.layer.borderWidth = 1.0;
    _verifyCodeField.delegate = self;
    _verifyCodeField.borderStyle = UITextBorderStyleRoundedRect;
    
    [_unLoginView addSubview:_verifyCodeField];
    
    
    _startButton = [[UIButton alloc]initWithFrame:CGRectMake(_verifyCodeField.frame.origin.x, _verifyCodeField.frame.origin.y +_verifyCodeField.frame.size.height+20, _verifyCodeField.frame.size.width, 45)];
    
    [_startButton setBackgroundImage:Start_able_bg forState:UIControlStateNormal];
    
    [_startButton setBackgroundImage:Start_disable_bg forState:UIControlStateHighlighted];
    [_startButton setBackgroundImage:Start_disable_bg forState:UIControlStateDisabled];
    
    _startButton.enabled = YES;
    
    [_startButton setTitle:@"开始" forState:UIControlStateNormal];
    [_startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_startButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    [_startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    
    [_startButton addTarget:self action:@selector(clickStartButton) forControlEvents:UIControlEventTouchUpInside];
    [_unLoginView addSubview:_startButton];
    
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(_startButton.frame.origin.x+15, _startButton.frame.origin.y +_startButton.frame.size.height+10, 120, 20)];
    tipLabel.text = @"点击-开始,即表示同意";
    tipLabel.font = HEL_12;
    tipLabel.backgroundColor = [UIColor clearColor];
    tipLabel.textColor = UIColorFromRGB(0x666666);
    [_unLoginView addSubview:tipLabel];
    
    UIButton *tipButton = [[UIButton alloc]initWithFrame:CGRectMake(tipLabel.frame.origin.x+tipLabel.frame.size.width-10, tipLabel.frame.origin.y,100, 20)];
    [tipButton setTitle:@"《金牌服务协议》" forState:UIControlStateNormal];
    [tipButton setTitleColor:UIColorFromRGB(0x1190d9) forState:UIControlStateNormal];
    [tipButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [tipButton setBackgroundColor:[UIColor clearColor]];
    [tipButton addTarget:self action:@selector(clickTipButton) forControlEvents:UIControlEventTouchUpInside];
    tipButton.titleLabel.font = HEL_12;
    
    [_unLoginView addSubview:tipButton];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    [self.view addSubview:_unLoginView];
}

-(void)setLoginView
{
    [self initData];
    
    [self initTableView];
}

-(void)initData
{
    _dataArray = [NSArray arrayWithObjects:@"我的订单",@"地址管理",@"我的积分",@"消息中心",@"关于我们", nil];
    
    _imageArray = [NSArray arrayWithObjects:MyOrder_image,AddressManage_image,MyOrder_image,MessageCenter_image,AboutMe_image, nil];
    
}

-(void)initTableView
{
    _loginTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,MAX_LEFT_SIDE_WIDTH ,kScreenHeightNoStatusAndNoNaviBarHeight) style:UITableViewStylePlain];
    _loginTableView.delegate=self;
    _loginTableView.dataSource=self;
    _loginTableView.showsVerticalScrollIndicator = NO;
    _loginTableView.backgroundColor = [UIColor clearColor];
    _loginTableView.backgroundView = nil;
    
    _loginTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_loginTableView];
}

-(void)clickVerifyButton
{
    if (![IMUnitsMethods regexPhoneNumber:_telTextField.text])
    {
        UIAlertView *telAlertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:STR_ALREADY_KNOW otherButtonTitles:nil, nil];
        [telAlertView show];
        
        return;
    }
    
    
    [self initMBHudWithTitle:nil];
    
    
    
    countDownValue = 60;
    [_verifyButton setTitle:[NSString stringWithFormat:@"%d秒",countDownValue] forState:UIControlStateNormal];
    _verifyButton.enabled = NO;
    _startButton.enabled = YES;
    [_timer setFireDate:[NSDate distantPast]];
    
    [XCDataManage getValiCodeWithBlock:^(NSString *retcode, NSString *retmessage, NSError *error) {
        
        if (error)
        {
            [self stopMBHudAndNSTimerWithmsg:retmessage finsh:nil];
        }
        else if ([retcode isEqualToString:HTTP_OK])
        {
            DDLogInfo(@"获取验证码请求成功");
            [self stopMBHudAndNSTimerWithmsg:@"验证码已发送" finsh:nil];
            
        }
        else
        {
            [self stopMBHudAndNSTimerWithmsg:retmessage finsh:nil];
        }
        
        
    } userPhone:_telTextField.text];

}

-(void)clickStartButton
{
    //test
    if ([NSString isBlankString:_telTextField.text] || [NSString isBlankString:_verifyCodeField.text])
    {
        UIAlertView *telAlertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的手机号码和验证码" delegate:nil cancelButtonTitle:STR_ALREADY_KNOW otherButtonTitles:nil, nil];
        [telAlertView show];
        
        return;

    }
    
    
    [self initMBHudWithTitle:nil];
    
    
    [XCDataManage loginWithBlock:^(NSString *retcode, NSString *retmessage, NSError *error) {
        
        if ([retcode isEqualToString:HTTP_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:nil finsh:nil];
            
            
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:AccountLoginResult];
            
            [[NSUserDefaults standardUserDefaults] setObject:[XCUserModel shareInstance].userId forKey:LOGIN_SUCCESS_USER_ID];
            
            [[NSUserDefaults standardUserDefaults] setObject:[XCUserModel shareInstance].userName forKey:LOGIN_SUCCESS_USER_NAME];
            [[NSUserDefaults standardUserDefaults] setObject:[XCUserModel shareInstance].userPictureUrl forKey:LOGIN_SUCCESS_USER_URL];
            
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            

            
            [self loginSuccess];

        }
        else
        {
            [self stopMBHudAndNSTimerWithmsg:retmessage finsh:nil];
        }
        
        
        
    } userPhone:_telTextField.text valiCode:_verifyCodeField.text];
    
    
    
    
}

-(void)clickTipButton
{
    XCSerciveProvisionViewController *serviceMVC = [[XCSerciveProvisionViewController alloc]init];
    UINavigationController *addressNav = [[UINavigationController alloc]initWithRootViewController:serviceMVC];
    
    addressNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController presentViewController:addressNav animated:YES completion:^{
        
    }];

    
}

-(void)timeChange
{
    countDownValue--;
    [_verifyButton setTitle:[NSString stringWithFormat:@"%d秒",countDownValue] forState:UIControlStateNormal];
    if (countDownValue<=0)
    {
        
        [_timer setFireDate:[NSDate distantFuture]];
        [_verifyButton setTitle:[NSString stringWithFormat:@"验证"] forState:UIControlStateNormal];
        _verifyButton.enabled = YES;
        _startButton.enabled = YES;
        
    }

    
    
}

//#pragma mark - UITextFieldDelegate-
//
- (void)textFieldDidBeginEditing:(UITextField *)textField
{

    
    [textField becomeFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    
}


-(void)textFieldDidChange:(UITextField*)textField
{
    
    [IMUnitsMethods limitInputTextWithUITextField:textField limit:20];
    
    //    [textField setText:[IMUnitsMethods disable_emoji:[textField text]]];
    
}

#pragma mark - UITableViewDelegate - 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 141;
    }
    else
    {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.row)
    {
        case 0:
        {
            XCUserInfoViewController *userInfoMVC = [[XCUserInfoViewController alloc]init];
            UINavigationController *userInfoNav = [[UINavigationController alloc]initWithRootViewController:userInfoMVC];
            
            userInfoNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self.navigationController presentViewController:userInfoNav animated:YES completion:^{
                
            }];

        }
            break;
        case 1:
        {
             XCMyOrderViewController*orderMVC = [[XCMyOrderViewController alloc]init];
            UINavigationController *orderNav = [[UINavigationController alloc]initWithRootViewController:orderMVC];
            
            orderNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self.navigationController presentViewController:orderNav animated:YES completion:^{
                
            }];

            
        }
            break;
        case 2:
        {
            XCAddressManagerViewController *addressInfoMVC = [[XCAddressManagerViewController alloc]init];
            UINavigationController *addressNav = [[UINavigationController alloc]initWithRootViewController:addressInfoMVC];
            
            addressNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self.navigationController presentViewController:addressNav animated:YES completion:^{
                
            }];

        }
            break;
        case 3:
        {
            XCMyScoreViewController *myScoreMVC = [[XCMyScoreViewController alloc]init];
            UINavigationController *myScoreNav = [[UINavigationController alloc]initWithRootViewController:myScoreMVC];
            
            myScoreNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self.navigationController presentViewController:myScoreNav animated:YES completion:^{
                
            }];

        }
            break;
        case 4:
        {
            XCMessageCenterViewController *messageCenterMVC = [[XCMessageCenterViewController alloc]init];
            UINavigationController *messageCenterNav = [[UINavigationController alloc]initWithRootViewController:messageCenterMVC];
            
            messageCenterNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self.navigationController presentViewController:messageCenterNav animated:YES completion:^{
                
            }];

        }
            break;
        case 5:
        {
            XCAboutMeViewController *aboutMeMVC = [[XCAboutMeViewController alloc]init];
            UINavigationController *aboutMeNav = [[UINavigationController alloc]initWithRootViewController:aboutMeMVC];
            
            aboutMeNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self.navigationController presentViewController:aboutMeNav animated:YES completion:^{
                
            }];

        }
            break;
            
        default:
            break;
    }

    
    
    
    
}

#pragma mark - UITableViewDataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count]+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"leftSideCell%d",indexPath.row];
    
    XCLeftSideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[XCLeftSideTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier indexPath:indexPath];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [cell setCellContentWithIndexPath:indexPath imageArray:_imageArray titleArray:_dataArray];
    
    return cell;
    
    
}


-(void)loginSuccess
{
    if (_unLoginView)
    {
        [_unLoginView removeFromSuperview];
    }
    
    if (!_loginTableView)
    {
        [self setLoginView];
    }
    else
    {
        [self.view addSubview:_loginTableView];
        [_loginTableView reloadData];
    }
    
}


-(void)notifyQuitSuccess
{
    [self logoutSuccess];
}

-(void)logoutSuccess
{
    if (_loginTableView)
    {
        [_loginTableView removeFromSuperview];
    }
    
    if (!_unLoginView)
    {
        [self setViewWhenUnLogin];
    }
    else
    {
        [self.view addSubview:_unLoginView];
    }
}


-(void)notifyUpdateInfoSuccess
{
    [_loginTableView reloadData];
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
