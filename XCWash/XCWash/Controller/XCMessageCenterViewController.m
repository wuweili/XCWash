//
//  XCMessageCenterViewController.m
//  XCWash
//
//  Created by 吴伟庆 on 15/3/17.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCMessageCenterViewController.h"
#import "XCMessageCenterTableViewCell.h"

@interface XCMessageCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArray;
    
    UITableView *_messageCenterTableView;
}

@end

@implementation XCMessageCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"消息中心";
    
    [self initData];
    
    [self initTableView];
    
    [self obtainMessageData];
}

-(void)initData
{
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    
//    XCMessageModel*model1 = [[XCMessageModel alloc]init];
//    model1.m_id = @"01";
//    model1.m_content = @"恭喜您注册成功，送您一张10元代金券，可以直接抵免起步价，限本周使用";
//    model1.lr_sj = @"2015-02-26 15:23:00";
//    
//    [_dataArray addObject:model1];
//    
//    XCMessageModel*model2 = [[XCMessageModel alloc]init];
//    model2.m_id = @"02";
//    model2.m_content = @"欢迎您使用本客户端";
//    model2.lr_sj = @"2015-03-26 15:23:00";
//    [_dataArray addObject:model2];
    
    
    
}


-(void)initTableView
{
    _messageCenterTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,kMainScreenWidth ,kScreenHeightNoStatusAndNoNaviBarHeight) style:UITableViewStyleGrouped];
    _messageCenterTableView.delegate=self;
    _messageCenterTableView.dataSource=self;
    _messageCenterTableView.showsVerticalScrollIndicator = NO;
    _messageCenterTableView.backgroundColor = [UIColor clearColor];
    _messageCenterTableView.backgroundView = nil;
    _messageCenterTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_messageCenterTableView];

}

-(void)obtainMessageData
{
    [self initMBHudWithTitle:nil];
    
    [XCDataManage obtainMessageWithBlock:^(NSMutableArray *messageArray, NSString *retcode, NSString *retMessage, NSError *error) {
        if ([retcode isEqualToString:HTTP_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:nil finsh:nil];
            
            [_dataArray addObjectsFromArray:messageArray];
            
            [_messageCenterTableView reloadData];
            
            
        }
        else
        {
            [self stopMBHudAndNSTimerWithmsg:retMessage finsh:nil];
        }
        
        
        
        
    }];
    
    
}


-(void)clickLeftNavMenu
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_dataArray count]>0)
    {
        XCMessageModel *model = [_dataArray objectAtIndex:indexPath.section];
        
        CGFloat height = [XCMessageCenterTableViewCell heightForCellWithMessageModel:model];
        
        return height;
        
    }
    else return 0;
}

#pragma mark - UITableViewDataSource -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"messageCell";
    
    XCMessageCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[XCMessageCenterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([_dataArray count]>0)
    {
        XCMessageModel *model = [_dataArray objectAtIndex:indexPath.section];
        
        [cell setCellContentWithMessageModel:model];
        
    }
    
    return cell;
    
    
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
