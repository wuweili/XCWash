//
//  XCUserModel.m
//  XCWash
//
//  Created by 吴伟庆 on 15/3/12.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCUserModel.h"

@implementation XCUserModel

static XCUserModel *instance = nil;

-(id)init
{
    self = [super init];
    if (self)
    {
        _userId = @"";
        
        _userPictureUrl = @"";
        
        _userName = @"";
        
        _userTelphoneNum = @"";
        
    }
    return self;
}


+(XCUserModel *)shareInstance
{
    
    @synchronized(self)
    {
        if (nil == instance)
        {
            instance = [[XCUserModel alloc] init];
        }
    }
    return instance;
}



@end
