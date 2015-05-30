//
//  UIImageView+Avatar.h
//  BJXH-patient
//
//  Created by wu weili on 14-5-15.
//  Copyright (c) 2014年 archermind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Avatar)

//用户头像 update yes 表示每次都更新本地头像 no 表示直接从本地取
-(void)setUserAvatarWithUserId:(NSString *)userId headUrl:(NSString *)urlString withSize:(CGFloat)size update:(BOOL)update;


/**
 * 下载商品头像
 */
-(void)setGoodsListGoodsAvatarWithGoodsId:(NSString *)goodsId headUrl:(NSString *)urlString withSize:(CGFloat)size update:(BOOL)update;

/**
 * 订单详情衣服图片
 */
-(void)setOrderDetailClothesAvatarWithPhotoId:(NSString *)photoId headUrl:(NSString *)urlString withSize:(CGFloat)size update:(BOOL)update;



+ (UIImage *)reflectedImage:(UIImageView *)fromImage withHeight:(NSUInteger)height;

@end
