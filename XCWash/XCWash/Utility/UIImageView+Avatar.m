//
//  UIImageView+Avatar.m
//  BJXH-patient
//
//  Created by wu weili on 14-5-15.
//  Copyright (c) 2014年 archermind. All rights reserved.
//

#import "UIImageView+Avatar.h"
#import "DocumentUtil.h"
#import "UIImageView+AFNetworking.h"
#import "Photo.h"
#import "UIImage+IMChat.h"

@implementation UIImageView (Avatar)


//设置用户头像

-(void)setUserAvatarWithUserId:(NSString *)userId headUrl:(NSString *)urlString withSize:(CGFloat)size update:(BOOL)update
{
    __weak UIImageView *tempImgView = self;
    
    if (update)
    {
        if ([NSString isBlankString:urlString])
        {
            self.image = User_default_headImage;
            return;
        }
        else
        {
            
            NSString *imageThumbUrl = [NSString stringWithFormat:@"%@%@",API_UserImageUrl,urlString];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:imageThumbUrl]];
            [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
            [self setImageWithURLRequest:request placeholderImage:User_default_headImage
                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
             {
                 
                 BOOL isExist = NO;
                 NSString *iconPath = [DocumentUtil getUserHeadAvatarByUserId:userId isExist:&isExist];
                 if (isExist)
                 {
                     [Photo unloadImageForKey:iconPath];
                     
                 }
                 
                 
                 UIImage *tmpImage = [image circleImageWithSize:size];
                 
                 [tempImgView setImage:tmpImage];
                 
                 
                 if (![NSString isBlankString:userId])
                 {
                     [DocumentUtil saveUserAvatar:image withUserId:userId];                 }
                 
             } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
             {
                 [tempImgView setImage:User_default_headImage];
             }];
        }
    }
    else
    {
        BOOL isExist = NO;
        NSString *iconPath = [DocumentUtil getUserHeadAvatarByUserId:userId isExist:&isExist];
        if (isExist)
        {
            self.image = [[Photo loadImageThreadSafe:iconPath] circleImageWithSize:size];
        }
        else
        {
            if ([NSString isBlankString:urlString])
            {
                self.image = User_default_headImage;
                return;
            }
            else
            {
                
                NSRange range = [urlString rangeOfString:API_UserImageUrl];
                NSString *imageThumbUrl = [NSString stringWithFormat:@"%@%@",API_UserImageUrl,urlString];
                if (range.location != NSNotFound) {
                    imageThumbUrl = urlString;
                }
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:imageThumbUrl]];
                [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];

                [self setImageWithURLRequest:request placeholderImage:User_default_headImage
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
                 {
                     
                     UIImage *tmpImage = [image circleImageWithSize:size];
                     
                     [tempImgView setImage:tmpImage];
                     
                     
                     if (![NSString isBlankString:userId])
                     {
                         [DocumentUtil saveUserAvatar:image withUserId:userId];
                     }
                     
                 } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
                 {
                     [tempImgView setImage:User_default_headImage];
                 }];
            }
        }
    }

}


-(void)setGoodsListGoodsAvatarWithGoodsId:(NSString *)goodsId headUrl:(NSString *)urlString withSize:(CGFloat)size update:(BOOL)update
{
    __weak UIImageView *tempImgView = self;
    
    if (update)
    {
        if ([NSString isBlankString:urlString])
        {
            self.image = User_default_headImage;
            return;
        }
        else
        {
            
            NSString *imageThumbUrl = [NSString stringWithFormat:@"%@%@",API_Download_goods_img,urlString];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:imageThumbUrl]];
            [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
            [self setImageWithURLRequest:request placeholderImage:User_default_headImage
                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
             {
                 
                 BOOL isExist = NO;
                 NSString *iconPath = [DocumentUtil getGoodsHeadAvatarByGoodsId:goodsId isExist:&isExist];
                 if (isExist)
                 {
                     [Photo unloadImageForKey:iconPath];
                     
                 }
                 
                 
//                 UIImage *tmpImage = [image circleImageWithSize:size];
                 
                 [tempImgView setImage:image];
                 
                 
                 if (![NSString isBlankString:goodsId])
                 {
                     [DocumentUtil saveGoodsAvatar:image withGoodsId:goodsId];                 }
                 
             } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
             {
                 [tempImgView setImage:User_default_headImage];
             }];
        }
    }
    else
    {
        BOOL isExist = NO;
        NSString *iconPath = [DocumentUtil getGoodsHeadAvatarByGoodsId:goodsId isExist:&isExist];;
        if (isExist)
        {
            self.image = [Photo loadImageThreadSafe:iconPath];
        }
        else
        {
            if ([NSString isBlankString:urlString])
            {
                self.image = User_default_headImage;
                return;
            }
            else
            {
                
                NSRange range = [urlString rangeOfString:API_Download_goods_img];
                NSString *imageThumbUrl = [NSString stringWithFormat:@"%@%@",API_Download_goods_img,urlString];
                if (range.location != NSNotFound) {
                    imageThumbUrl = urlString;
                }
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:imageThumbUrl]];
                [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
                
                [self setImageWithURLRequest:request placeholderImage:User_default_headImage
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
                 {
                     
//                     UIImage *tmpImage = [image circleImageWithSize:size];
                     
                     [tempImgView setImage:image];
                     
                     
                     if (![NSString isBlankString:goodsId])
                     {
                         [DocumentUtil saveGoodsAvatar:image withGoodsId:goodsId];                 
                     }
                     
                 } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
                 {
                     [tempImgView setImage:User_default_headImage];
                 }];
            }
        }
    }

}










CGContextRef createBitmapContext(int pixelsWide, int pixelsHigh) {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create the bitmap context
    CGContextRef bitmapContext = CGBitmapContextCreate (NULL, pixelsWide, pixelsHigh, 8,
                                                        0, colorSpace,
                                                        // this will give us an optimal BGRA format for the device:
                                                        (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    CGColorSpaceRelease(colorSpace);
    
    return bitmapContext;
}

CGImageRef createGradientImage(int pixelsWide, int pixelsHigh) {
    CGImageRef theCGImage = NULL;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    CGContextRef gradientBitmapContext = CGBitmapContextCreate(NULL, pixelsWide, pixelsHigh,
                                                               8, 0, colorSpace, kCGImageAlphaNone);
    
    CGFloat colors[] = {0.0, 1.0, 1.0, 1.0};
    
    CGGradientRef grayScaleGradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
    CGColorSpaceRelease(colorSpace);
    
    CGPoint gradientStartPoint = CGPointZero;
    CGPoint gradientEndPoint = CGPointMake(0, pixelsHigh);
    
    CGContextDrawLinearGradient(gradientBitmapContext, grayScaleGradient, gradientStartPoint,
                                gradientEndPoint, kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(grayScaleGradient);
    
    theCGImage = CGBitmapContextCreateImage(gradientBitmapContext);
    CGContextRelease(gradientBitmapContext);
    
    return theCGImage;
}

+ (UIImage *)reflectedImage:(UIImageView *)fromImage withHeight:(NSUInteger)height {
    if (height == 0)
        return nil;
    
    // create a bitmap graphics context the size of the image
    CGContextRef mainViewContentContext = createBitmapContext(fromImage.bounds.size.width, height);
    
    CGImageRef gradientMaskImage = createGradientImage(1, height);
    
    CGContextClipToMask(mainViewContentContext, CGRectMake(0.0, 0.0, fromImage.bounds.size.width, height), gradientMaskImage);
    CGImageRelease(gradientMaskImage);
    
    CGContextTranslateCTM(mainViewContentContext, 0.0, height);
    CGContextScaleCTM(mainViewContentContext, 1.0, -1.0);
    
    CGContextDrawImage(mainViewContentContext, fromImage.bounds, fromImage.image.CGImage);
    
    CGImageRef reflectionImage = CGBitmapContextCreateImage(mainViewContentContext);
    CGContextRelease(mainViewContentContext);
    
    UIImage *theImage = [UIImage imageWithCGImage:reflectionImage];
    
    CGImageRelease(reflectionImage);
    
    return theImage;
}

 

 
@end
