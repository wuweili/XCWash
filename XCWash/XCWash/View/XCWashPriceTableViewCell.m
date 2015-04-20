//
//  XCWashPriceTableViewCell.m
//  XCWash
//
//  Created by wuweiqing on 15/4/5.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCWashPriceTableViewCell.h"
#import "UIImageView+Avatar.h"

@implementation XCWashPriceTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 70, 70)];
        
        _headImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_headImageView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+10, CGRectGetMinY(_headImageView.frame), 440/2, 20)];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = HEL_14;
        [self.contentView addSubview:_nameLabel];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+10, CGRectGetMaxY(_nameLabel.frame), 440/2, 30)];
        _priceLabel.textColor = UIColorFromRGB(0xfb3535);
        _priceLabel.font = HEL_18;
        _priceLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_priceLabel];
        
        _otherDescLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+10, CGRectGetMaxY(_priceLabel.frame), 440/2, 20)];
        _otherDescLabel.textColor = UIColorFromRGB(0x7b7b7b);
        _otherDescLabel.font = HEL_12;
        _otherDescLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_otherDescLabel];

    }
    
    return self;
    
}


-(void)setCellContentWithWashPriceModel:(XCGoodsModel*)model
{
    if (model)
    {
        
        [_headImageView setGoodsListGoodsAvatarWithGoodsId:model.g_id headUrl:model.g_img withSize:70 update:NO];
        
        _nameLabel.text = model.g_name;
        
        _priceLabel.text = [NSString stringWithFormat:@"￥ %@",model.g_price];
        _otherDescLabel.text = [NSString stringWithFormat:@"说明：%@",model.g_sm];
        
        
    }
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    
    //上分割线，
//    CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xCCCCCC).CGColor);
//    CGContextStrokeRect(context, CGRectMake(0, -1, rect.size.width, 1));
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xCCCCCC).CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
