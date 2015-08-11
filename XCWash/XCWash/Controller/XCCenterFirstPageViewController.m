//
//  XCCenterFirstPageViewController.m
//  XCWash
//
//  Created by 吴伟庆 on 15/3/13.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCCenterFirstPageViewController.h"
#import "SDCycleScrollView.h"
#import "XCCenterFirstCollectionViewCell.h"
#import "XCCenterSecondCollectionViewCell.h"
#import "XCWashPriceDetailViewController.h"
#import "XCMakeApplyOrderViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "XCMakeYuYinOrderViewController.h"
#import "DocumentUtil.h"





@interface XCCenterFirstPageViewController ()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,AVAudioRecorderDelegate,CLLocationManagerDelegate>
{
    
    NSMutableArray *_imageUrlArray;
    
    SDCycleScrollView *_imageScrollView;
    
    UIToolbar *_toolbar;
    
    UIButton *_addYuyinWashButton;
    UIButton *_applyWashButton;
    
    
    UICollectionView *_collectionView;
    
    NSMutableArray *_section1Array;
    
    NSTimer *_recordTimer;
    
    UIImageView *_recordBigBackGroundImageView;
    
    UIImageView *_recordImageView;
    
    AVAudioRecorder *_recorder;
    
    NSString *_recordFileUrlStr;


    BOOL hadFirstAddRecordView;
    
    CLLocationManager *_locationManage;
    
    NSString *_locationAddress;


    
   
}



@end

@implementation XCCenterFirstPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUI];
    
    [self initData];
    
    [self initScrollImageView];
    
    [self initUICollectionView];
    
    [self startLocation];

    
    
    // Do any additional setup after loading the view.
}


-(void)startLocation
{
    _locationManage = [[CLLocationManager alloc] init];
    
    if (![CLLocationManager locationServicesEnabled])
    {
        DDLogInfo(@"定位服务当前可能尚未打开，请设置打开！");
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"定位服务当前可能尚未打开，请设置打开！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }

    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined)
    {
        if ([_locationManage respondsToSelector:@selector(requestWhenInUseAuthorization)])
        {
            [_locationManage requestWhenInUseAuthorization];
        }
        
        
        
        _locationManage.delegate = self;
        _locationManage.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManage.distanceFilter = 10.0f;
        [_locationManage startUpdatingLocation];
        
        
    }
    else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        _locationManage.delegate = self;
        _locationManage.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManage.distanceFilter = 10.0f;
        [_locationManage startUpdatingLocation];

    }
   
}

-(void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"金牌洗衣";
    
    [self setToorbar];
    
    [self initRecordView];
 
//    [self setupLeftMenuButton];
}

-(void)initRecordView
{
    UIWindow *shareWindow = [UIApplication sharedApplication].keyWindow;
    
    _recordBigBackGroundImageView = [[UIImageView alloc ]initWithFrame:CGRectMake(shareWindow.frame.origin.x, shareWindow.frame.origin.y, shareWindow.frame.size.width, shareWindow.frame.size.height - 130/2)];
    _recordBigBackGroundImageView.backgroundColor = [UIColor whiteColor];
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
        _recordBigBackGroundImageView.alpha = 0.8;

    } completion:^(BOOL finished) {
        
    }];
    
    
    [shareWindow addSubview:_recordBigBackGroundImageView];
}




-(void)initData
{
    _imageUrlArray = [NSMutableArray arrayWithCapacity:0];
    
    _section1Array = [NSMutableArray arrayWithCapacity:0];
    
    _locationAddress = @"正在定位";
    
    hadFirstAddRecordView = NO;
    
    [_section1Array addObjectsFromArray:@[
                                          XCCenterPage_yiwu,
                                          XCCenterPage_xiewa,
                                          XCCenterPage_shechi,
                                          XCCenterPage_jujia,
                                          XCCenterPage_pibao]];
    
//#ifdef XC_TEST
    [_imageUrlArray addObjectsFromArray: @[
                                           [NSURL URLWithString:@"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"],
                                           [NSURL URLWithString:@"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg"],
                                           [NSURL URLWithString:@"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"],
                                           [NSURL URLWithString:@"https://ss0.baidu.com/7Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=0c231a5bb34543a9f54ea98c782abeb0/a71ea8d3fd1f41342830c1d1211f95cad1c85e1e.jpg"]
                                           ]];
    
    

//#endif
    
    
}


-(void)initScrollImageView
{
//    _imageScrollView =
    
    _imageScrollView= [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150) imageURLsGroup:_imageUrlArray];
    _imageScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _imageScrollView.delegate = self;
    _imageScrollView.autoScrollTimeInterval = 4.0;

//    [self.view addSubview:_imageScrollView];
}

-(void)initUICollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kScreenHeightNoStatusAndNoNaviBarHeight-130/2) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[XCCenterFirstCollectionViewCell class] forCellWithReuseIdentifier:@"section0Cell"];
    
    [_collectionView registerClass:[XCCenterSecondCollectionViewCell class] forCellWithReuseIdentifier:@"section1Cell"];
    
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
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
    
    [_addYuyinWashButton addTarget:self action:@selector(btnDragUp:) forControlEvents:UIControlEventTouchCancel];
    
//    [_addYuyinWashButton addTarget:self action:@selector(btnDragUp:) forControlEvents:UIControlEventTouchUpOutside];

    
    
    
    [_addYuyinWashButton addTarget:self action:@selector(btnDragUp:) forControlEvents:UIControlEventTouchDragExit];
    
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




#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    DDLogInfo(@"---点击了第%d张图片", index);
}


#pragma mark - UICollectionViewDataSource -

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else
        
        return [_section1Array count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if (indexPath.section == 0)
    {
        
        NSString *identifier = @"section0Cell";
        
        XCCenterFirstCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        [cell sizeToFit];
        
        
        if (cell == nil)
        {
            DDLogInfo(@"----------");
        }
        
        
        
        
        cell.cellImageView.image = Take_image;
        cell.cellLabel.text = _locationAddress;
        
        return cell;
    }
    else
    {
        NSString *identifier = @"section1Cell";
        
        XCCenterSecondCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        [cell sizeToFit];
        
        
        if (cell == nil)
        {
            DDLogInfo(@"----------");
        }
        
        
        cell.cellImageView.image =[_section1Array objectAtIndex:indexPath.row];
        
        return cell;
    }
    
    
    
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        UICollectionReusableView *headerView =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
        
        [headerView addSubview:_imageScrollView];
        
        return headerView;
    }
    else
        return nil;
    
    
}


#pragma mark - UICollectionViewDelegateFlowLayout -

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        return CGSizeMake(self.view.bounds.size.width,44);
    }
    else
    {
        return CGSizeMake((self.view.bounds.size.width-20-10)/2, 70);
        
    }
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section ==1)
    {
        return  UIEdgeInsetsMake(10, 10, 10, 10);
    }
    else
        return UIEdgeInsetsZero;
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section ==0)
    {
        return CGSizeMake(self.view.bounds.size.width, 150);
    }
    else
        return CGSizeZero;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DDLogInfo(@"选择%d",indexPath.row);
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:AccountLoginResult])
    {
        //未登录
        [self clickButtonWhenUnlogin];
        
        return;
    }
    
    
    
    if (indexPath.section == 1)
    {
        WashPriceType type = WashPriceType_yiwu;
        switch (indexPath.row)
        {
            case 0:
            {
                type = WashPriceType_yiwu;
            }
                break;
            case 1:
            {
                type = WashPriceType_xiewa;
            }
                break;
                
            case 2:
            {
                type = WashPriceType_shechipin;
            }
                break;
                
            case 3:
            {
                type = WashPriceType_jujia;
            }
                break;
                
            case 4:
            {
                type = WashPriceType_pibao;
            }
                break;
                
                
            default:
                break;
        }
        
        XCWashPriceDetailViewController *priceMVC = [[XCWashPriceDetailViewController alloc]initWithWsahPriceType:type];
        [self.navigationController pushViewController:priceMVC animated:YES];
    }
    
    
    
    
    
    
    
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)collectionView:(UICollectionView *)colView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    
    [cell setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)collectionView:(UICollectionView *)colView  didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    
    [cell setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - yuyin -

-(void)clickAddYuyinWashButtonDown:(id)sender
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:AccountLoginResult])
    {
        //未登录
        [self clickButtonWhenUnlogin];
        
        return;
    }

    
    
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
    
    _recordFileUrlStr = [NSString stringWithFormat:@"%@/makeOrder%@.aac", strUrl,@"1234"];
    
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



#pragma mark - 预约
-(void)clickApplyWashButton
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:AccountLoginResult])
    {
        //未登录
        [self clickButtonWhenUnlogin];
        
        return;
    }

    
    
    XCMakeApplyOrderViewController *makeOrderMVC = [[XCMakeApplyOrderViewController alloc]init];
    [self.navigationController pushViewController:makeOrderMVC animated:YES];
}

#pragma mark - CLLocationManagerDelegate - 

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [manager stopUpdatingLocation];
    
    DDLogInfo(@"location ok ");
    
    
    CLGeocoder *geocode = [[CLGeocoder alloc]init];
    [geocode reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks)
        {
            
            NSDictionary *test = [placemark addressDictionary];
            //  Country(国家)  State(城市)  SubLocality(区)
            
//            City = "\U897f\U5b89\U5e02";// 城市名字
//            Country = "\U4e2d\U56fd";// 国家名字
//            CountryCode = CN;// 国家编码
//            FormattedAddressLines =     (
//                                         "\U4e2d\U56fd",
//                                         "\U9655\U897f\U7701\U897f\U5b89\U5e02\U96c1\U5854\U533a",
//                                         "\U9ad8\U65b0\U516d\U8def34\U53f7"
//                                         ); // 这个应该是格式化后的地址了
//            State = "\U9655\U897f\U7701"; // 省
//            Street = "\U9ad8\U65b0\U516d\U8def 34\U53f7";// 街道完整名称
//            SubLocality = "\U96c1\U5854\U533a";//区名
//            SubThoroughfare = "34\U53f7";//具体地址
//            Thoroughfare = "\U9ad8\U65b0\U516d\U8def";//街道名称
            
            
            NSString *address = [NSString stringWithFormat:@"%@",[test objectForKey:@"Name"]];
            
            _locationAddress =address;
        }


        [_collectionView reloadData];
        
    }];
    
    

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
