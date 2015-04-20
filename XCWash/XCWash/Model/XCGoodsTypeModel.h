//
//  XCGoodsTypeModel.h
//  XCWash
//
//  Created by weili.wu on 15/4/7.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCGoodsTypeModel : NSObject

@property(nonatomic,strong)NSString *gt_id;
@property(nonatomic,strong)NSString *gt_name;
@property(nonatomic,strong)NSString *gt_parent_id;
@property(nonatomic,strong)NSString *gt_desc;
@property(nonatomic,strong)NSString *lr_ry;
@property(nonatomic,strong)NSString *lr_sj;


@end


@interface XCGoodsModel : NSObject

@property(nonatomic,strong)NSString *g_id;
@property(nonatomic,strong)NSString *g_name;
@property(nonatomic,strong)NSString *g_img;
@property(nonatomic,strong)NSString *gt_id;
@property(nonatomic,strong)NSString *g_price;
@property(nonatomic,strong)NSString *g_sm;
@property(nonatomic,strong)NSString *g_estimate_time;
@property(nonatomic,strong)NSString *g_type;


@end