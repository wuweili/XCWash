//
//  XCMakeYuYinOrderViewController.m
//  XCWash
//
//  Created by wuweiqing on 15/4/5.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCMakeYuYinOrderViewController.h"
#import "XCMakeOrderTableViewCell.h"
#import "IMUnitsMethods.h"
#import "UITextField+HXExtentRange.h"
#import "DocumentUtil.h"
#import "DateFormate.h"

@interface XCMakeYuYinOrderViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,AVAudioPlayerDelegate>
{
    UIView *_footView;

    NSString *_recieveAddressStr;
    NSString *_sendAddressStr;
    
    UIView *_recordHeadView;
    
    UITableView *_tableView;
    
    NSIndexPath *_currentFirstRespondIndexPath;


    
}

@end

@implementation XCMakeYuYinOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
    [self initData];
    
    
}

-(void)initUI
{
    self.title = @"现在清洗";
    
    [self initConfirmButton];
    
    [self initRecordHeadView];
    
    [self initTableView];
    
    
}

-(void)initRecordHeadView
{
    _recordHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 360/2)];
    _recordHeadView.backgroundColor = UIColorFromRGB(0xe6e6e6);
//    _recordHeadView.alpha = 0.5;

    
    UIButton *playRecordButton = [[UIButton alloc]initWithFrame:CGRectMake((kMainScreenWidth-175)/2, 0, 175, 175)];
    playRecordButton.layer.cornerRadius = 4;
    [playRecordButton setBackgroundImage:XC_XCYuyin_Listen_image forState:UIControlStateNormal];
    
    [playRecordButton addTarget:self action:@selector(clickPlayRecordButton) forControlEvents:UIControlEventTouchUpInside];
    [_recordHeadView addSubview:playRecordButton];
    
    
    
    
}

-(void)initData
{
    _recieveAddressStr = @"";
    _sendAddressStr = @"";
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification
     object:nil];
    
}




-(void)initConfirmButton
{
    _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 216/2)];
    _footView.backgroundColor = UIColorFromRGB(0xe6e6e6);
    
    UIButton *confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 118/2, (kMainScreenWidth-20), 44)];
    confirmButton.layer.cornerRadius = 4;
    //    Start_able_bg
    
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    
    [confirmButton setBackgroundImage:Start_able_bg forState:UIControlStateNormal];
    
    [confirmButton addTarget:self action:@selector(clickConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    
    [_footView addSubview:confirmButton];
    
    
    
    
}


-(void)initTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,kMainScreenWidth ,kScreenHeightNoStatusAndNoNaviBarHeight) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    _tableView.tableFooterView = _footView;
    _tableView.tableHeaderView = _recordHeadView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(void)clickLeftNavMenu
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate -

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark - UITableViewDataSource -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"orderCell%d",indexPath.section];
    XCMakeOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[XCMakeOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier indexPath:indexPath makeOrderMethod:MakeOrderMethod_yuyin];
    }
    
    NSString *cellStr;
    
    if (indexPath.row == 0)
    {
        cellStr = _recieveAddressStr;
    }
    else
    {
        cellStr = _sendAddressStr;
    }
    
    if (cell.cellTextField)
    {
        cell.cellTextField.delegate = self;
    }
    
    
    [cell setcellContentWithIndexPath:indexPath andContentStr:cellStr makeOrderMethod:MakeOrderMethod_yuyin];
    
    return cell;
    
}

#pragma mark - UITextFieldDelegate


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
    
    _currentFirstRespondIndexPath = [NSIndexPath indexPathForRow:textField.tag-2000 inSection:0];
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField.tag == kRecieveTextFieldTag)
    {
        _recieveAddressStr = textField.text;
    }
    else if (textField.tag == kSendTextFieldTag)
    {
        _sendAddressStr = textField.text;
    }
    
    
    //    [_tableView reloadData];
    
}

-(void)textFieldDidChange:(UITextField*)textField
{
    
    
    if (textField.tag == kRecieveTextFieldTag)
    {
        
        [IMUnitsMethods limitInputTextWithUITextField:textField limit:RECIEVE_ADDRESS_LENGTH_MAX];
        
    }
    else if (textField.tag == kSendTextFieldTag)
    {
        [IMUnitsMethods limitInputTextWithUITextField:textField limit:SEND_ADDRESS_LENGTH_MAX];
        
    }
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *newtxt = [NSMutableString stringWithString:textField.text];
    [newtxt replaceCharactersInRange:range withString:string];
    NSUInteger newLength = [IMUnitsMethods unicodeLengthOfString:newtxt];
    
    if (textField.tag == kRecieveTextFieldTag)
    {
        if (newLength > RECIEVE_ADDRESS_LENGTH_MAX)
        {
            for (int i = 0; i< string.length; i++)
            {
                
                if ([IMUnitsMethods unicodeLengthOfString:[string substringToIndex:i]] == RECIEVE_ADDRESS_LENGTH_MAX - [IMUnitsMethods unicodeLengthOfString:textField.text])
                {
                    NSMutableString *txtStr = [NSMutableString stringWithString:textField.text];
                    [txtStr replaceCharactersInRange:range withString:[string substringToIndex:i]];
                    textField.text = [NSString stringWithFormat:@"%@",txtStr];
                    
                    [textField setSelectedRange:NSMakeRange(range.location+[IMUnitsMethods unicodeLengthOfString:[string substringToIndex:i]], 0)];
                    
                }
                
            }
            
            NSString *tipMsg = [NSString stringWithFormat:@"输入的文字不能超过%d个字",RECIEVE_ADDRESS_LENGTH_MAX];
            
            [self displaySomeInfoWithInfo:tipMsg finsh:nil];
            
            
            return NO;
            
        }
        else
        {
            if (CurrentSystemVersion < 7.0)
            {
                if ([IMUnitsMethods stringContainsEmoji:string])
                {
                    return NO;
                }
                else
                {
                    
                    return (RECIEVE_ADDRESS_LENGTH_MAX >= [IMUnitsMethods unicodeLengthOfString:newtxt]);
                }
            }
            else
            {
                return (RECIEVE_ADDRESS_LENGTH_MAX >= [IMUnitsMethods unicodeLengthOfString:newtxt]);
            }
        }
    }
    else if (textField.tag == kSendTextFieldTag)
    {
        if (newLength > SEND_ADDRESS_LENGTH_MAX)
        {
            for (int i = 0; i< string.length; i++)
            {
                
                if ([IMUnitsMethods unicodeLengthOfString:[string substringToIndex:i]] == SEND_ADDRESS_LENGTH_MAX - [IMUnitsMethods unicodeLengthOfString:textField.text])
                {
                    NSMutableString *txtStr = [NSMutableString stringWithString:textField.text];
                    [txtStr replaceCharactersInRange:range withString:[string substringToIndex:i]];
                    textField.text = [NSString stringWithFormat:@"%@",txtStr];
                    
                    [textField setSelectedRange:NSMakeRange(range.location+[IMUnitsMethods unicodeLengthOfString:[string substringToIndex:i]], 0)];
                    
                }
                
            }
            
            
            NSString *tipMsg = [NSString stringWithFormat:@"输入的文字不能超过%d个字",SEND_ADDRESS_LENGTH_MAX];
            
            [self displaySomeInfoWithInfo:tipMsg finsh:nil];
            
            
            
            return NO;
            
        }
        else
        {
            if (CurrentSystemVersion < 7.0)
            {
                if ([IMUnitsMethods stringContainsEmoji:string])
                {
                    return NO;
                }
                else
                {
                    
                    return (SEND_ADDRESS_LENGTH_MAX >= [IMUnitsMethods unicodeLengthOfString:newtxt]);
                }
            }
            else
            {
                return (SEND_ADDRESS_LENGTH_MAX >= [IMUnitsMethods unicodeLengthOfString:newtxt]);
            }
        }
    }
    
    return YES;
    
    
    
}


#pragma mark - UIKeyboardNotification-
- (void) handleKeyboardWillShow:(NSNotification *)paramNotification
{
    
    NSDictionary *userInfo = [paramNotification userInfo];
    
    NSValue *animationCurveObject =
    [userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    NSValue *animationDurationObject =
    [userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSValue *keyboardEndRectObject =
    [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    
    NSUInteger animationCurve = 0;
    double animationDuration = 0.0f;
    CGRect keyboardEndRect = CGRectMake(0, 0, 0, 0);
    
    [animationCurveObject getValue:&animationCurve];
    [animationDurationObject getValue:&animationDuration];
    [keyboardEndRectObject getValue:&keyboardEndRect];
    
    [UIView beginAnimations:@"changeTableViewContentInset" context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    CGRect intersectionOfKeyboardRectAndWindowRect = CGRectIntersection(window.frame, keyboardEndRect);
    CGFloat bottomInset = intersectionOfKeyboardRectAndWindowRect.size.height;
    _tableView.contentInset = UIEdgeInsetsMake(0.0f,
                                               0.0f,
                                               bottomInset,
                                               0.0f);
    
    [UIView commitAnimations];
    
    if (_currentFirstRespondIndexPath != nil)
    {
        [_tableView scrollToRowAtIndexPath:_currentFirstRespondIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
    }
    
}

- (void) handleKeyboardWillHide:(NSNotification *)paramNotification
{
    NSDictionary *userInfo = [paramNotification userInfo];
    NSValue *animationCurveObject =
    [userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSValue *animationDurationObject =[userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSValue *keyboardEndRectObject =
    [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey]; NSUInteger animationCurve = 0;
    double animationDuration = 0.0f;
    CGRect keyboardEndRect = CGRectMake(0, 0, 0, 0);
    
    [animationCurveObject getValue:&animationCurve]; [animationDurationObject getValue:&animationDuration]; [keyboardEndRectObject getValue:&keyboardEndRect];
    [UIView beginAnimations:@"changeTableViewContentInset" context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    
    _tableView.contentInset = UIEdgeInsetsZero;
    [UIView commitAnimations];
    
    //    [_detailInfoTableView scrollToRowAtIndexPath:_drugAllergyCellIndex atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

#pragma mark - 点击确定按钮 -

-(void)clickConfirmButton
{
    if ([NSString isBlankString:_recieveAddressStr])
    {
        [self displaySomeInfoWithInfo:@"取件地址不能为空" finsh:nil];
        return;
    }
    
    if ([NSString isBlankString:_sendAddressStr])
    {
        [self displaySomeInfoWithInfo:@"送件地址不能为空" finsh:nil];
        return;
    }
    
    [self initMBHudWithTitle:nil];
    
    NSString *strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * otherrecordFileUrlStr = [NSString stringWithFormat:@"%@/makeOrder%@.aac", strUrl,@"1234"];
    
    
    [XCDataManage uploadRecordFileWithFilePath:otherrecordFileUrlStr withBlock:^(NSString *fileUrlStr, NSString *retcode, NSString *retMessage, NSError *error) {
        
        if ([retcode isEqualToString:HTTP_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:nil finsh:nil];
            
            [self uploadOtherOrderInfoWithVoiceUrl:fileUrlStr];
            
        }
        else
        {
            [self stopMBHudAndNSTimerWithmsg:retMessage finsh:nil];
        }
        
        
    }];
    
    
    
    
}

-(void)uploadOtherOrderInfoWithVoiceUrl:(NSString *)voiceUrl
{
    [self initMBHudWithTitle:nil];
    
    [XCDataManage makeOrderWithBlock:^(NSMutableArray *messageArray, NSString *retcode, NSString *retMessage, NSError *error) {
        
        if ([retcode isEqualToString:HTTP_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:@"下单成功" finsh:^{
                [self.navigationController popViewControllerAnimated:YES];
                
            }];
            
            
            
        }
        else
        {
            [self stopMBHudAndNSTimerWithmsg:retMessage finsh:nil];
        }

        
        
        
    } takeTime:[DateFormate getCurrentDateToString] takeAddress:_recieveAddressStr sendAddress:_sendAddressStr voiceUrl:voiceUrl];
    
    
}



#pragma mark - 播放录音

-(void)clickPlayRecordButton
{
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //默认情况下扬声器播放
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];

    
    if (self.avPlay.playing) {
        [self.avPlay stop];
        return;
    }
    
    BOOL isExit;
    NSString *recordFileUrlStr = [DocumentUtil getRecordFileByRecordFileId:[XCUserModel shareInstance].userId isExist:&isExit];
    
    DDLogInfo(@"recordFileUrlStr = %@",recordFileUrlStr);
    
    NSString *strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString * otherrecordFileUrlStr = [NSString stringWithFormat:@"%@/makeOrder%@.aac", strUrl,@"1234"];
    
    DDLogInfo(@"otherrecordFileUrlStr = %@",otherrecordFileUrlStr);

    
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:otherrecordFileUrlStr] error:nil];
    self.avPlay = player;
    self.avPlay.delegate = self;
    [self.avPlay play];
}

#pragma mark - AVAudioPlayerDelegate - 

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"播放完成");
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"播放失败   = %@",error);

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
