//
//  PickDate.h
//  PowerLife
//
//  Created by 余海平 on 11-7-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PickDateDelegate <NSObject>

-(void)changeDate:(NSString *)date;
-(void)dissmissPicker;

@end

@interface PickDate : UIView
{
    UIDatePicker       *_datePicker;
    UIBarButtonItem    *_back;
    UIBarButtonItem    *_submit;
    NSString           *_date;
}
@property(nonatomic,strong)  UIDatePicker *_datePicker;
@property(nonatomic,strong)  UIBarButtonItem *_back;
@property(nonatomic,strong)  UIBarButtonItem *_submit;
@property(nonatomic,assign)  id<PickDateDelegate> delegate;

-(void)change;
-(void)dismiss;
-(void)AddPickDateView:(UIViewController *)_view;
-(int)compareDate:(NSString*)value1 andDate:(NSString*)value2;
#pragma mark -给定时间
-(void)setOriginalTimeStr:(NSString *)timeStr;

@end
