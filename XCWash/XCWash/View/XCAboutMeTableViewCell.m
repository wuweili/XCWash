//
//  XCAboutMeTableViewCell.m
//  XCWash
//
//  Created by wuweiqing on 15/3/18.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCAboutMeTableViewCell.h"

@implementation XCAboutMeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    
    //上分割线，
        CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xCCCCCC).CGColor);
        CGContextStrokeRect(context, CGRectMake(0, -1, rect.size.width, 1));
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xCCCCCC).CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
