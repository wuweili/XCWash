//
//  XCUserInfoViewController.m
//  XCWash
//
//  Created by 吴伟庆 on 15/3/17.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCUserInfoViewController.h"
#import "UIButton+Avatar.h"
#import "XCUserInfoTableViewCell.h"
#import "UIImage+IMChat.h"
#import "DocumentUtil.h"
#import "Photo.h"
#import "UITextField+HXExtentRange.h"
#import "IMUnitsMethods.h"



@interface XCUserInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,XCUserInfoTableViewCellDelegate>
{
    UIImageView *_headImageView;
    UIButton *_headImageButton;
    
    NSArray *_section1Array;
    NSArray *_section2Array;
    
    UITableView *_userInfoTableView;
    
    UIToolbar *_toolbar;
    
    NSString *_userPhone;
    NSString *_nickName;
    BOOL _switchOn;
    
    NSIndexPath *_currentFirstRespondIndexPath;
    
    NSString *_userPhotoUrlStr;


    
}

@end

@implementation XCUserInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"账户信息";
    
    [self initData];
    
    [self initHeadView];
    
    [self initTableView];
    [self initLogoutButton];

    
}

-(void)initLogoutButton
{
    UIButton *logoutButton = [[UIButton alloc]initWithFrame:CGRectMake(10, self.view.bounds.size.height - 66-10-44, self.view.bounds.size.width-20, 88/2)];
    logoutButton.backgroundColor = [UIColor clearColor];
    logoutButton.layer.cornerRadius = 4;
    [logoutButton setTitle:@"退出账号" forState:UIControlStateNormal];
    [logoutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:XC_Logout_btn_image forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(clickLogoutButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutButton];
}




-(void)initData
{
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification
     object:nil];
    
    _section1Array = [NSArray arrayWithObjects:@"手机号",@"昵称", nil];
    
    _section2Array = [NSArray arrayWithObjects:@"系统消息", nil];
    
    _currentFirstRespondIndexPath = nil;
    
    _userPhone = [XCUserModel shareInstance].userTelphoneNum;
    _nickName = [XCUserModel shareInstance].userName;
    
    _userPhotoUrlStr = @"";
    
    if ([[XCUserModel shareInstance].u_get_message isEqualToString:@"0"])
    {
        _switchOn = NO;
    }
    else
    {
        _switchOn = YES;
    }
    
    
    
}

-(void)initHeadView
{
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 282/2)];
    _headImageView.backgroundColor = UIColorFromRGB(0x333333);
    _headImageView.userInteractionEnabled = YES;
    _headImageButton = [[UIButton alloc]initWithFrame:CGRectMake(kMainScreenWidth/2-142/4, 14, 142/2, 142/2)];
    _headImageButton.layer.cornerRadius = _headImageButton.frame.size.width/2;
    
    [_headImageButton setUserAvatarWithUserId:[XCUserModel shareInstance].userId headUrl:[XCUserModel shareInstance].userPictureUrl withSize:71 update:YES loadImageFinish:nil];
    
    [_headImageButton addTarget:self action:@selector(clickHeadImageButton) forControlEvents:UIControlEventTouchUpInside];
    [_headImageView addSubview:_headImageButton];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _headImageButton.frame.origin.y+_headImageButton.frame.size.height+5, kMainScreenWidth, 30)];
    nameLabel.backgroundColor= [UIColor clearColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = [XCUserModel shareInstance].userName;
    nameLabel.font = HEL_16;
    nameLabel.textColor = [UIColor whiteColor];
    [_headImageView addSubview:nameLabel];

}

-(void)initTableView
{
    _userInfoTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,kMainScreenWidth ,kScreenHeightNoStatusAndNoNaviBarHeight-10-46) style:UITableViewStyleGrouped];
    _userInfoTableView.delegate=self;
    _userInfoTableView.dataSource=self;
    _userInfoTableView.showsVerticalScrollIndicator = NO;
    _userInfoTableView.backgroundColor = [UIColor clearColor];
    _userInfoTableView.backgroundView = nil;
    _userInfoTableView.tableHeaderView = _headImageView;
    _userInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_userInfoTableView];
}



-(void)clickLeftNavMenu
{
    
    [self updatePersonnalInfo];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UITableViewDelegate -

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }
    else
    {
        return 10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.row)
    {
        case 0:
        {
            
            
        }
            break;
        case 1:
        {
            
            
        }
            break;
            
        default:
            break;
    }
    
    
    
    
    
}

#pragma mark - UITableViewDataSource -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [_section1Array count];
    }
    else
        return [_section2Array count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"userInfoCell%d",indexPath.row];
    
    XCUserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[XCUserInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier indexPath:indexPath];
    }
    
    if (cell.cellTextField)
    {
        cell.cellTextField.delegate = self;
    }
    
    cell.delegate = self;
    
    NSString *title = @"";
    
    NSString *contentText;
    
    if (indexPath.section == 0 )
    {
        title = [_section1Array objectAtIndex:indexPath.row];
        
        if (indexPath.row == 0)
        {
            contentText = _userPhone;
        }
        else
        {
            contentText = _nickName;
        }
        
        
    }
    else
    {
        title = [_section2Array objectAtIndex:indexPath.row];
        
        
    }
    
    [cell setCellContentWithTitle:title contentText:contentText indexPath:indexPath switchOn:_switchOn];
    
    
    return cell;
    
    
}


-(void)clickHeadImageButton
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:STR_CANCEL otherButtonTitles:STR_TAKE_PHOTO_LIBRAY,STR_TAKE_PHOTO_BY_CAMRER , nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate -
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self takePhotoFromLibrary];
    }
    else if (buttonIndex == 2)
    {
        [self takePhotoFromCamera];
    }
}


#pragma mark - take photo from library
- (void)takePhotoFromLibrary
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerController.delegate = self;
        pickerController.allowsEditing = YES;
        
        [self presentViewController:pickerController animated:YES completion:nil];
    }
    
}

- (void)takePhotoFromCamera
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil
                                                     message:STR_CANT_TAKEPHOTO
                                                    delegate:nil
                                           cancelButtonTitle:STR_SURE
                                           otherButtonTitles:nil];
        [av show];
        return;
    }
    
    // 跳转到相机页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
}


#pragma mark -
#pragma Delegate method UIImagePickerControllerDelegate
// 用户选择取消
- (void)imagePickerControllerDidCancel: (UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    if(CurrentSystemVersion >= 7.0)
    {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
}


- (void)imagePickerController: (UIImagePickerController *)picker didFinishPickingMediaWithInfo: (NSDictionary *)info
{
    if(CurrentSystemVersion >= 7.0)
    {
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
    }
    UIImage *image=nil;
    
    image =[info objectForKey:UIImagePickerControllerEditedImage];
    
    //当图片不为空时显示图片并保存图片
    if (image != nil)
    {
        
        UIImage *imageOrigin =[info objectForKey:UIImagePickerControllerEditedImage];
        image = [UIImage imageWithData:UIImageJPEGRepresentation(imageOrigin, 0.1)] ;
        
        UIImage *circleImage = [image circleImageWithSize:71];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            BOOL isExist = NO;
            NSString *iconPath = [DocumentUtil getUserHeadAvatarByUserId:[XCUserModel shareInstance].userId isExist:&isExist];
            if (isExist)
            {
                [Photo unloadImageForKey:iconPath];
            }
            
            
            
            [DocumentUtil saveUserAvatar:imageOrigin withUserId:[XCUserModel shareInstance].userId];
            
            
        });
        
        [_headImageButton setImage:circleImage forState:UIControlStateNormal];
        
        
        image = [UIImage imageWithData:[DocumentUtil fixImage:image compressionLimite:IMAGE_COMPRESS_LIMIT resizeLimite:IMAGE_RESIZE_LIMIT]];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [self uploadHeadImageWithImage:image];
        });
        
        
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


//上传头像
-(void)uploadHeadImageWithImage:(UIImage *)image
{
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    NSMutableArray* keyArray = [[NSMutableArray alloc]init];
    
    if (image)
    {
        NSData* data = UIImageJPEGRepresentation(image, 1.0);
        [dataArray addObject:data];
        [keyArray addObject:@"file"];
    }
    
    
    [XCDataManage uploadImageWithImagesArray:dataArray WithImageKeysArray:keyArray withBlock:^(NSString *fileUrlStr, NSString *retcode, NSString *retMessage, NSError *error) {
        
        if ([retcode isEqualToString:HTTP_OK])
        {
            DDLogInfo(@"上传成功");
            
            [self displaySomeInfoWithInfo:@"更新头像成功" finsh:nil];
            
            _userPhotoUrlStr = fileUrlStr;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:Notify_update_info_success object:nil];
            
            
        }
        else
        {
            DDLogInfo(@"上传失败");
        }
        
        
    }];
 
    
}


-(void)updatePersonnalInfo
{
    [XCDataManage updateUserInfoWithNickName:_nickName headImageUrlStr:_userPhotoUrlStr withBlock:^(NSString *retcode, NSString *retmessage, NSError *error) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:Notify_update_info_success object:nil];
        
        
    }];
}


#pragma mark - 退出账号 -

-(void)clickLogoutButton
{
    [[NSNotificationCenter defaultCenter] postNotificationName:Notify_quit_success object:nil];
 
    [self dismissViewControllerAnimated:YES completion:^{
        
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:AccountLoginResult];
        
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:LOGIN_SUCCESS_USER_ID];
        
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:LOGIN_SUCCESS_USER_NAME];
        
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:LOGIN_SUCCESS_USER_URL];
        
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
    }];
    
}


#pragma mark - UITextFieldDelegate


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
    
    if (textField.tag == kPersonnalNameTextFieldTag)
    {
        _currentFirstRespondIndexPath = [NSIndexPath indexPathForRow:textField.tag-1000 inSection:0];
    }
    
    
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField.tag == kPersonnalNameTextFieldTag)
    {
        _nickName = textField.text;
        
    }
    
    
}

-(void)textFieldDidChange:(UITextField*)textField
{
    
    
    if (textField.tag == kPersonnalNameTextFieldTag)
    {
        
       [IMUnitsMethods limitInputTextWithUITextField:textField limit:USER_NICKNAME_LENGTH_MAX];
        
    }
    
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *newtxt = [NSMutableString stringWithString:textField.text];
    [newtxt replaceCharactersInRange:range withString:string];
    NSUInteger newLength = [IMUnitsMethods unicodeLengthOfString:newtxt];
    
    if (textField.tag == kPersonnalNameTextFieldTag)
    {
        if (newLength > USER_NICKNAME_LENGTH_MAX)
        {
            for (int i = 0; i< string.length; i++)
            {
                
                if ([IMUnitsMethods unicodeLengthOfString:[string substringToIndex:i]] == USER_NICKNAME_LENGTH_MAX - [IMUnitsMethods unicodeLengthOfString:textField.text])
                {
                    NSMutableString *txtStr = [NSMutableString stringWithString:textField.text];
                    [txtStr replaceCharactersInRange:range withString:[string substringToIndex:i]];
                    textField.text = [NSString stringWithFormat:@"%@",txtStr];
                    
                    [textField setSelectedRange:NSMakeRange(range.location+[IMUnitsMethods unicodeLengthOfString:[string substringToIndex:i]], 0)];
                    
                }
                
            }
            
            NSString *tipMsg = [NSString stringWithFormat:@"输入的文字不能超过%d个字",USER_NICKNAME_LENGTH_MAX];
            
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
                    
                    return (USER_NICKNAME_LENGTH_MAX >= [IMUnitsMethods unicodeLengthOfString:newtxt]);
                }
            }
            else
            {
                return (USER_NICKNAME_LENGTH_MAX >= [IMUnitsMethods unicodeLengthOfString:newtxt]);
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
    _userInfoTableView.contentInset = UIEdgeInsetsMake(0.0f,
                                               0.0f,
                                               bottomInset,
                                               0.0f);
    
    [UIView commitAnimations];
    
    if (_currentFirstRespondIndexPath != nil)
    {
        [_userInfoTableView scrollToRowAtIndexPath:_currentFirstRespondIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
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
    
    _userInfoTableView.contentInset = UIEdgeInsetsZero;
    [UIView commitAnimations];
    
    //    [_detailInfoTableView scrollToRowAtIndexPath:_drugAllergyCellIndex atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
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
