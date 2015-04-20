//
//  HXPlaceHolderTextView.h
//  BJXH-patient
//
//  Created by wu weili on 14-7-31.
//  Copyright (c) 2014年 archermind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXPlaceHolderTextView : UITextView<UITextViewDelegate>

@property(nonatomic, retain) UILabel *placeHolderLabel;
@property(nonatomic, retain) NSString *placeholder;
@property(nonatomic, retain) UIColor *placeholderColor;


-(void)textChanged:(NSNotification*)notification;
-(void)isEmptyWithTip:(NSString *)tipStr;
-(void)isReset;

@end
