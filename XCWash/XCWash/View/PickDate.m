//
//  PickDate.m
//  PowerLife
//
//  Created by 余海平 on 11-7-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//



#import "PickDate.h"
#import "DateFormate.h"

@implementation PickDate

@synthesize _datePicker;
@synthesize _back;
@synthesize _submit;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor=[UIColor clearColor];
        
        
        _back = [[UIBarButtonItem alloc] initWithTitle:STR_CANCEL
                                                style:UIBarButtonItemStyleBordered 
                                               target:self 
                                               action:@selector(dismiss)];
        
        _submit = [[UIBarButtonItem alloc] initWithTitle:STR_DONE
                                                  style:UIBarButtonItemStyleDone 
                                                 target:self 
                                                 action:@selector(change)];
        
        UIBarButtonItem *_space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        [_back setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:TITLE_COLOR,NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        
        [_submit setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:TITLE_COLOR,NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame: CGRectMake(0, 0, kMainScreenWidth, 44)];
        [toolBar setBarStyle:UIBarStyleDefault];
        
        [toolBar setItems:[NSArray arrayWithObjects:_back,_space,_submit, nil]];
        
        _datePicker = [[UIDatePicker alloc] initWithFrame: CGRectMake(0,44, kMainScreenWidth, 216)];
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _datePicker.minimumDate = [NSDate date];
        if (CurrentSystemVersion >= 7.0) {
            _datePicker.backgroundColor = [UIColor whiteColor];

        }else
        {
            _datePicker.backgroundColor = [UIColor clearColor];

        }
        
        [self addSubview:toolBar];
        [self addSubview:_datePicker];
        
    }
    return self;
}

-(int)compareDate:(NSString*)value1 andDate:(NSString*)value2
{
    // -1 means normal
    // 1 means unnormal
    
    // 2013-05-28  value2 the day time
    if ([value1 length] == 0
        || [value2 length] == 0)
    {
        return 0;
    }
    
    int year1 = [[value1 substringWithRange:NSMakeRange(0, 4)] intValue];
    int year2 = [[value2 substringWithRange:NSMakeRange(0, 4)] intValue];
    
    int month1 = [[value1 substringWithRange:NSMakeRange(5, 2)] intValue];
    int month2 = [[value2 substringWithRange:NSMakeRange(5, 2)] intValue];
    
    int day1 = [[value1 substringWithRange:NSMakeRange(8, 2)] intValue];
    int day2 = [[value2 substringWithRange:NSMakeRange(8, 2)] intValue];
    
    if (year1<year2)
    {
        return -1;
    }
    else if(year1 > year2)
    {
        return 1;
    }
    else
    {
        if (month1 < month2)
        {
            return -1;
        }
        else if(month1 > month2)
        {
            return 1;
        }
        else
        {
            if (day1 < day2)
            {
                return -1;
            }
            else
            {
                return 1;
            }
            
        }
    }
}

#pragma mark -
#pragma mark -给定时间
-(void)setOriginalTimeStr:(NSString *)timeStr
{
    NSDate  *newData = [DateFormate getNSDateFromTimeStr:timeStr];
    
    [_datePicker setDate:newData animated:YES];
}



#pragma mark -
#pragma mark 确认按钮
//确认按钮
-(void)change
{
    [self dismiss];
    
    NSDate* pickDate = [_datePicker date];
    //获取当前时间
    NSDate *now = [NSDate date];
    
    NSDateFormatter *date = [[NSDateFormatter alloc] init];
    [date setDateStyle:NSDateFormatterMediumStyle];
    [date setTimeStyle:NSDateFormatterShortStyle];
    [date setDateFormat:@"yyyy-MM-dd HH:mm"];

//    if ([self compareDate:[date stringFromDate:pickDate] andDate:[date stringFromDate:now]] == -1)
//        
//    {
//        _date = [NSString stringWithFormat:@"%@",[date stringFromDate:pickDate]];
////        [_datePicker setDate:pickDate animated:YES];
//        
//        
//    }else
//    {
//        _date = [NSString stringWithFormat:@"%@",[date stringFromDate:now]];
//        [_datePicker setDate:[NSDate date] animated:YES];
//    
//    }
    
    _date = [NSString stringWithFormat:@"%@",[date stringFromDate:pickDate]];
    
    [delegate changeDate:_date];
}



#pragma mark -
#pragma mark 取消按钮
-(void)dismiss
{
//    [UIView beginAnimations:@"dismiss" context:nil];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:3];
//    [self removeFromSuperview];
//    [UIView commitAnimations];
    
    [delegate dissmissPicker];
}
#pragma mark -
#pragma mark AddPickDateView 没用
-(void)AddPickDateView:(UIViewController *)_view
{
    [self removeFromSuperview];
    
    if ([[self subviews] containsObject:_datePicker])
    {
        [_datePicker removeFromSuperview];
        [self addSubview:_datePicker];
    }else
    {
        [self addSubview:_datePicker];
       
    }
 
    [UIView beginAnimations:@"show" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:3];
    [self setFrame:CGRectMake(0, kScreenHeightNoStatusAndNoNaviBarHeight- 216+20, 320, 216+44)];
    [_view.navigationController.view addSubview:self];
    [UIView commitAnimations];
    
}
@end
