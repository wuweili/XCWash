//
//  XCMakeOrderViewController.m
//  XCWash
//
//  Created by weili.wu on 15/4/2.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCMakeOrderViewController.h"

@interface XCMakeOrderViewController ()<AVAudioRecorderDelegate>
{
    NSString *_recordFileUrlStr;
    
    NSTimer *_timer;
    
    AVAudioRecorder *_recorder;
}

@end

@implementation XCMakeOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.recordButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 100, 80, 40)];
    
    self.playButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 170, 80, 40)];
    
    
    [self.recordButton setTitle:@"录音" forState:UIControlStateNormal];
    [self.playButton setTitle:@"播放" forState:UIControlStateNormal];
    
    
    [self.recordButton addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchDown];
    [self.recordButton addTarget:self action:@selector(btnUp:) forControlEvents:UIControlEventTouchUpInside];
    [self.recordButton addTarget:self action:@selector(btnDragUp:) forControlEvents:UIControlEventTouchDragExit];
    [self.playButton addTarget:self action:@selector(playRecordSound:) forControlEvents:UIControlEventTouchDown];
    
   
}


- (void)playRecordSound:(id)sender
{
    if (self.avPlay.playing) {
        [self.avPlay stop];
        return;
    }
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:_recordFileUrlStr] error:nil];
    self.avPlay = player;
    [self.avPlay play];
}


- (void)btnDown:(id)sender
{
    //创建录音文件，准备录音
    if ([_recorder prepareToRecord])
    {
        //开始
        [_recorder record];
    }
    
    //设置定时检测
    _timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];
}


- (void)btnUp:(id)sender
{
    double cTime = _recorder.currentTime;
    if (cTime > 2)
    {
        //如果录制时间<2 不发送
        
    }
    else
    {
        //删除记录的文件
        [_recorder deleteRecording];
        //删除存储的
    }
    
    [_recorder stop];
    [_timer invalidate];
    _timer = nil;
     DDLogInfo(@"发出去");
  }
- (void)btnDragUp:(id)sender
{
    //删除录制文件
    [_recorder deleteRecording];
    [_recorder stop];
    [_timer invalidate];
    _timer = nil;
    
    
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
    
    _recordFileUrlStr = [NSString stringWithFormat:@"%@/lll.aac", strUrl];
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/lll.aac", strUrl]];
    
    NSError *error;
    //初始化
    _recorder = [[AVAudioRecorder alloc]initWithURL:url settings:recordSetting error:&error];
    //开启音量检测
    _recorder.meteringEnabled = YES;
    _recorder.delegate = self;
}

- (void)detectionVoice
{
    [_recorder updateMeters];//刷新音量数据
    //获取音量的平均值  [recorder averagePowerForChannel:0];
    //音量的最大值  [recorder peakPowerForChannel:0];
    
    double lowPassResults = pow(10, (0.05 * [_recorder peakPowerForChannel:0]));
    //最大50  0
    //图片 小-》大
    if (0<lowPassResults<=0.06) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_01.png"]];
    }else if (0.06<lowPassResults<=0.13) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_02.png"]];
    }else if (0.13<lowPassResults<=0.20) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_03.png"]];
    }else if (0.20<lowPassResults<=0.27) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_04.png"]];
    }else if (0.27<lowPassResults<=0.34) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_05.png"]];
    }else if (0.34<lowPassResults<=0.41) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_06.png"]];
    }else if (0.41<lowPassResults<=0.48) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_07.png"]];
    }else if (0.48<lowPassResults<=0.55) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_08.png"]];
    }else if (0.55<lowPassResults<=0.62) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_09.png"]];
    }else if (0.62<lowPassResults<=0.69) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_10.png"]];
    }else if (0.69<lowPassResults<=0.76) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_11.png"]];
    }else if (0.76<lowPassResults<=0.83) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_12.png"]];
    }else if (0.83<lowPassResults<=0.9) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_13.png"]];
    }else {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_14.png"]];
    }
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
