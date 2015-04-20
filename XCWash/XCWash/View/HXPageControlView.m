//
//  HXPageControlView.m
//  BJXH-patient
//
//  Created by wu weili on 14-7-5.
//  Copyright (c) 2014年 archermind. All rights reserved.
//

#import "HXPageControlView.h"

@implementation HXPageControlView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(id)initWithFrame:(CGRect)frame pageControlAllNumber:(NSInteger)number currentPage:(NSInteger)currentPage
{
    self = [super initWithFrame:frame];
    if (self)
    {
        for (int i= 0;i< number; i++)
        {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(15*i, 0, 10, 10);
            btn.tag=i+1000;
            [btn addTarget:self action:@selector(clickPageControlButton:) forControlEvents:UIControlEventTouchUpInside];
            if (i==currentPage)
            {
                [btn setBackgroundImage:PAGE_CONTROL_SELECTED_IMAGE forState:UIControlStateNormal];
            }
            else{
                [btn setBackgroundImage:PAGE_CONTROL_UNSELECTED_IMAGE forState:UIControlStateNormal];
            }
            
            [self addSubview:btn];
        }
        
    }
    return self;
}

-(void)updatePageControWithCurrentPage:(NSInteger)currentPage
{
    
    for (UIButton *controlBtn in self.subviews)
    {
        if (controlBtn.tag == currentPage + 1000)
        {
            [controlBtn setBackgroundImage:PAGE_CONTROL_SELECTED_IMAGE forState:UIControlStateNormal];
        }
        else
        {
            [controlBtn setBackgroundImage:PAGE_CONTROL_UNSELECTED_IMAGE forState:UIControlStateNormal];
        }
    }
    
}


-(void)clickPageControlButton:(id)sender
{
    UIButton *pageControlBtn = (UIButton *)sender;
    
    [self updatePageControWithCurrentPage:pageControlBtn.tag - 1000];
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(clickPageControlButtonWithClickIndex:)])
    {
        [_delegate clickPageControlButtonWithClickIndex:pageControlBtn.tag - 1000];
    }
    
}



@end
