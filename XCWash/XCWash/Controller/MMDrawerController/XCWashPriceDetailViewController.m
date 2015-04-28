//
//  XCWashPriceDetailViewController.m
//  XCWash
//
//  Created by wuweiqing on 15/4/5.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCWashPriceDetailViewController.h"
#import "XCWashPriceTableViewCell.h"
#import "XCMakeApplyOrderViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "XCMakeYuYinOrderViewController.h"
#import "XCGoodsTypeModel.h"

@interface XCWashPriceDetailViewController ()<UITableViewDataSource,UITableViewDelegate,SVTopScrollViewDelegate,SVRootScrollViewDelegate,AVAudioRecorderDelegate>
{
    UIView *_segmentBackView;
    
    UITableView *_washPriceTableView;
    
    NSMutableArray *_goodTypeArray;
    
    NSMutableArray *_segmentArray;
    
    NSMutableArray *_dataArray;
    
    UIToolbar *_toolbar;
    
    UIButton *_addYuyinWashButton;
    UIButton *_applyWashButton;
    SVTopScrollView *_topScrollView;
    SVRootScrollView *_rootScrollView;
    
    NSTimer *_recordTimer;
    
    UIImageView *_recordBigBackGroundImageView;
    
    UIImageView *_recordImageView;
    
    AVAudioRecorder *_recorder;
    
    NSString *_recordFileUrlStr;
    
    
    BOOL hadFirstAddRecordView;

    
    
}

@end

@implementation XCWashPriceDetailViewController

-(id)initWithWsahPriceType:(WashPriceType)type
{
    self = [super init];
    
    if (self)
    {
        self.washPriceType = type;
    }
    
    
    return self;
}

-(void)dealloc
{
    [_segmentArray removeAllObjects];
    [_dataArray removeAllObjects];
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUIAndSegmentArray];
    
    [self setToorbar];
    
    [self initData];

    
//    [self initTopViewAndScrollView];
    
    [self obtainGoodsTypeAndGoodsList];
    
    
//    [self initTableView];
    
}

-(void)clickLeftNavMenu
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initUIAndSegmentArray
{

    switch (self.washPriceType)
    {
        case WashPriceType_yiwu:
        {
            self.title = @"衣物";
#ifdef XC_TEST

            _segmentArray = [NSMutableArray arrayWithObjects:@"上装",@"裤装",@"群装配饰", nil];
#endif
            
        }
            break;
        case WashPriceType_xiewa:
        {
            self.title = @"鞋袜";
#ifdef XC_TEST

            _segmentArray = [NSMutableArray arrayWithObjects:@"非光面普洗",@"非光面精洗",@"非光面高精洗",@"光面普洗",@"光面精洗",@"光面高精洗",@"维修换色",nil];
#endif
            
        }
            break;
        case WashPriceType_shechipin:
        {
            self.title = @"奢侈品";
#ifdef XC_TEST

            _segmentArray = [NSMutableArray arrayWithObjects:@"皮具", nil];
#endif
        }
            break;
        case WashPriceType_jujia:
        {
            self.title = @"居家";
#ifdef XC_TEST

            _segmentArray = [NSMutableArray arrayWithObjects:@"床上用品",@"居家用品", nil];
#endif

            
        }
            break;
        case WashPriceType_pibao:
        {
            self.title = @"皮包";
#ifdef XC_TEST

            _segmentArray = [NSMutableArray arrayWithObjects:@"普通包", nil];
#endif
            
        }
            break;
            
        default:
            break;
    }
    
    [self initRecordView];

    
    
    
}

-(void)initRecordView
{
    UIWindow *shareWindow = [UIApplication sharedApplication].keyWindow;
    
    _recordBigBackGroundImageView = [[UIImageView alloc ]initWithFrame:CGRectMake(shareWindow.frame.origin.x, shareWindow.frame.origin.y, shareWindow.frame.size.width, shareWindow.frame.size.height - 130/2)];
    _recordBigBackGroundImageView.backgroundColor = [UIColor blackColor];
    _recordBigBackGroundImageView.alpha = 0.35;
    
    _recordImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kMainScreenWidth- 175)/2, 66, 175, 175)];
    //    XC_XCYuyin_first_image
    _recordImageView.image = XC_XCYuyin_first_image;
    _recordImageView.layer.cornerRadius = 4;
    [_recordBigBackGroundImageView addSubview:_recordImageView];
    
    
}


-(void)showRecordView
{
    UIWindow *shareWindow = [UIApplication sharedApplication].keyWindow;
    
    [UIView animateWithDuration:1 animations:^{
        _recordBigBackGroundImageView.alpha = 0.6;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    [shareWindow addSubview:_recordBigBackGroundImageView];
}


-(void)initData
{
    
    hadFirstAddRecordView = NO;

    _dataArray = [NSMutableArray arrayWithCapacity:0];
    
    _goodTypeArray = [NSMutableArray arrayWithCapacity:0];
    
    _segmentArray = [NSMutableArray arrayWithCapacity:0];
    
#ifdef XC_TEST

    XCWashPriceModel *model1 = [[XCWashPriceModel alloc]init];
    model1.name = @"衬衫";
    model1.price = @"10";
    model1.otherDesc = @"洗衣+熨烫+免费取送";
    [_dataArray addObject:model1];
    
    XCWashPriceModel *model2 = [[XCWashPriceModel alloc]init];
    model2.name = @"衬衫";
    model2.price = @"10";
    model2.otherDesc = @"洗衣+熨烫+免费取送";
    [_dataArray addObject:model2];

    
    XCWashPriceModel *model3 = [[XCWashPriceModel alloc]init];
    model3.name = @"衬衫";
    model3.price = @"10";
    model3.otherDesc = @"洗衣+熨烫+免费取送";
    [_dataArray addObject:model3];

    
    XCWashPriceModel *model4 = [[XCWashPriceModel alloc]init];
    model4.name = @"衬衫";
    model4.price = @"10";
    model4.otherDesc = @"洗衣+熨烫+免费取送";
    [_dataArray addObject:model4];

    
    XCWashPriceModel *model5= [[XCWashPriceModel alloc]init];
    model5.name = @"衬衫";
    model5.price = @"10";
    model5.otherDesc = @"洗衣+熨烫+免费取送";
    [_dataArray addObject:model5];

    
    XCWashPriceModel *model6 = [[XCWashPriceModel alloc]init];
    model6.name = @"衬衫";
    model6.price = @"10";
    model6.otherDesc = @"洗衣+熨烫+免费取送";
    [_dataArray addObject:model6];

    
    XCWashPriceModel *model7 = [[XCWashPriceModel alloc]init];
    model7.name = @"衬衫";
    model7.price = @"10";
    model7.otherDesc = @"洗衣+熨烫+免费取送";
    [_dataArray addObject:model7];
   
#endif

}


-(void)setToorbar
{
    _toolbar = [[UIToolbar alloc] initWithFrame:[self frameForToolbarAtOrientation:self.interfaceOrientation]];
    _toolbar.tintColor = CurrentSystemVersion>=7.0? [UIColor whiteColor] : nil;
    
    _toolbar.barStyle = UIBarStyleDefault;
    _toolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_toolbar];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    line.backgroundColor = UIColorFromRGB(0xcccccc);
    [_toolbar addSubview:line];
    
    
    
    _addYuyinWashButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 370/2, 90/2)];
    _addYuyinWashButton.backgroundColor = [UIColor clearColor];
    _addYuyinWashButton.layer.cornerRadius = 4;
    [_addYuyinWashButton setBackgroundImage:XCAdd_yuyin_wash_image forState:UIControlStateNormal];
    [_addYuyinWashButton addTarget:self action:@selector(clickAddYuyinWashButtonDown:) forControlEvents:UIControlEventTouchDown];
    
    [_addYuyinWashButton addTarget:self action:@selector(clickAddYuyinWashButtonUp:) forControlEvents:UIControlEventTouchUpInside];
    
    [_addYuyinWashButton addTarget:self action:@selector(btnDragUp:) forControlEvents:UIControlEventTouchDragExit];
    
    [_addYuyinWashButton addTarget:self action:@selector(btnDragUp:) forControlEvents:UIControlEventTouchCancel];

    
    
    UIBarButtonItem *addYuYinButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_addYuyinWashButton];
    
    _applyWashButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 90/2)];
    _applyWashButton.backgroundColor = [UIColor clearColor];
    _applyWashButton.layer.cornerRadius = 4;
    [_applyWashButton setTitle:@"预约" forState:UIControlStateNormal];
    [_applyWashButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_applyWashButton setBackgroundImage:XC_apply_wash_image forState:UIControlStateNormal];
    [_applyWashButton addTarget:self action:@selector(clickApplyWashButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *applyWashButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_applyWashButton];
    
    
    UIBarButtonItem *fixedLeftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    fixedLeftSpace.width = 14; // To balance action button
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    [items addObject:flexSpace];
    [items addObject:addYuYinButtonItem];
    [items addObject:flexSpace];
    
    [items addObject:fixedLeftSpace];
    
    [items addObject:flexSpace];
    
    [items addObject:applyWashButtonItem];
    [items addObject:flexSpace];
    
    [_toolbar setItems:items];

}



- (CGRect)frameForToolbarAtOrientation:(UIInterfaceOrientation)orientation {
    CGFloat height = 130/2;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone &&
        UIInterfaceOrientationIsLandscape(orientation)) height = 32;
    return CGRectIntegral(CGRectMake(0, self.view.bounds.size.height - height, self.view.bounds.size.width, height));
}


-(void)initTopViewAndScrollView
{
    _topScrollView = [[SVTopScrollView alloc] initWithFrame:CGRectMake(0,0, kMainScreenWidth, 44)];

    _rootScrollView= [[SVRootScrollView alloc]initWithFrame:CGRectMake(0, 44, kMainScreenWidth,kScreenHeightNoStatusAndNoNaviBarHeight-130/2-44 ) ];
    _topScrollView.topViewdelegate = self;
    _rootScrollView.rootScrollViewGelegate = self;
    
    _topScrollView.nameArray = [NSArray arrayWithArray:_segmentArray];
    _rootScrollView.viewNameArray = [NSArray arrayWithArray:_segmentArray];;
    [self.view addSubview:_topScrollView];
    
    [self.view addSubview:_rootScrollView];
    
    
    [_topScrollView initWithNameButtons];
    
    _topScrollView.backgroundColor = [UIColor whiteColor];
    
    for (NSInteger i=0; i<[_segmentArray count]; i++)
    {
       UITableView *washPriceTableView=[[UITableView alloc]initWithFrame:CGRectMake(kMainScreenWidth*i,0,kMainScreenWidth ,kScreenHeightNoStatusAndNoNaviBarHeight-130/2-_topScrollView.frame.size.height) style:UITableViewStyleGrouped];
        washPriceTableView.delegate=self;
        washPriceTableView.dataSource=self;
        washPriceTableView.tag = 10000+i;
        washPriceTableView.showsVerticalScrollIndicator = NO;
        washPriceTableView.backgroundColor =UIColorFromRGB(0xe6e6e6);
        washPriceTableView.backgroundView = nil;
        washPriceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_rootScrollView addSubview:washPriceTableView];
    }
    
    
    
    [_rootScrollView initWithViews];
}

-(void)initTableView
{
    _washPriceTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,_segmentBackView.frame.origin.y+_segmentBackView.frame.size.height,kMainScreenWidth ,kScreenHeightNoStatusAndNoNaviBarHeight-130/2) style:UITableViewStyleGrouped];
    _washPriceTableView.delegate=self;
    _washPriceTableView.dataSource=self;
    _washPriceTableView.showsVerticalScrollIndicator = NO;
    _washPriceTableView.backgroundColor =UIColorFromRGB(0xe6e6e6);
    _washPriceTableView.backgroundView = nil;
    _washPriceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_washPriceTableView];
}



-(void)obtainGoodsTypeAndGoodsList
{
    [self initMBHudWithTitle:nil];
    
    [XCDataManage obtainGoodsTypeWithBlock:^(NSMutableArray *messageArray, NSString *retcode, NSString *retMessage, NSError *error) {
        if ([retcode isEqualToString:HTTP_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:nil finsh:nil];
            
            _goodTypeArray = messageArray;
            
            
            if ([_goodTypeArray count]>0)
            {
                [self dealGoodsTypeArray];
                
                [self initTopViewAndScrollView];
                
                [self obtainGoodsListWithClickTypeIndex:0];


            }
            

            
        }
        else
        {
            
            [self stopMBHudAndNSTimerWithmsg:retMessage finsh:nil];

        }

    } parentId:[NSString stringWithFormat:@"%d",self.washPriceType+1]];
    
    
}

-(void)dealGoodsTypeArray
{
    for (XCGoodsTypeModel *goodsTypeModel in _goodTypeArray)
    {
        [_segmentArray addObject:goodsTypeModel.gt_name];
    }

}

-(void)obtainGoodsListWithClickTypeIndex:(NSInteger )index
{
    [self initMBHudWithTitle:nil];
    
    if (index >[_goodTypeArray count])
    {
        return;
    }
    
    
    XCGoodsTypeModel *model = [_goodTypeArray objectAtIndex:index];

    [XCDataManage obtainGoodsListWithBlock:^(NSMutableArray *messageArray, NSString *retcode, NSString *retMessage, NSError *error) {
        
        if ([retcode isEqualToString:HTTP_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:nil finsh:nil];
            
            _dataArray = messageArray;
            
            [self loadDataWithTag:index];
            
            
        }
        else
        {
            [self stopMBHudAndNSTimerWithmsg:retMessage finsh:nil];
        }
        
        
    } goodsTypeId:model.gt_id];
    
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
    return 182/2;
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
    
    XCWashPriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    if (cell == nil)
    {
        cell = [[XCWashPriceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    
    if ([_dataArray count]>0)
    {
        XCGoodsModel *model = [_dataArray objectAtIndex:indexPath.row];
        
        [cell setCellContentWithWashPriceModel:model];
        
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}


-(void)clickAddYuyinWashButtonDown:(id)sender
{
    hadFirstAddRecordView = NO;

    [self audio];
    
    //创建录音文件，准备录音
    if ([_recorder prepareToRecord])
    {
        //开始
        [_recorder record];
    }
    
    //设置定时检测
    
    _recordTimer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];
}

-(void)clickAddYuyinWashButtonUp:(id)sender
{
    hadFirstAddRecordView = NO;
    
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //录音时关闭麦克风
    NSError *sessionError = nil;
    [audioSession setCategory:AVAudioSessionCategoryRecord error:&sessionError];
    [audioSession setActive:YES error:nil];
    // [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    if(audioSession == nil)//解决屏幕顶部红色泛影
        DDLogInfo(@"Error creating session: %@", [sessionError description]);
    else
        [audioSession setActive:YES error:nil];
    
    double cTime = _recorder.currentTime;
    if (cTime > 0.5)
    {
        //如果录制时间<2 不发送  跳转
        
        XCMakeYuYinOrderViewController *makeYuyinMVC = [[XCMakeYuYinOrderViewController alloc]init];
        [self.navigationController pushViewController:makeYuyinMVC animated:YES];
        
        [_recordBigBackGroundImageView removeFromSuperview];
        
        
        
        
        
    }
    else
    {
        //删除记录的文件
        [_recorder deleteRecording];
        //删除存储的
        [self displaySomeInfoWithInfo:@"录音时间太短" finsh:nil];
    }
    
    [_recorder stop];
    [_recordTimer invalidate];
    _recordTimer = nil;
    
    
    
}

-(void)btnDragUp:(id)sender

{
    //删除录制文件
    [_recorder deleteRecording];
    [_recorder stop];
    [_recordTimer invalidate];
    _recordTimer = nil;
    [_recordBigBackGroundImageView removeFromSuperview];

    
    DDLogInfo(@"取消发送");
    
}


- (void)audio
{
    //录音设置
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    
    NSString *strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    _recordFileUrlStr = [NSString stringWithFormat:@"%@/makeOrder%@.aac", strUrl,[XCUserModel shareInstance].userId];
    
    NSURL *url = [NSURL fileURLWithPath:_recordFileUrlStr];
    
    
    
    //    BOOL isExit;
    //    NSString *fileUrlStr = [DocumentUtil getRecordFileByRecordFileId:[XCUserModel shareInstance].userId isExist:&isExit];
    //
    //
    //    _recordFileUrlStr = fileUrlStr;
    //
    //    NSURL *url = [NSURL fileURLWithPath:_recordFileUrlStr];
    
    NSError *error;
    //初始化
    _recorder = [[AVAudioRecorder alloc]initWithURL:url settings:recordSetting error:&error];
    //开启音量检测
    _recorder.meteringEnabled = YES;
    _recorder.delegate = self;
}

- (void)detectionVoice
{
    
    double cTime = _recorder.currentTime;
    
    if (cTime > 0.5 && hadFirstAddRecordView == NO)
    {
        hadFirstAddRecordView = YES;
        [self showRecordView];
        
    }
    
    
    
    [_recorder updateMeters];//刷新音量数据
    //获取音量的平均值  [recorder averagePowerForChannel:0];
    //音量的最大值  [recorder peakPowerForChannel:0];
    
    double lowPassResults = pow(10, (0.05 * [_recorder peakPowerForChannel:0]));
    //最大50  0
    //图片 小-》大
    if (0<lowPassResults<=0.06) {
        [_recordImageView setImage:XC_XCYuyin_first_image];
    }else if (0.06<lowPassResults<=0.13) {
        [_recordImageView setImage:XC_XCYuyin_first_image];
    }else if (0.13<lowPassResults<=0.20) {
        [_recordImageView setImage:XC_XCYuyin_first_image];
    }else if (0.20<lowPassResults<=0.27) {
        [_recordImageView setImage:XC_XCYuyin_second_image];
    }else if (0.27<lowPassResults<=0.34) {
        [_recordImageView setImage:XC_XCYuyin_second_image];
    }else if (0.34<lowPassResults<=0.41) {
        [_recordImageView setImage:XC_XCYuyin_second_image];
    }else if (0.41<lowPassResults<=0.48) {
        [_recordImageView setImage:XC_XCYuyin_third_image];
    }else if (0.48<lowPassResults<=0.55) {
        [_recordImageView setImage:XC_XCYuyin_third_image];
    }else if (0.55<lowPassResults<=0.62) {
        [_recordImageView setImage:XC_XCYuyin_third_image];
    }else if (0.62<lowPassResults<=0.69) {
        [_recordImageView setImage:XC_XCYuyin_forth_image];
    }else if (0.69<lowPassResults<=0.76) {
        [_recordImageView setImage:XC_XCYuyin_forth_image];
    }else if (0.76<lowPassResults<=0.83) {
        [_recordImageView setImage:XC_XCYuyin_five_image];
    }else if (0.83<lowPassResults<=0.9) {
        [_recordImageView setImage:XC_XCYuyin_five_image];
    }else {
        [_recordImageView setImage:XC_XCYuyin_five_image];
    }
}


-(void)clickApplyWashButton
{
    XCMakeApplyOrderViewController *makeOrderMVC = [[XCMakeApplyOrderViewController alloc]init];
    [self.navigationController pushViewController:makeOrderMVC animated:YES];
}

# pragma mark SVTopScrollViewDelegate -

-(void)clickTopButtonWithButtonTag:(NSInteger)tag
{
    NSInteger clickIndex = tag - 100;
    
    if (clickIndex > [_goodTypeArray count])
    {
        return;
    }
    
    [_dataArray removeAllObjects];
    
    [self obtainGoodsListWithClickTypeIndex:clickIndex];

    
    
    [_rootScrollView setContentOffset:CGPointMake((tag-100)*320, 0) animated:YES];
    
    
    
}

#pragma mark - SVRootScrollViewDelegate - 

-(void)adjustTopScrollViewButtonWithScrollViewSelectedChannelID:(NSInteger)tag
{
    [_dataArray removeAllObjects];

    [_topScrollView setButtonUnSelect];
    _topScrollView.scrollViewSelectedChannelID = tag;
    [_topScrollView setButtonSelect];
    [_topScrollView setScrollViewContentOffset];
    
    NSInteger clickIndex = tag - 100;
    if (clickIndex > [_goodTypeArray count])
    {
        return;
    }

    
    [self obtainGoodsListWithClickTypeIndex:clickIndex];


}

-(void)loadDataWithTag:(NSInteger)tag
{
    UITableView *tableView = (UITableView *)[_rootScrollView viewWithTag:tag+10000];
    [tableView reloadData];
    
    
    //刷新数据 接口

}



- (void)didReceiveMemoryWarning
{
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
