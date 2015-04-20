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
        
    }
    
    return self;
    
}


@end
