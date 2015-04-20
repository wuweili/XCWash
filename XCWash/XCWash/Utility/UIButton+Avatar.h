//
//  UIButton+Avatar.h
//  BJXH-patient
//
//  Created by wu weili on 14-5-15.
//  Copyright (c) 2014年 archermind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Avatar)


//设置用户头像 表示每次都更新本地头像 no 表示直接从本地取
-(void)setUserAvatarWithUserId:(NSString *)userId headUrl:(NSString *)urlString withSize:(CGFloat)size update:(BOOL)update loadImageFinish:(void (^)(UIImage *image))loadImageFinish;

@end
