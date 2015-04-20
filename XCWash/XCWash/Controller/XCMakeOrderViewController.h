//
//  XCMakeOrderViewController.h
//  XCWash
//
//  Created by weili.wu on 15/4/2.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@interface XCMakeOrderViewController : UIViewController


@property(nonatomic,strong)UIButton *recordButton;
@property(nonatomic,strong)UIButton *playButton;
@property(nonatomic,strong)AVAudioPlayer *avPlay;

@property(nonatomic,strong)UIImageView *imageView;

@end
