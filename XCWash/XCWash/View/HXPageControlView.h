//
//  HXPageControlView.h
//  BJXH-patient
//
//  Created by wu weili on 14-7-5.
//  Copyright (c) 2014年 archermind. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HXPageControlViewDelegate <NSObject>

-(void)clickPageControlButtonWithClickIndex:(NSInteger)clickedIndex;

@end

@interface HXPageControlView : UIView

@property(nonatomic,weak)id<HXPageControlViewDelegate>delegate;

-(id)initWithFrame:(CGRect)frame pageControlAllNumber:(NSInteger)number currentPage:(NSInteger)currentPage;

-(void)updatePageControWithCurrentPage:(NSInteger)currentPage;

@end
