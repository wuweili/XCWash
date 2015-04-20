//
//  XCAddressModel.h
//  XCWash
//
//  Created by wuweiqing on 15/4/6.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCAddressModel : NSObject

@property(nonatomic,strong)NSString *ua_id;    //地址id
@property(nonatomic,strong)NSString *ua_address; //地址
@property(nonatomic,strong)NSString *ua_isdefault; //是否默认地址
@property(nonatomic,strong)NSString *ua_type;   //send take

@end
