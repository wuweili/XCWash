//
//  XCOrderDetailViewController.m
//  XCWash
//
//  Created by wuweiqing on 15/5/30.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCOrderDetailViewController.h"
#import "XCOrderModel.h"
#import "XCOrderDetailTableViewCell.h"

@interface XCOrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
    NSString *_orderId;
    
    XCOrderDetailModel *_detailOrderModel;
    
}

@end



@implementation XCOrderDetailViewController

-(id)initWithOrderId:(NSString *)orderId
{
    self = [super init];
    
    if ( self)
    {
        _orderId = orderId;
    }
    
    return self;
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"订单详情";
    
    _detailOrderModel = [[XCOrderDetailModel alloc]init];
    
    [self initTableView];
    
    [self obtainOrderDetail];

}

-(void)initTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,kMainScreenWidth ,kScreenHeightNoStatusAndNoNaviBarHeight) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(void)obtainOrderDetail
{
    [self initMBHudWithTitle:nil];
    
    if ([NSString isBlankString:_orderId])
    {
        return;
    }
    
    [XCDataManage obtainOrderDetailithBlock:^(XCOrderDetailModel *detailModel, NSString *retcode, NSString *retMessage, NSError *error) {
        
        if ([retcode isEqualToString:HTTP_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:nil finsh:nil];
            _detailOrderModel = detailModel;
            
            [_tableView reloadData];
            
        }
        else
        {
            [self stopMBHudAndNSTimerWithmsg:retMessage finsh:nil];
        }
        
        
    } orderId:_orderId];
    
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
    return 10+26+15+7*20+85*[_detailOrderModel.attrList count]+20+10;
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark - UITableViewDataSource -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"detailOrderCell";
    
    XCOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    if (cell == nil)
    {
        cell = [[XCOrderDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier orderDetailModel:_detailOrderModel];
    }
    
    [cell setCellContentWithOrderDetailModel:_detailOrderModel];
    
    
    cell.backgroundColor = [UIColor clearColor];
    
    
    
    return cell;
    
    
}


-(void)clickLeftNavMenu
{
    [self.navigationController popViewControllerAnimated:YES];
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
