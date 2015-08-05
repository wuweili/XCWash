//
//  XCAddressManagerViewController.m
//  XCWash
//
//  Created by 吴伟庆 on 15/3/17.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCAddressManagerViewController.h"
#import "XCAddressModel.h"

@interface XCAddressManagerViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIView *_segmentBackView;
    
    UITableView *_addressTableView;
    
    NSArray *_segmentArray;
    
    NSMutableArray *_dataArray;
    
    UIView *_addAddressView;
    
    UITextField *_addAddressTextField;
}

@end

@implementation XCAddressManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"地址管理";
    
    [self initData];
    
    [self initSegmentControl];
    
    [self initAddAddressView];
    
    [self initTableView];
    
    [self obtainAddressDataWithAddressType:MyAddressType_recieve];
    
    
    
    
}


-(void)obtainAddressDataWithAddressType:(MyAddressType )type
{
    [self initMBHudWithTitle:nil];
    
    NSString *addressType = @"take";
    if (type == MyAddressType_recieve)
    {
        addressType = @"take";
    }
    else
    {
        addressType = @"send";

    }
    
    
    
    [XCDataManage obtainAddressWithBlock:^(NSMutableArray *addressArray, NSString *retcode, NSString *retMessage, NSError *error) {
        if ([retcode isEqualToString:HTTP_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:nil finsh:nil];
            
            [_dataArray addObjectsFromArray:addressArray];
            
            [_addressTableView reloadData];
            
            
        }
        else
        {
            [self stopMBHudAndNSTimerWithmsg:retMessage finsh:nil];
        }
        
        
        
        
    } addressType:addressType];
    
    
}

-(void)initTableView
{
    _addressTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,_addAddressView.frame.origin.y+_addAddressView.frame.size.height,kMainScreenWidth ,kScreenHeightNoStatusAndNoNaviBarHeight) style:UITableViewStyleGrouped];
    _addressTableView.delegate=self;
    _addressTableView.dataSource=self;
    _addressTableView.showsVerticalScrollIndicator = NO;
    _addressTableView.backgroundColor = [UIColor clearColor];
    _addressTableView.backgroundView = nil;
    [self.view addSubview:_addressTableView];
}

-(void)initData
{
    _segmentArray = [NSArray arrayWithObjects:@"取件地址",@"送件地址", nil];
    
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    
    _addressType = MyAddressType_recieve;
    
#ifdef XC_TEST
    
    XCAddressModel *model1 = [[XCAddressModel alloc]init];
    model1.ua_id = @"01";
    model1.ua_address = @"软件大道华为南京研究院";
    model1.ua_isdefault = @"0";
    model1.ua_type = @"take";
    [_dataArray addObject:model1];
    
    XCAddressModel *model2 = [[XCAddressModel alloc]init];
    model2.ua_id = @"02";
    model2.ua_address = @"江宁九龙湖国际企业总部";
    model2.ua_isdefault = @"0";
    model2.ua_type = @"take";
    [_dataArray addObject:model2];
 
    
    
#endif
    
}


-(void)initSegmentControl
{
    _segmentBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 45)];
    _segmentBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_segmentBackView];
    
    
    UISegmentedControl * segmentControl = [[UISegmentedControl alloc]initWithItems:_segmentArray];
    segmentControl.tintColor = UIColorFromRGB(0x1190d9);
    segmentControl.frame = CGRectMake(0, 0, 300, 56/2);
    segmentControl.center = _segmentBackView.center;
    segmentControl.selectedSegmentIndex = 0;
    [segmentControl addTarget:self action:@selector(segmentValueChange:) forControlEvents:UIControlEventValueChanged];
    [_segmentBackView addSubview:segmentControl];
    
    
}

-(void)segmentValueChange:(UISegmentedControl *)paramSender
{
    NSInteger segmentSelectedIndex = paramSender.selectedSegmentIndex;
    
    [_dataArray removeAllObjects];
    
    
    
    switch (segmentSelectedIndex) {
        case 0:
        {
            _addressType = MyAddressType_recieve;

            
        }
            break;
        case 1:
        {
            _addressType = MyAddressType_send;

        }
            break;
            
        default:
            break;
    }
    
    [self obtainAddressDataWithAddressType:_addressType];
    
    
    
}


-(void)initAddAddressView
{
    _addAddressView = [[UIView alloc]initWithFrame:CGRectMake(0, _segmentBackView.frame.origin.y+_segmentBackView.frame.size.height+10, kMainScreenWidth, 45)];
    
    _addAddressView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_addAddressView];
    
    
    _addAddressTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 17/2, 456/2, 56/2)];
    [_addAddressTextField setBorderStyle:UITextBorderStyleRoundedRect];
    
    _addAddressTextField.placeholder = @"新增地址";
    _addAddressTextField.returnKeyType = UIReturnKeyDone;
    _addAddressTextField.clearButtonMode = UITextFieldViewModeAlways;
    _addAddressTextField.delegate = self;
    _addAddressTextField.font = HEL_14;
    [_addAddressView addSubview:_addAddressTextField];
    
    UIButton *addAddressBtn = [[UIButton alloc]initWithFrame:CGRectMake(_addAddressTextField.frame.origin.x +_addAddressTextField.frame.size.width+16, _addAddressTextField.frame.origin.y, 80/2, 56/2)];
    [addAddressBtn setTitle:@"新增" forState:UIControlStateNormal];
    [addAddressBtn setTitleColor:UIColorFromRGB(0x76acfd) forState:UIControlStateNormal];
    [addAddressBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [addAddressBtn addTarget:self action:@selector(addNewAddress) forControlEvents:UIControlEventTouchUpInside];
    addAddressBtn.backgroundColor = [UIColor clearColor];
    [_addAddressView addSubview:addAddressBtn];
   
}


-(void)clickLeftNavMenu
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



-(void)addNewAddress
{
    if ([NSString isBlankString:_addAddressTextField.text])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入有效地址" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    [self initMBHudWithTitle:nil];
    
    NSString *addressType = @"take";
    if (_addressType == MyAddressType_recieve)
    {
        addressType = @"take";
    }
    else
    {
        addressType = @"send";
        
    }

    
    [XCDataManage addNewAddressWithBlock:^(NSMutableArray *addressArray, NSString *retcode, NSString *retMessage, NSError *error) {
        
        if ([retcode isEqualToString:HTTP_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:nil finsh:nil];
            
            [_dataArray addObjectsFromArray:addressArray];
            
            [_addressTableView reloadData];
            
            
        }
        else
        {
            [self stopMBHudAndNSTimerWithmsg:retMessage finsh:nil];
        }
    
    } addressType:addressType address:_addAddressTextField.text];
    

    
    
}

#pragma mark - UITableViewDelegate -

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
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
    
}

#pragma mark - UITableViewDataSource -



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"myAddressCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if ([_dataArray count]>0)
    {
        
        XCAddressModel *model = [_dataArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = model.ua_address;
        cell.textLabel.font = HEL_14;
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.textColor = UIColorFromRGB(0x666666);
        
    }
    
//    cell.backgroundColor = [UIColor clearColor];
    
    
    return cell;
    
    
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;
    if ([tableView isEqual:_addressTableView])
    {
        result = UITableViewCellEditingStyleDelete;
    }
    return result;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [_addressTableView setEditing:editing animated:animated];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        if (indexPath.row < [_dataArray count])
        {
            
            
            [_dataArray removeObjectAtIndex:indexPath.row];
            
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
        }
    }
}

//修改删除按钮的文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
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
