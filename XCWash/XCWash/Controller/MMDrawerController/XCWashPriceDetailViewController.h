//
//  XCWashPriceDetailViewController.h
//  XCWash
//
//  Created by wuweiqing on 15/4/5.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCBaseCenterViewController.h"
#import "SVTopScrollView.h"
#import "SVRootScrollView.h"


typedef NS_ENUM(NSInteger, WashPriceType)
{
    WashPriceType_yiwu = 0,
    WashPriceType_xiewa,
    WashPriceType_shechipin,
    WashPriceType_jujia,
    WashPriceType_pibao
};



@interface XCWashPriceDetailViewController : XCBaseCenterViewController

@property(nonatomic,assign)WashPriceType washPriceType;

-(id)initWithWsahPriceType:(WashPriceType)type
;
@end
