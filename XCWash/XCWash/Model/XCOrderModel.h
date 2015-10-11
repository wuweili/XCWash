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
@property(nonatomic,strong)NSString *o_words;
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

@end


@interface XCOrderClothesPhotoModel : NSObject

@property(nonatomic,strong)NSString *dp_id;//图片id

@property(nonatomic,strong)NSString *dp_imgurl;//图片地址


@end




@interface XCOrderClothesModel : NSObject

@property(nonatomic,strong)NSString *oa_id;//主键

@property(nonatomic,strong)NSString *g_id;//商品id

@property(nonatomic,strong)NSString *g_name;//名称

@property(nonatomic,strong)NSString *od_no; //衣物条码

@property(nonatomic,strong)NSString *o_id;//订单id

@property(nonatomic,strong)NSString *oa_price;//单价

@property(nonatomic,strong)NSString *g_old_price;//衣物原价

@property(nonatomic,strong)NSString *oa_brand;//品牌

@property(nonatomic,strong)NSString *oa_cloth;//布料

@property(nonatomic,strong)NSString *oa_color;//颜色

@property(nonatomic,strong)NSString *oa_remark;//备注

@property(nonatomic,strong)NSString *oa_defect;//瑕疵

@property(nonatomic,strong)NSString *oa_annex;//附件

@property(nonatomic,strong)NSString *oa_send_scan;//送件扫描状态0：未扫，1已扫描
@property(nonatomic,strong)NSString *oa_take_scan;//取件扫描状态0：未扫，1已扫描

@property(nonatomic,strong)NSString *oa_status;//疑件状态：0，正常，1疑件，2疑件已解决


@property(nonatomic,strong)NSString *oa_discount;//赔偿金额

@property(nonatomic,strong)NSString *oa_reason;//疑件原因

@property(nonatomic,strong)NSString *oa_handel;//疑件处理办法

@property(nonatomic,strong)NSMutableArray *photos;//图片数组

@end



@interface XCOrderDetailModel : NSObject

@property(nonatomic,strong)NSString *o_id;   //o_id订单id
@property(nonatomic,strong)NSString *o_no; //o_no订单号
@property(nonatomic,strong)NSString *o_total_price; //订单总价
@property(nonatomic,strong)NSString *u_id;
//用户id
@property(nonatomic,strong)NSString *u_nickname;//用户名

@property(nonatomic,strong)NSString *u_phone;//手机号

@property(nonatomic,strong)NSString *o_status;//订单状态

@property(nonatomic,strong)NSString *o_cu_et_add;//客户预约取件地址

@property(nonatomic,strong)NSString *o_cu_ets_add;//客户预约送件地址

@property(nonatomic,strong)NSString *o_time;//下单时间

@property(nonatomic,strong)NSString *o_at_time;//取件时间

@property(nonatomic,strong)NSString *o_as_time;//送件时间

@property(nonatomic,strong)NSString *o_finish_time;//完成时间

@property(nonatomic,strong)NSMutableArray  *attrList;//订单衣物列表


@end

