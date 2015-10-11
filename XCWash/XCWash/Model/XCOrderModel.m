//
//  XCOrderModel.m
//  XCWash
//
//  Created by wuweiqing on 15/3/22.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCOrderModel.h"

@implementation XCOrderModel

-(id)init
{
    self = [super init];
    
    if (self)
    {
        _orderNumber = @"";
        _orderTime = @"";
        _takeAddress = @"";
        _sendAddress = @"";
        _listenFileUrl = @"";
        _orderStatus = MyOrderStatus_normal;
        _o_words = @"";
        
    }
    
    return self;
    
}


@end

@implementation XCOrderClothesPhotoModel

-(id)init
{
    self = [super init];
    
    if (self)
    {
        _dp_id = @"";
        
        _dp_imgurl = @"";
    }
    
    return self;
    
    
    
}


@end

@implementation XCOrderClothesModel

-(id)init
{
    self = [super init];
    
    if (self)
    {
        self.oa_id = @"";
        self.g_id = @"";
        
        self.g_name = @"";
        
        self.od_no = @"";
        
        self.o_id = @"";
        
        self.oa_price = @"";
        
        self.g_old_price = @"";
        
        self.oa_brand = @"";
        
        self.oa_cloth = @"";
        
        self.oa_color = @"";
        
        self.oa_remark = @"";
        
        self.oa_defect = @"";
        
        self.oa_annex = @"";
        
        self.oa_send_scan = @"";
        
        self.oa_take_scan = @"";
        
        self.oa_status = @"";
        
        self.oa_discount = @"";
        
         self.oa_reason = @"";
        
         self.oa_handel = @"";
        
         self.photos = [NSMutableArray arrayWithCapacity:0];
        
    }
    
    return self;

}

@end

@implementation XCOrderDetailModel

-(id)init
{
    self = [super init];
    
    if (self)
    {
        self.o_id = @"";
        
        self.o_no = @"";
        
        self.o_total_price = @"";
        
        self.u_nickname = @"";
        
        self.u_phone = @"";
        
        self.o_status = @"";
        
        self.o_cu_et_add = @"";
        
        self.o_cu_ets_add = @"";
        
        self.o_time = @"";
        
        self.o_at_time = @"";
        
        self.o_as_time = @"";
        
        self.o_finish_time = @"";
        
        self.attrList = [NSMutableArray arrayWithCapacity:0];
                
    }
    
    return self;
    
    
}

@end
