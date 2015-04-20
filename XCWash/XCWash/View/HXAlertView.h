//
//  HXAlertView.h
//  BJXH-patient
//
//  Created by wu weili on 14-7-27.
//  Copyright (c) 2014年 archermind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSTapRateView.h"


@class HXPlaceHolderTextView;


const static int HXAlert_bgImageView_tag = 20141208;

const static int bgImageView_tag = 20141017;

typedef void(^EvaDoctorRightBlock)(NSInteger washEvaIntegerValue,NSInteger serviceEvaIntegerValue,NSString *evaMessage);

typedef void(^InputTextAboveStandardBlock)(NSString *tipMsg);


@interface HXAlertView : UIView<RSTapRateViewDelegate,UITextViewDelegate>
{
    BOOL _leftLeave;
    float _alertWidth;
    float _alertHeight;
    UIScrollView* bgImageView;
    
    BOOL isExitAlertView ;
    
    HXPlaceHolderTextView *_messTextView;

    RSTapRateView *_washRateView;
    RSTapRateView*_serviceRateview;
    
}

@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;
@property (nonatomic, copy) dispatch_block_t bottomBlock;
@property (nonatomic, copy) dispatch_block_t dismissBlock;
@property (nonatomic, copy) dispatch_block_t closeBlock;


@property (nonatomic, copy) EvaDoctorRightBlock evaDoctorRightBlock;
@property (nonatomic, copy) InputTextAboveStandardBlock inputTextAboveStandardBlock;



@property (nonatomic, strong) UILabel *alertContentLabel;
@property (nonatomic, strong) UILabel *alertTitleLabel;

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *bottomBtn;
@property (nonatomic, strong) UIView *backImageView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIView *greenLine;


- (void)show;


#pragma mark - 一般的提示信息弹窗
-(id)initRemindInfoWithTitle:(NSString *)title contentText:(NSString *)contentText leftBtnTitle:(NSString *)leftTltle rightBtnTitle:(NSString *)rightTitle haveCloseButton:(BOOL)haveCloseButton;
#pragma mark - 评价 -
-(id)initEvaAlertView;

@end
