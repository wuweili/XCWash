//
//  XCUserModel.h
//  XCWash
//
//  Created by 吴伟庆 on 15/3/12.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCUserModel : NSObject

@property(nonatomic,strong)NSString *userName; //u_nickname

@property(nonatomic,strong)NSString *userId; //u_id

@property(nonatomic,strong)NSString *userPictureUrl;//u_photo

@property(nonatomic,strong)NSString *userTelphoneNum;//u_phone



@property(nonatomic,strong)NSString *u_address;//u_address

@property(nonatomic,strong)NSString *u_email;//u_email

@property(nonatomic,strong)NSString *u_get_message;//

@property(nonatomic,strong)NSString *u_integral;

@property(nonatomic,strong)NSString *u_qq;

@property(nonatomic,strong)NSString *u_regTime;


+(XCUserModel *)shareInstance;

@end
