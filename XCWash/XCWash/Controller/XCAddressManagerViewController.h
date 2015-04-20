//
//  XCAddressManagerViewController.h
//  XCWash
//
//  Created by 吴伟庆 on 15/3/17.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

typedef NS_ENUM(NSInteger, MyAddressType)
{
    MyAddressType_recieve,
    MyAddressType_send
};



#import "XCBaseCenterViewController.h"

@interface XCAddressManagerViewController : XCBaseCenterViewController

@property(nonatomic,assign)MyAddressType addressType;

@end
