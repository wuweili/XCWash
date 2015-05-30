//
//  XCAllClothesView.m
//  XCWash
//
//  Created by wuweiqing on 15/5/30.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCAllClothesView.h"
#import "XCOrderModel.h"
#import "UIImageView+Avatar.h"


@implementation XCClothesView

-(id)initWithClothesModel:(XCOrderClothesModel *)model frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        if (model)
        {
            XCOrderClothesPhotoModel *photoModel = [[XCOrderClothesPhotoModel alloc]init] ;
            
            if ([model.photos count]>0)
            {
                photoModel = [model.photos firstObject];
            }

            _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 70)];
            
            [_imageView setOrderDetailClothesAvatarWithPhotoId:photoModel.dp_id headUrl:photoModel.dp_imgurl withSize:70 update:YES];
            
            [self addSubview:_imageView];
            
            
            _clothesNameLabel= [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+20, 10, 140, 22)];
            _clothesNameLabel.textColor = [UIColor blackColor];
            
            _clothesNameLabel.textAlignment = NSTextAlignmentLeft;
            _clothesNameLabel.font = HEL_14;
            _clothesNameLabel.text = model.g_name;
            [self addSubview:_clothesNameLabel];
            
            _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+20, CGRectGetMaxY(_clothesNameLabel.frame)+5, 140, 20)];
            _priceLabel.textColor = UIColorFromRGB(0xfc7777);
            _priceLabel.textAlignment = NSTextAlignmentLeft;
            _priceLabel.font = HEL_13;
            _priceLabel.text = model.oa_price;
            [self addSubview:_priceLabel];
            
            _totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width -50, 15, 50, 20)];
            _totalLabel.textColor =UIColorFromRGB(0xfc7777);
            _totalLabel.textAlignment = NSTextAlignmentRight;
            _totalLabel.font = HEL_13;
            _totalLabel.text = @"共一件";
            [self addSubview:_totalLabel];

        }

    }
    
    return self;
}

@end



@implementation XCAllClothesView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithClothesArray:(NSMutableArray *)array 
{
    self = [super init];
    
    if (self)
    {
        [self refreshWithClothesArray:array];
    }
    
    return self;
    
}

-(void)refreshWithClothesArray:(NSMutableArray *)array
{
    for (id view in [self subviews])
    {
        if ([view isKindOfClass:[XCClothesView class]])
        {
            [view removeFromSuperview];
        }
    }
    
    
    if (array && [array count]>0)
    {
        CGRect selfFrame = self.frame;
        
        selfFrame.size.height = [array count]*85;
        
        self.frame = selfFrame;
        
        for (NSInteger i = 0 ; i<[array count]; i++)
        {
            XCOrderClothesModel*clothesModel = [array objectAtIndex:i];
            
            XCClothesView *clothesView = [[XCClothesView alloc]initWithClothesModel:clothesModel frame:CGRectMake(10, 85*i, kMainScreenWidth-20, 85)];
            
            [self addSubview:clothesView];
            
        }

    }
}


@end
