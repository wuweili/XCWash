//
//  DocumentUtil.h
//  BJXH-patient
//
//  Created by wu weili on 14-5-5.
//  Copyright (c) 2014年 archermind. All rights reserved.
//

#import <Foundation/Foundation.h>

// 沙盒中为各种类型的文件指定默认文件夹



#define HEAD_AVATAR   @"HeadPhoto_avatar"


#define FOLDER_PATIENT_AVATAR  @"UserPhoto_Avatar"

#define RECORD_FILE   @"Record_file"

#define WASH_GOODS_FILE   @"Wash_goods_file"

#define WASH_ORDER_DETAIL_FILE   @"Wash_order_detail_file"





// 需要图片压缩的原图尺寸上限
#define IMAGE_COMPRESS_LIMIT 150
// 需要缩减图片尺寸的原图尺寸上限
#define IMAGE_RESIZE_LIMIT   960

// 与以上两个对应的缩略图参数
#define THUMBNAIL_COMPRESS_LIMIT 80
#define THUMBNAIL_RESIZE_LIMIT   150

// 图片压缩比
#define COMPRESSION_QUALITY 0.75

@interface DocumentUtil : NSObject {
    
}

// 构造文件路劲，并确保创建文件夹
+ (NSString *)pathForFolder:(NSString *)folderName docName:(NSString *)docName;

// 以时间、随机数构造指定后缀名的文件名
+ (NSString *)createDocNameWithExtension:(NSString *)extension;

// 按照压缩上限、缩放上限修正图片，同时修正照相时的方位错误
+ (NSData *)fixImage:(UIImage *)image compressionLimite:(CGFloat)cl resizeLimite:(CGFloat)rl;

#pragma mark - 用户头像 -

//保存用户头像
+(NSString *)saveUserAvatar:(UIImage *)image withUserId:(NSString *)userId;

//得到用户头像
+(NSString *)getUserHeadAvatarByUserId:(NSString *)userId isExist:(BOOL *)isExist;



//得到录音文件路径
+(NSString *)getRecordFileByRecordFileId:(NSString *)recordFileId isExist:(BOOL *)isExist;



+(NSString *)saveGoodsAvatar:(UIImage *)image withGoodsId:(NSString *)userId;


+(NSString *)getGoodsHeadAvatarByGoodsId:(NSString *)userId isExist:(BOOL *)isExist;


+(NSString *)saveClothesAvatar:(UIImage *)image withClothesPhotoId:(NSString *)photoId;

+(NSString *)getDetailClothesAvatarByClothesPhotoId:(NSString *)photoId isExist:(BOOL *)isExist;



// 计算图片的实际大小位图大小
#pragma mark - get image size
+ (long)getImageSize:(UIImage *)image;

#pragma mark - get comment image 
+(NSString *)getArtcommentTitleWithTitleIdPicByRoomId:(NSString *)roomId isExist:(BOOL *)isExist;

@end
