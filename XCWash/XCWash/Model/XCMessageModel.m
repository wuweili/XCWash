//
//  XCMessageModel.m
//  XCWash
//
//  Created by wuweiqing on 15/3/29.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCMessageModel.h"

@implementation XCMessageModel

-(id)init
{
    self = [super init];
    if (self)
    {
        _m_id = @"";
        
        _m_title = @"";
        
        _m_user_type = @"";
        
        _m_content = @"";
        
        _lr_ry = @"";
        
        _lr_sj = @"";
   
    }
    return self;
}



@end
