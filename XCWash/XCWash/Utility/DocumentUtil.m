//
//  DocumentUtil.m
//  BJXH-patient
//
//  Created by wu weili on 14-5-5.
//  Copyright (c) 2014年 archermind. All rights reserved.
//

#import "DocumentUtil.h"
//#import "Photo.h"
#import "DateFormate.h"
#import "IMUnitsMethods.h"
#import "HXOther.h"

@implementation DocumentUtil

+ (NSString *)pathForFolder:(NSString *)folderName docName:(NSString *)docName
{
    NSString *userPath = [IMUnitsMethods userFilePath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *folderPath = [userPath stringByAppendingPathComponent:folderName];
    BOOL isFolder = NO;
    if ([fileManager fileExistsAtPath:folderPath isDirectory:&isFolder])
    {
        if (!isFolder)
        {
            return nil;
        }
    }
    else
    {
        [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return [folderPath stringByAppendingPathComponent:docName];
}


//create imageName
+ (NSString *)createDocNameWithExtension:(NSString *)extension {

    NSString *prefix = [DateFormate GetCurrentTime:kDEFAULT_DATE_TIME_FORMAT];
    
    return [NSString stringWithFormat:@"%@_%06d.%@",prefix,rand()%1000000,extension];
}



//创建形象照片 wuweili
+ (NSString *)createDocNameWithExtension:(NSString *)extension withPhotoId:(NSString *)photoId {
    
    return [NSString stringWithFormat:@"%@.%@",photoId,extension];
}



//image transform
+ (CGAffineTransform)transformForOrientation:(UIImageOrientation)imageOrientation newSize:(CGSize)newSize {
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (imageOrientation) {
        case UIImageOrientationDown:           // EXIF = 3
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:           // EXIF = 6
        case UIImageOrientationLeftMirrored:   // EXIF = 5
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:          // EXIF = 8
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (imageOrientation) {
        case UIImageOrientationUpMirrored:     // EXIF = 2
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:   // EXIF = 5
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    return transform;
}

+ (UIImage *)fixImage:(UIImage *)image newSize:(CGSize)newSize {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGRect transposedRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width);
    CGImageRef imageRef = image.CGImage;
    
    // Build a context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(imageRef),
                                                0,
                                                CGImageGetColorSpace(imageRef),
                                                CGImageGetBitmapInfo(imageRef));
    
    CGAffineTransform transform = [DocumentUtil transformForOrientation:image.imageOrientation newSize:newSize];
    
    // Rotate and/or flip the image if required by its orientation
    CGContextConcatCTM(bitmap, transform);
    
    // Set the quality level to use when rescaling
    //CGContextSetInterpolationQuality(bitmap, quality);
    
    BOOL transpose;
    
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transpose = YES;
            break;
        default:
            transpose = NO;
    }
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return newImage;
}

+ (NSData *)fixImage:(UIImage *)image compressionLimite:(CGFloat)cl resizeLimite:(CGFloat)rl {
    CGSize size = image.size;
    CGFloat rate = size.width/size.height;
    CGFloat m = rate > 1 ? size.width : size.height;
    BOOL shouldResize = NO;
    if (m > rl) {
        if (rate > 1) {
            size.width = rl;
            size.height = rl/rate;
        }
        else {
            size.width = rl*rate;
            size.height = rl;
        }
        shouldResize = YES;
        //image = [Photo scaleImage:image toWidth:size.width toHeight:size.height];
    }
    if (image.imageOrientation != UIImageOrientationUp || shouldResize) {
        image = [DocumentUtil fixImage:image newSize:size];
    }
    CGFloat quality = m > cl ? COMPRESSION_QUALITY : 1.0;
    NSData *imgData = UIImageJPEGRepresentation(image, quality);
    
//    NSData *imgData = UIImagePNGRepresentation(image);
    
    
    return imgData;
}

+ (void)saveImage:(UIImage *)image compressionLimite:(CGFloat)cl resizeLimite:(CGFloat)rl savePath:(NSString *)savePath
{
    NSData *imgData = [DocumentUtil fixImage:image compressionLimite:cl resizeLimite:rl];
    [imgData writeToFile:savePath atomically:YES];
}


//获取 folderName  文件夹下所有的图片 path
+(NSMutableArray *)getBigDynamicImagePath:(NSString*)folderName
{
    NSMutableArray *allImagePath = [[NSMutableArray alloc]init];
    
    NSString *stringPath = [NSString stringWithFormat:@"%@",folderName];
    //设置用户保存的文件夹
    NSString *userPath = [IMUnitsMethods userFilePath];
    
    NSString *folderPath = [userPath stringByAppendingPathComponent:stringPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
//    NSArray *files = [fileManager subpathsOfDirectoryAtPath:folderPath error:nil];
    
    NSArray *files = [fileManager subpathsAtPath:folderPath ];
    
    for (int i = 0; i< [files count]; i++)
    {
        NSString *imagePath = [files objectAtIndex:i];
        NSString *allPath = [NSString stringWithFormat:@"%@%@%@",folderPath,@"/",imagePath];
        [allImagePath addObject:allPath];
    }
    
    return allImagePath;
}






#pragma mark - 用户头像 -

+(NSString *)pathForUserHeadAvatar:(NSString *)docName userId:(NSString *)userId
{
    NSString *stringPath = [NSString stringWithFormat:@"%@/%@",HEAD_AVATAR,FOLDER_PATIENT_AVATAR];
    
    return [DocumentUtil pathForFolder:stringPath docName:docName];
    
}

+ (NSString *)createDocNameWithExtension:(NSString *)extension withUserId:(NSString *)userId
{
    
    return [NSString stringWithFormat:@"%@.%@",userId,extension];
}

//保存患者头像
+(NSString *)saveUserAvatar:(UIImage *)image withUserId:(NSString *)userId
{
    NSString *filename = [DocumentUtil createDocNameWithExtension:@"jpeg"  withUserId:userId];
    NSString *filepath = [DocumentUtil pathForUserHeadAvatar:filename userId:userId];
    [DocumentUtil saveImage:image
          compressionLimite:THUMBNAIL_COMPRESS_LIMIT
               resizeLimite:THUMBNAIL_RESIZE_LIMIT
                   savePath:filepath];
    return filepath;
}

//得到用户头像
+(NSString *)getUserHeadAvatarByUserId:(NSString *)userId isExist:(BOOL *)isExist
{
    NSString *filename = [DocumentUtil createDocNameWithExtension:@"jpeg" withUserId:userId];
    
    NSString *stringPath = [NSString stringWithFormat:@"%@/%@",HEAD_AVATAR,FOLDER_PATIENT_AVATAR];
    
    NSString *userPath = [IMUnitsMethods userFilePath];
    NSString *folderPath = [userPath stringByAppendingPathComponent:stringPath];
    NSString *fliePath = [folderPath stringByAppendingPathComponent:filename];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (isExist) {
        *isExist = [fileManager fileExistsAtPath:fliePath];
    }
    return fliePath;
}


#pragma mark - 衣物图片 -


+(NSString *)pathForGoodsHeadAvatar:(NSString *)docName goodsId:(NSString *)userId
{
    NSString *stringPath = [NSString stringWithFormat:@"%@",WASH_GOODS_FILE];
    
    return [DocumentUtil pathForFolder:stringPath docName:docName];
    
}

+ (NSString *)createDocNameWithExtension:(NSString *)extension withGoodsId:(NSString *)userId
{
    
    return [NSString stringWithFormat:@"%@.%@",userId,extension];
}

//保存患者头像
+(NSString *)saveGoodsAvatar:(UIImage *)image withGoodsId:(NSString *)userId
{
    NSString *filename = [DocumentUtil createDocNameWithExtension:@"jpeg"  withGoodsId:userId];
    NSString *filepath = [DocumentUtil pathForGoodsHeadAvatar:filename goodsId:userId];
    [DocumentUtil saveImage:image
          compressionLimite:THUMBNAIL_COMPRESS_LIMIT
               resizeLimite:THUMBNAIL_RESIZE_LIMIT
                   savePath:filepath];
    return filepath;
}

//
+(NSString *)getGoodsHeadAvatarByGoodsId:(NSString *)userId isExist:(BOOL *)isExist
{
    NSString *filename = [DocumentUtil createDocNameWithExtension:@"jpeg" withGoodsId:userId];
    
    NSString *stringPath = [NSString stringWithFormat:@"%@",WASH_GOODS_FILE];
    
    NSString *userPath = [IMUnitsMethods userFilePath];
    NSString *folderPath = [userPath stringByAppendingPathComponent:stringPath];
    NSString *fliePath = [folderPath stringByAppendingPathComponent:filename];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (isExist) {
        *isExist = [fileManager fileExistsAtPath:fliePath];
    }
    return fliePath;
}

#pragma mark - 录音文件 -

+(NSString *)pathForRecordFile:(NSString *)docName userId:(NSString *)userId
{
    NSString *stringPath = [NSString stringWithFormat:@"%@",RECORD_FILE];
    
    return [DocumentUtil pathForFolder:stringPath docName:docName];
    
}

+ (NSString *)createDocNameWithExtension:(NSString *)extension withrecordFileId:(NSString *)userId
{
    
    return [NSString stringWithFormat:@"%@.%@",userId,extension];
}

//保
//+(NSString *)saveRecordFile:(UIImage *)image withUserId:(NSString *)userId
//{
//    NSString *filename = [DocumentUtil createDocNameWithExtension:@"jpeg"  withUserId:userId];
//    NSString *filepath = [DocumentUtil pathForUserHeadAvatar:filename userId:userId];
//    [DocumentUtil saveImage:image
//          compressionLimite:THUMBNAIL_COMPRESS_LIMIT
//               resizeLimite:THUMBNAIL_RESIZE_LIMIT
//                   savePath:filepath];
//    return filepath;
//}

//得到录音文件路径
+(NSString *)getRecordFileByRecordFileId:(NSString *)recordFileId isExist:(BOOL *)isExist
{
    NSString *filename = [DocumentUtil createDocNameWithExtension:@"aac" withrecordFileId:recordFileId];
    
    NSString *stringPath = [NSString stringWithFormat:@"%@",RECORD_FILE];
    
    NSString *userPath = [IMUnitsMethods userFilePath];
    NSString *folderPath = [userPath stringByAppendingPathComponent:stringPath];
    NSString *fliePath = [folderPath stringByAppendingPathComponent:filename];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (isExist) {
        *isExist = [fileManager fileExistsAtPath:fliePath];
    }
    return fliePath;
}


// 计算图片的实际大小位图大小
#pragma mark - get image size
+ (long)getImageSize:(UIImage *)image
{
    
    int  perMBBytes = 1024*1024;
    
    CGImageRef cgimage = image.CGImage;
    size_t bpp = CGImageGetBitsPerPixel(cgimage);
    size_t bpc = CGImageGetBitsPerComponent(cgimage);
    size_t bytes_per_pixel = bpp / bpc;
    
    long lPixelsPerMB  = perMBBytes/bytes_per_pixel;
    
    
    long totalPixel = CGImageGetWidth(image.CGImage)*CGImageGetHeight(image.CGImage);
    
    
    long totalFileMB = totalPixel/lPixelsPerMB;
    
    return totalFileMB;
    
}


@end
