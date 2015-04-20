//
//  UIButton+Avatar.m
//  BJXH-patient
//
//  Created by wu weili on 14-5-15.
//  Copyright (c) 2014年 archermind. All rights reserved.
//

#import "UIButton+Avatar.h"
#import "DocumentUtil.h"

#import "UIButton+AFNetworking.h"

#import "Photo.h"
#import "UIImage+IMChat.h"

@implementation UIButton (Avatar)





//用户头像 update yes 表示每次都更新本地头像 no 表示直接从本地取
-(void)setUserAvatarWithUserId:(NSString *)userId headUrl:(NSString *)urlString withSize:(CGFloat)size update:(BOOL)update loadImageFinish:(void (^)(UIImage *))loadImageFinish
{
    
    if (update)
    {
        if ([NSString isBlankString:urlString])
        {
            [self setImage:User_default_headImage forState:UIControlStateNormal];
            if (loadImageFinish)
            {
                loadImageFinish(User_default_headImage);
            }
            
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
            
            __weak __typeof(self)weakSelf = self;
            
            
            [self setImageForState:UIControlStateNormal withURLRequest:request placeholderImage:User_default_headImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                BOOL isExist = NO;
                NSString *iconPath = [DocumentUtil getUserHeadAvatarByUserId:userId isExist:&isExist];
                if (isExist)
                {
                    [Photo unloadImageForKey:iconPath];
                    
                }
                
                UIImage *tmpImage = [image circleImageWithSize:size];
                
                
                if (![NSString isBlankString:userId])
                {
                    [DocumentUtil saveUserAvatar:image withUserId:userId];
                }
                
                [weakSelf setImage:tmpImage forState:UIControlStateNormal];
                
                if (loadImageFinish)
                {
                    loadImageFinish(image);
                }
            } failure:^(NSError *error) {
                [weakSelf setImage:User_default_headImage forState:UIControlStateNormal];
                if (loadImageFinish)
                {
                    loadImageFinish(User_default_headImage);
                }
            }];

        }
    }
    else
    {
        
        BOOL isExist = NO;
        NSString *iconPath = [DocumentUtil getUserHeadAvatarByUserId:userId isExist:&isExist];
        if (isExist)
        {
            UIImage *btnImage = [Photo loadImageThreadSafe:iconPath];
            
            [self setImage:[btnImage circleImageWithSize:size] forState:UIControlStateNormal];
            
            if (loadImageFinish)
            {
                loadImageFinish(btnImage);
            }
            
            return;
            
        }
        else
        {
            if ([NSString isBlankString:urlString])
            {
                [self setImage:User_default_headImage forState:UIControlStateNormal];
                if (loadImageFinish)
                {
                    loadImageFinish(User_default_headImage);
                }
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
                
                __weak __typeof(self)weakSelf = self;
                
                [self setImageForState:UIControlStateNormal withURLRequest:request placeholderImage:User_default_headImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                    UIImage *tmpImage = [image circleImageWithSize:size];
                    
                    if (![NSString isBlankString:userId])
                    {
                        [DocumentUtil saveUserAvatar:image withUserId:userId];                    }
                    
                    [weakSelf setImage:tmpImage forState:UIControlStateNormal];
                    
                    if (loadImageFinish)
                    {
                        loadImageFinish(image);
                    }
                } failure:^(NSError *error) {
                    [weakSelf setImage:User_default_headImage forState:UIControlStateNormal];
                    
                    if (loadImageFinish)
                    {
                        loadImageFinish(User_default_headImage);
                    }
                }];

            }
        }

        
    }

}




@end
