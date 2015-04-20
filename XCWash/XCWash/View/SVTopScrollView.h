//
//  SVTopScrollView.h
//  SlideView
//
//  Created by Chen Yaoqiang on 13-12-27.
//  Copyright (c) 2013年 Chen Yaoqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SVTopScrollViewDelegate <NSObject>

-(void)clickTopButtonWithButtonTag:(NSInteger)tag;

@end


@interface SVTopScrollView : UIScrollView <UIScrollViewDelegate>
{
    NSArray *nameArray;
    NSInteger userSelectedChannelID;        //点击按钮选择名字ID
    NSInteger scrollViewSelectedChannelID;  //滑动列表选择名字ID
    
    UIImageView *shadowImageView;   //选中阴影
}
@property (nonatomic, strong) NSArray *nameArray;

@property(nonatomic,strong)NSMutableArray *buttonOriginXArray;
@property(nonatomic,strong)NSMutableArray *buttonWithArray;

@property (nonatomic, assign) NSInteger scrollViewSelectedChannelID;

@property(nonatomic,weak)id<SVTopScrollViewDelegate>topViewdelegate;

- (id)initWithFrame:(CGRect)frame;


//+ (SVTopScrollView *)shareInstance;
/**
 *  加载顶部标签
 */
- (void)initWithNameButtons;
/**
 *  滑动撤销选中按钮
 */
- (void)setButtonUnSelect;
/**
 *  滑动选择按钮
 */
- (void)setButtonSelect;
/**
 *  滑动顶部标签位置适应
 */
-(void)setScrollViewContentOffset;


@end
