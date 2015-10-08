//
//  XCMakeApplyOrderViewController.m
//  XCWash
//
//  Created by wuweiqing on 15/4/5.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCMakeApplyOrderViewController.h"
#import "XCMakeOrderTableViewCell.h"
#import "IMUnitsMethods.h"
#import "UITextField+HXExtentRange.h"


@interface XCMakeApplyOrderViewController ()<UITableViewDataSource,UITableViewDelegate,XCMakeOrderTableViewCellDelegate,UITextFieldDelegate>
{
    NSMutableArray *_dataArray;
    
    UITableView *_tableView;
    
    NSString *_timeStr;
    NSString *_recieveAddressStr;
    NSString *_sendAddressStr;
    NSString *_sendMessageStr;
    
    NSIndexPath *_currentFirstRespondIndexPath;
    
    UIView *_footView;

    
    
}

@end

@implementation XCMakeApplyOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
    [self initData];
    
    [self initTableView];
    
    
}

-(void)initUI
{
    self.title = @"现在清洗";
    
    [self initConfirmButton];
    
    
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

-(void)initData
{
    _timeStr = @"";
    _recieveAddressStr = @"";
    _sendAddressStr = @"";
    _sendMessageStr = @"";
    _currentFirstRespondIndexPath = nil;
    
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification
     object:nil];

    
    
#ifdef XC_TEST
    [_dataArray addObjectsFromArray:[NSArray arrayWithObjects:@"江苏省南京市雨花台区软件大道180号",@"江苏省南京市雨花台区软件大道", nil]];
#endif
    
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
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 3)
    {
        return 1;
    }
    else if (section == 1)
    {
        return 2;
    }
    else
    {
        return 0;
        
        if ([_dataArray count] == 0)
        {
            return  2;

        }
        else
        {
            return  [_dataArray count]+1;

        }
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"orderCell%d",indexPath.section];
    XCMakeOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[XCMakeOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier indexPath:indexPath makeOrderMethod:MakeOrderMethod_normal];
    }
    
    NSString *cellStr;
    
    if (indexPath.section == 0)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cellStr = _timeStr;
        
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            cellStr = _recieveAddressStr;
        }
        else
        {
            cellStr = _sendAddressStr;
        }
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            cellStr = @"历史记录";
            cell.backgroundColor = UIColorFromRGB(0xcccccc);
            
        }
        else
        {
            if ([_dataArray count] == 0)
            {
                cellStr = @"暂无";

            }
            else
            {
                cellStr = [_dataArray objectAtIndex:indexPath.row - 1];
            }
            
            cell.backgroundColor = UIColorFromRGB(0xe6e6e6);
        }
    }
    else
    {
        cellStr = _sendAddressStr;
    }
    
    if (cell.cellTextField)
    {
        cell.cellTextField.delegate = self;
    }
    
    cell.delegate = self;
    
    [cell setcellContentWithIndexPath:indexPath andContentStr:cellStr makeOrderMethod:MakeOrderMethod_normal];

    return cell;

}


#pragma mark - XCMakeOrderTableViewCellDelegate - 

-(void)changeDate:(NSString *)date withCell:(id)cell
{
    XCMakeOrderTableViewCell *timeCell =(XCMakeOrderTableViewCell *)cell;
    [timeCell.cellTextField resignFirstResponder];
    
//    _timeStr =[DateFormate GetString_YYYMMDD:date] ;
    _timeStr = date;
    
    [_tableView reloadData];
    
}

-(void)disMissPickerWithCell:(id)cell
{
    XCMakeOrderTableViewCell *timeCell =(XCMakeOrderTableViewCell *)cell;
    [timeCell.cellTextField resignFirstResponder];
    
    
}


#pragma mark - UITextFieldDelegate


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
    
    if (textField.tag == kOrderTimeTextFieldTag)
    {
        _currentFirstRespondIndexPath = [NSIndexPath indexPathForRow:textField.tag-1000 inSection:0];
    }
    else if (textField.tag == kRecieveTextFieldTag ||textField.tag == kSendTextFieldTag )
    {
        _currentFirstRespondIndexPath = [NSIndexPath indexPathForRow:textField.tag-2000 inSection:1];
    }
    else
    {
        _currentFirstRespondIndexPath = [NSIndexPath indexPathForRow:textField.tag-4000 inSection:3];
    }
    
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField.tag == kOrderTimeTextFieldTag)
    {
        _timeStr = textField.text;
        
    }
    else if (textField.tag == kRecieveTextFieldTag)
    {
        _recieveAddressStr = textField.text;
    }
    else if (textField.tag == kSendTextFieldTag)
    {
        _sendAddressStr = textField.text;
    }
    else
    {
        _sendMessageStr = textField.text;
        
    }
    
//    [_tableView reloadData];
    
}

-(void)textFieldDidChange:(UITextField*)textField
{
    
    
    if (textField.tag == kOrderTimeTextFieldTag)
    {
        
//        [IMUnitsMethods limitInputTextWithUITextField:textField limit:HEIGTH_LENGTH_MAX];
        
    }
    else if (textField.tag == kRecieveTextFieldTag)
    {
        
        [IMUnitsMethods limitInputTextWithUITextField:textField limit:RECIEVE_ADDRESS_LENGTH_MAX];
        
    }
    else if (textField.tag == kSendTextFieldTag)
    {
        [IMUnitsMethods limitInputTextWithUITextField:textField limit:SEND_ADDRESS_LENGTH_MAX];
        
    }
    else
    {
        [IMUnitsMethods limitInputTextWithUITextField:textField limit:SEND_MESSAGE_LENGTH_MAX];
    }
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *newtxt = [NSMutableString stringWithString:textField.text];
    [newtxt replaceCharactersInRange:range withString:string];
    NSUInteger newLength = [IMUnitsMethods unicodeLengthOfString:newtxt];
    
    if (textField.tag == kOrderTimeTextFieldTag)
    {
   
    }
    else if (textField.tag == kRecieveTextFieldTag)
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
    else
    {
        if (newLength > SEND_MESSAGE_LENGTH_MAX)
        {
            for (int i = 0; i< string.length; i++)
            {
                
                if ([IMUnitsMethods unicodeLengthOfString:[string substringToIndex:i]] == SEND_MESSAGE_LENGTH_MAX - [IMUnitsMethods unicodeLengthOfString:textField.text])
                {
                    NSMutableString *txtStr = [NSMutableString stringWithString:textField.text];
                    [txtStr replaceCharactersInRange:range withString:[string substringToIndex:i]];
                    textField.text = [NSString stringWithFormat:@"%@",txtStr];
                    
                    [textField setSelectedRange:NSMakeRange(range.location+[IMUnitsMethods unicodeLengthOfString:[string substringToIndex:i]], 0)];
                    
                }
                
            }
            
            
            NSString *tipMsg = [NSString stringWithFormat:@"输入的文字不能超过%d个字",SEND_MESSAGE_LENGTH_MAX];
            
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
                    
                    return (SEND_MESSAGE_LENGTH_MAX >= [IMUnitsMethods unicodeLengthOfString:newtxt]);
                }
            }
            else
            {
                return (SEND_MESSAGE_LENGTH_MAX >= [IMUnitsMethods unicodeLengthOfString:newtxt]);
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
    if ([NSString isBlankString:_timeStr])
    {
        [self displaySomeInfoWithInfo:@"时间不能为空" finsh:nil];
        return;
    }
    
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
        
        
        
    } takeTime:_timeStr takeAddress:_recieveAddressStr sendAddress:_sendAddressStr voiceUrl:nil];

    
    
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
