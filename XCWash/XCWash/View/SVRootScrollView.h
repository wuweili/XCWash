//
//  SVRootScrollView.h
//  SlideView
//
//  Created by Chen Yaoqiang on 13-12-27.
//  Copyright (c) 2013年 Chen Yaoqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SVRootScrollViewDelegate <NSObject>

-(void)adjustTopScrollViewButtonWithScrollViewSelectedChannelID:(NSInteger)tag;

-(void)loadDataWithTag:(NSInteger)tag;

@end

@interface SVRootScrollView : UIScrollView <UIScrollViewDelegate>
{
    NSArray *viewNameArray;
    CGFloat userContentOffsetX;
    BOOL isLeftScroll;
}
@property (nonatomic, strong) NSArray *viewNameArray;
@property(nonatomic,weak)id<SVRootScrollViewDelegate>rootScrollViewGelegate;

- (id)initWithFrame:(CGRect)frame;

//+ (SVRootScrollView *)shareInstance;

- (void)initWithViews;
/**
 *  加载主要内容
 */
- (void)loadData;

@end
