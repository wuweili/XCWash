//
//  XCMyScoreViewController.m
//  XCWash
//
//  Created by 吴伟庆 on 15/3/17.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCMyScoreViewController.h"
#import "XCScoreTableViewCell.h"

@interface XCMyScoreViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *_segmentBackView;
    
    UITableView *_myScoreTableView;
    
    NSArray *_segmentArray;
    
    NSMutableArray *_dataArray;
    
    UILabel *_headViewLabel;
    
    NSString *_totalScoreStr;
    
}

@end

@implementation XCMyScoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的积分";
    
    [self initData];
    
    [self initSegmentControl];
    
    [self initTableView];
    
    
}

-(void)initData
{
    _segmentArray = [NSArray arrayWithObjects:@"累计记录",@"使用记录", nil];
    
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    
    _totalScoreStr = [XCUserModel shareInstance].u_integral;

    
#ifdef XC_TEST
    _totalScoreStr = @"437";
    
    XCScoreRecordModel *model1 = [[XCScoreRecordModel alloc]init];
    model1.scoreRecordContent = @"成功洗衣";
    model1.scoreRecordTime = @"2015-03-26 00:49";
    model1.scoreRecordScore = @"100";
    [_dataArray addObject:model1];
    
    XCScoreRecordModel *model2 = [[XCScoreRecordModel alloc]init];
    model2.scoreRecordContent = @"成功洗衣";
    model2.scoreRecordTime = @"2014-03-26 00:49";
    model2.scoreRecordScore = @"337";
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

-(void)initTableView
{
    _myScoreTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,_segmentBackView.frame.origin.y+_segmentBackView.frame.size.height,kMainScreenWidth ,kScreenHeightNoStatusAndNoNaviBarHeight) style:UITableViewStyleGrouped];
    _myScoreTableView.delegate=self;
    _myScoreTableView.dataSource=self;
    _myScoreTableView.showsVerticalScrollIndicator = NO;
    _myScoreTableView.backgroundColor = [UIColor clearColor];
    _myScoreTableView.backgroundView = nil;
//    _myScoreTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myScoreTableView];
}

-(void)clickLeftNavMenu
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)segmentValueChange:(UISegmentedControl *)paramSender
{
    NSInteger segmentSelectedIndex = paramSender.selectedSegmentIndex;
    
    
    
}

#pragma mark - UITableViewDelegate -

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 49;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!_headViewLabel)
    {
        
        
        _headViewLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 49)];

    }
    
    _headViewLabel.textAlignment = NSTextAlignmentCenter;
    
    NSString *amountStr = [NSString stringWithFormat:@"%@",_totalScoreStr];
    NSString *unitStr = @"积分";

    NSMutableAttributedString *newStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 积分",_totalScoreStr]];
    
    NSRange orangeRange = NSMakeRange(0, amountStr.length);
    NSRange grayRange = NSMakeRange(amountStr.length + 1, unitStr.length);
    
    [newStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xffad38) range:orangeRange];
    [newStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x999999) range:grayRange];
    [newStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:36] range:orangeRange];
    [newStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:grayRange];
    _headViewLabel.attributedText = newStr;
    [_headViewLabel adjustsFontSizeToFitWidth];

    return _headViewLabel;
    
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"myScoreCell";
    
    XCScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    if (cell == nil)
    {
        cell = [[XCScoreTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    
    if ([_dataArray count]>0)
    {
        XCScoreRecordModel *model = [_dataArray objectAtIndex:indexPath.row];
        
        [cell setCellContentWithScoreRecordModel:model];
        
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
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
