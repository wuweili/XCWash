//
//  XCMessageCenterTableViewCell.m
//  XCWash
//
//  Created by wuweiqing on 15/3/29.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCMessageCenterTableViewCell.h"

@implementation XCMessageCenterTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _messageView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, kMainScreenWidth-20, 40)];
        _messageView.backgroundColor = [UIColor whiteColor];
        _messageView.layer.borderWidth = 1.0f;
        _messageView.layer.cornerRadius = 4.0;
        _messageView.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        [self.contentView addSubview:_messageView];
        
        
        
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, _messageView.frame.size.width-20, 20)];
        
        _messageLabel.numberOfLines=0;
        _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _messageLabel.backgroundColor = [UIColor clearColor];
        
        _messageLabel.font = HEL_14;
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        _messageLabel.textColor = [UIColor blackColor];
        [_messageView addSubview:_messageLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _messageView.frame.origin.y+_messageView.frame.size.height, kMainScreenWidth-20, 20)];
        
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = HEL_11;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = UIColorFromRGB(0xa4a4a4);
        [self.contentView addSubview:_timeLabel];

    }
    
    return self;
    
    
}

-(void)setCellContentWithMessageModel:(XCMessageModel *)model
{
    _messageLabel.text = model.m_content;
    
    [self heightForUILabel:_messageLabel];
    
    _messageView.frame = CGRectMake(10, 0, kMainScreenWidth-20, _messageLabel.frame.size.height +20);
    
    _timeLabel.text = model.lr_sj;
    
    _timeLabel.frame = CGRectMake(10, _messageView.frame.origin.y+_messageView.frame.size.height, kMainScreenWidth-20, 20);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - uilabel 高度改变
- (CGFloat)heightForUILabel:(UILabel *)label
{
    CGSize constraint = CGSizeMake(label.frame.size.width , CGFLOAT_MAX);
    CGSize size = [label.text sizeWithFont: label.font constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    float fHeight = size.height;
    
    if (fHeight <20)
    {
        fHeight = 20;
    }
    
    CGRect labelFrame = label.frame;
    labelFrame.size.height  = fHeight;
    label.frame = labelFrame;
    
    return fHeight;

}

+(CGFloat)heightForCellWithMessageModel:(XCMessageModel *)model
{
    CGSize constraint = CGSizeMake(kMainScreenWidth-20-20 , CGFLOAT_MAX);
    CGSize size = [model.m_content sizeWithFont:HEL_14 constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    float fHeight = size.height;
    
    if (fHeight <20)
    {
        fHeight = 20;
    }
    
    return fHeight+20+20 ;
    
    
    
}


@end
