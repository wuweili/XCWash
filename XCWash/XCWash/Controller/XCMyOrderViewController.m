//
//  XCMyOrderViewController.m
//  XCWash
//
//  Created by 吴伟庆 on 15/3/17.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCMyOrderViewController.h"
#import "XCMyOrderTableViewCell.h"
#import "XCDataManage.h"
#import "HXAlertView.h"
#import "DocumentUtil.h"
#import "XCOrderDetailViewController.h"


@interface XCMyOrderViewController ()<UITableViewDataSource,UITableViewDelegate,XCMyOrderTableViewCellDelegate,UIAlertViewDelegate,AVAudioPlayerDelegate>
{
    UIView *_segmentBackView;
    
    UITableView *_myOrderTableView;
    
    NSArray *_segmentArray;
    
    NSMutableArray *_dataArray;
    
    MyOrderCellType _orderType;
    
    XCOrderModel *_clickOrderModel;
    
    UIButton *_clickListenButton;
    
}

@end

@implementation XCMyOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.title = @"我的订单";
    
    [self initData];
    
    [self initSegmentControl];
    
    [self initTableView];
    
    [self obtainOrderList];
    
}

-(void)initData
{
    _segmentArray = [NSArray arrayWithObjects:@"预约中",@"已送洗",@"完成", nil];
    
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    
    _orderType = MyOrderCellType_YuYueZhong;

    
    
//    XCOrderModel *model = [[XCOrderModel alloc]init];
//    model.orderNumber = @"2015876543";
//    model.orderTime = @"2015-03-22 20:23";
//    model.takeAddress = @"南京市雨花台区铁心桥南岸尚城";
//    model.sendAddress =@"南京市雨花台区铁心桥南岸尚城";
//    [_dataArray addObject:model];
//    
//    XCOrderModel *model1 = [[XCOrderModel alloc]init];
//    model1.orderNumber = @"2015765432";
//    model1.orderTime = @"2015-03-22 20:23";
//    model1.takeAddress = @"南京市雨花台区软件大道180号";
//    model1.sendAddress =@"南京市雨花台区软件大道180号";
//    [_dataArray addObject:model1];
//    
//    _orderType = MyOrderCellType_YuYueZhong;
    
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


-(void)initTableView
{
    _myOrderTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,_segmentBackView.frame.origin.y+_segmentBackView.frame.size.height,kMainScreenWidth ,kScreenHeightNoStatusAndNoNaviBarHeight-45) style:UITableViewStyleGrouped];
    _myOrderTableView.delegate=self;
    _myOrderTableView.dataSource=self;
    _myOrderTableView.showsVerticalScrollIndicator = NO;
    _myOrderTableView.backgroundColor = [UIColor clearColor];
    _myOrderTableView.backgroundView = nil;
    _myOrderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myOrderTableView];
}


-(void)obtainOrderList
{
    [self initMBHudWithTitle:nil];
    

    [_dataArray removeAllObjects];
    
    NSString *orderType = @"current";
    if (_orderType == MyOrderCellType_YuYueZhong)
    {
        orderType = @"current";

    }
    else if (_orderType == MyOrderCellType_YiSongXi)
    {
        orderType = @"sended";

    }
    else
    {
        orderType = @"finished";

    }
    
    [XCDataManage obtainMyOrderListWithBlock:^(NSMutableArray *messageArray, NSString *retcode, NSString *retMessage, NSError *error) {
        
        if ([retcode isEqualToString:HTTP_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:nil finsh:nil];
            
            [_dataArray addObjectsFromArray:messageArray];
            
            [_myOrderTableView reloadData];

            
        }
        else
        {
            [self stopMBHudAndNSTimerWithmsg:retMessage finsh:nil];
            
            [_myOrderTableView reloadData];

        }
        
        
    } orderType:orderType];
    
    
}

-(void)segmentValueChange:(UISegmentedControl *)paramSender
{
    NSInteger segmentSelectedIndex = paramSender.selectedSegmentIndex;
    switch (segmentSelectedIndex)
    {
        case 0:
        {
            _orderType = MyOrderCellType_YuYueZhong;
        }
            break;
        case 1:
        {
            _orderType = MyOrderCellType_YiSongXi;
        }
            break;
        case 2:
        {
            _orderType = MyOrderCellType_Finsh;
        }
            break;
            
        default:
            break;
    }
    
    [self obtainOrderList];
    
    
    
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    

    
    if (_dataArray && [_dataArray count]>0)
    {
        if (indexPath.section > [_dataArray count])
        {
            return;
        }
        
        
        XCOrderModel *model = [_dataArray objectAtIndex:indexPath.section];
        
        XCOrderDetailViewController *detailMVC = [[XCOrderDetailViewController alloc]initWithOrderId:model.orderId];
        [self.navigationController pushViewController:detailMVC animated:YES];
        
        
    }
    
    

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
    NSString *identifier = [NSString stringWithFormat:@"aboutCell%d",_orderType];
    
    XCMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    if (cell == nil)
    {
        cell = [[XCMyOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier cellType:_orderType];
    }
    
    
    
    if ([_dataArray count]>0)
    {
        XCOrderModel *model = [_dataArray objectAtIndex:indexPath.section];
        
        [cell setCellContentWithOrderModel:model cellType:_orderType];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.delegate = self;
    
    
    
    return cell;
    
    
}

#pragma mark - XCMyOrderTableViewCellDelegate - 

-(void)clickCancleOrderButtonWithOrderModel:(XCOrderModel *)model
{
    _clickOrderModel = model;
    
    
    HXAlertView *cancleAlert = [[HXAlertView alloc]initRemindInfoWithTitle:@"提醒" contentText:@"确定要取消该订单?"  leftBtnTitle:@"取消" rightBtnTitle:@"确定" haveCloseButton:NO];
    [cancleAlert show];
    
    
    __weak XCMyOrderViewController *weakSelf = self;
    __weak HXAlertView *weakAlert = cancleAlert;
    cancleAlert.leftBlock = ^()
    {
        [weakAlert removeFromSuperview];
    };
    
    cancleAlert.rightBlock = ^()
    {
        
        //取消订单
        [self initMBHudWithTitle:nil];
        
        [XCDataManage cancleOrderWithBlock:^(NSString *retcode, NSString *retMessage, NSError *error) {
            
            if ([retcode isEqualToString:HTTP_OK])
            {
                [self stopMBHudAndNSTimerWithmsg:@"取消订单成功" finsh:nil];
                
                [_dataArray removeObject:model];
                
                [_myOrderTableView reloadData];

                
                
            }
            else
            {
                [self stopMBHudAndNSTimerWithmsg:@"取消订单失败" finsh:nil];
            }
            
            
        } orderId:model.orderId cancleReason:@"取消订单"];
        
        
        [weakAlert removeFromSuperview];
        
    };
    

}

-(void)clickListenYuyinButtonWithOrderModel:(XCOrderModel *)model clickButton:(UIButton *)clickButton
{
    _clickListenButton.selected = NO;
    _clickOrderModel = model;
    
    _clickListenButton =clickButton;
    
    BOOL isExit;
    NSString *recordFileUrlStr = [DocumentUtil getRecordFileByRecordFileId:model.orderId isExist:&isExit];
    
    if (isExit)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        //默认情况下扬声器播放
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        [audioSession setActive:YES error:nil];
        
        if (self.avPlay.playing) {
            [self.avPlay stop];
            return;
        }
        
        _clickListenButton.selected = YES;

        AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:recordFileUrlStr] error:nil];
        self.avPlay = player;
        self.avPlay.delegate = self;
        [self.avPlay play];
    }
    else
    {
        [[XCDataManage shareSIPDataManager] downRecieveFileWithFileUrlStr:model.listenFileUrl fileId:model.orderId withBlock:^(NSString *retCode, NSString *retMessage, NSURL *filePath, NSError *error) {
            
            if (error)
            {
                
            }
            else
            {
                
                AVAudioSession *audioSession = [AVAudioSession sharedInstance];
                //默认情况下扬声器播放
                [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
                [audioSession setActive:YES error:nil];
                
                if (self.avPlay.playing)
                {
                    [self.avPlay stop];
                    return;
                }
                
                _clickListenButton.selected = YES;
                
                AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:filePath error:nil];
                self.avPlay = player;
                self.avPlay.delegate = self;
                [self.avPlay play];
            }
            
            
        }];

    }
  
}

#pragma mark - AVAudioPlayerDelegate -

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    DDLogInfo(@"播放完成");
    
    _clickListenButton.selected = NO;
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error;
{
    _clickListenButton.selected = NO;

}


-(void)clickAddCommentButtonWithOrderModel:(XCOrderModel *)model
{
    _clickOrderModel = model;
    
    HXAlertView *commentAlert = [[HXAlertView alloc]initEvaAlertView];
    [commentAlert show];
    
    
    __weak XCMyOrderViewController *weakSelf = self;
    __weak HXAlertView *weakAlert = commentAlert;

    commentAlert.inputTextAboveStandardBlock = ^(NSString *tipMsg)
    {
        [weakSelf basePopInputTextAboveStandardAlertWithTipMessage:tipMsg];
    };
    
    commentAlert.leftBlock = ^()
    {
        DDLogInfo(@"取消评价" );
        
        [weakAlert removeFromSuperview];

    };
    
    commentAlert.evaDoctorRightBlock = ^(NSInteger washEvaIntegerValue,NSInteger serviceEvaIntegerValue,NSString *evaMessage)
    {
        DDLogInfo(@"洗涤质量   %d   服务质量：%d    message = %@",washEvaIntegerValue,serviceEvaIntegerValue,evaMessage);
        [self initMBHudWithTitle:nil];
        
        [XCDataManage addCommentToOrderWithBlock:^(NSString *retcode, NSString *retMessage, NSError *error) {
            
            if ([retcode isEqualToString:HTTP_OK])
            {
                [self stopMBHudAndNSTimerWithmsg:@"评价成功" finsh:nil];
            }
            else
            {
                [self stopMBHudAndNSTimerWithmsg:@"评价失败" finsh:nil];
            }
            
            
        } uid:[XCUserModel shareInstance].userId oid:model.orderId ccontent:evaMessage cclevel:[NSString stringWithFormat:@"%d",serviceEvaIntegerValue] cwlevel:[NSString stringWithFormat:@"%d",washEvaIntegerValue]];
        
        
        
        [weakAlert removeFromSuperview];

    };
                                         

    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 500)
    {
        if (buttonIndex == alertView.cancelButtonIndex)
        {
            
        }
        else
        {
            //取消订单
            
            
            
            
        }
    }
}

#pragma mark - 弹出输入超过限制提示框
-(void)basePopInputTextAboveStandardAlertWithTipMessage:(NSString *)tipMessage
{
    HXAlertView *tipAlert = [[HXAlertView alloc]initRemindInfoWithTitle:@"提示" contentText:tipMessage leftBtnTitle:nil rightBtnTitle:@"知道了" haveCloseButton:NO];
    [tipAlert show];
    
    __weak HXAlertView *weakAlert = tipAlert;
    
    tipAlert.rightBlock = ^()
    {
        [weakAlert removeFromSuperview];
    };
    
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
