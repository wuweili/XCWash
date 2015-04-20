//
//  XCOrderModel.h
//  XCWash
//
//  Created by wuweiqing on 15/3/22.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MyOrderStatus)
{
    MyOrderStatus_normal,
    MyOrderStatus_songxi,
    MyOrderStatus_daodian,
    MyOrderStatus_qingxi,
    MyOrderStatus_fanhui,
    MyOrderStatus_pingjia
};



@interface XCOrderModel : NSObject

@property(nonatomic,strong)NSString *orderId;   //o_id
@property(nonatomic,strong)NSString *orderNumber; //o_no
@property(nonatomic,strong)NSString * orderTime; //o_time
@property(nonatomic,strong)NSString *takeAddress; //o_cu_et_add
@property(nonatomic,strong)NSString *sendAddress; //o_cu_ets_add
@property(nonatomic,strong)NSString *listenFileUrl;//o_voice_url
@property(nonatomic,strong)NSString *o_status;//o_voice_url
//订单状态：0  新建
//10 待确认
//20 待取件
//30 洗涤中
//40 待确认(派送)
//50  待结算
//60 已完成
//90 取消


@property(nonatomic,assign)MyOrderStatus orderStatus; //o_status

@property(nonatomic,strong)NSString *o_cu_et_time; //预约取件时间


//生成订单





@end
