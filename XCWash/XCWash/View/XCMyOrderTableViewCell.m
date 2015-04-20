//
//  XCMyOrderTableViewCell.m
//  XCWash
//
//  Created by wuweiqing on 15/3/19.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCMyOrderTableViewCell.h"

@implementation XCMyOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(MyOrderCellType)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        if (type == MyOrderCellType_YuYueZhong)
        {
            _orderView = [[UIView alloc]init];
            _orderView.backgroundColor = [UIColor whiteColor];
            _orderView.layer.borderWidth = 1.0f;
            _orderView.layer.cornerRadius = 4.0;
            _orderView.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
            _orderView.frame = CGRectMake(10, 0, kMainScreenWidth-20, 179);
            
            _cancleOrderButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 7, 60, 30)];
            _cancleOrderButton.backgroundColor = [UIColor whiteColor];
            [_cancleOrderButton setTitle:@"取消订单" forState:UIControlStateNormal];
            _cancleOrderButton.titleLabel.font = HEL_14;
            [_cancleOrderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_cancleOrderButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            [_cancleOrderButton addTarget:self action:@selector(clickCancleButton) forControlEvents:UIControlEventTouchUpInside];
            [_orderView addSubview:_cancleOrderButton];
            
            _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMainScreenWidth - 10 - 10 -10- 130, _cancleOrderButton.frame.origin.y, 130, 30)];
            _timeLabel.textColor = UIColorFromRGB(0x666666);
            _timeLabel.textAlignment = NSTextAlignmentRight;
            _timeLabel.font = HEL_14;
            _timeLabel.backgroundColor = [UIColor clearColor];
            [_orderView addSubview:_timeLabel];
            
            UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 44, _orderView.frame.size.width, 1)];
            line1.backgroundColor = UIColorFromRGB(0xcccccc);
            [_orderView addSubview:line1];
            
            _takeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, line1.frame.origin.y +line1.frame.size.height +12, 17, 22)];
            _takeImageView.image = Take_image;
            [_orderView addSubview:_takeImageView];
            
            _takeAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(_takeImageView.frame.origin.x +_takeImageView.frame.size.width +5, line1.frame.origin.y +line1.frame.size.height, _orderView.frame.size.width - 10 - _takeImageView.frame.origin.x - _takeImageView.frame.size.width - 5, 44)];
            _takeAddressLabel.numberOfLines = 0;
            _takeAddressLabel.font = HEL_16;
            _takeAddressLabel.backgroundColor = [UIColor clearColor];
            _takeAddressLabel.textAlignment = NSTextAlignmentLeft;
            _takeAddressLabel.textColor = UIColorFromRGB(0x666666);
            [_orderView addSubview:_takeAddressLabel];
            
            UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(23, _takeAddressLabel.frame.origin.y + _takeAddressLabel.frame.size.height, _orderView.frame.size.width - 23, 1)];
            line2.backgroundColor = UIColorFromRGB(0xcccccc);
            [_orderView addSubview:line2];
            
            _sendImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, line2.frame.origin.y +line2.frame.size.height +12, 17, 22)];
            _sendImageView.image = Send_image;
            [_orderView addSubview:_sendImageView];
            
            _sendAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(_sendImageView.frame.origin.x +_sendImageView.frame.size.width +5, line2.frame.origin.y +line2.frame.size.height, _orderView.frame.size.width - 10 - _sendImageView.frame.origin.x - _sendImageView.frame.size.width - 5, 44)];
            _sendAddressLabel.numberOfLines = 0;
            _sendAddressLabel.font = HEL_16;
            _sendAddressLabel.backgroundColor = [UIColor clearColor];
            _sendAddressLabel.textAlignment = NSTextAlignmentLeft;
            _sendAddressLabel.textColor = UIColorFromRGB(0x666666);
            [_orderView addSubview:_sendAddressLabel];
            
            UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, _sendAddressLabel.frame.origin.y + _sendAddressLabel.frame.size.height, _orderView.frame.size.width , 1)];
            line3.backgroundColor = UIColorFromRGB(0xcccccc);
            [_orderView addSubview:line3];
            
            _listenButton = [[UIButton alloc]initWithFrame:CGRectMake(10, line3.frame.origin.y+line3.frame.size.height+11, 134, 23)];
            [_listenButton setImage:Listen_image forState:UIControlStateNormal];
            [_listenButton addTarget:self action:@selector(clickListenButton:) forControlEvents:UIControlEventTouchUpInside];
            [_orderView addSubview:_listenButton];
            
            
            [self.contentView addSubview:_orderView];
  
        }
        else if (type == MyOrderCellType_YiSongXi)
        {
            _orderView = [[UIView alloc]init];
            _orderView.backgroundColor = [UIColor whiteColor];
            _orderView.layer.borderWidth = 1.0f;
            _orderView.layer.cornerRadius = 4.0;
            _orderView.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
            _orderView.frame = CGRectMake(10, 0, kMainScreenWidth-20, 179);
            
            
            
            _orderNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 150, 30)];
            _orderNumberLabel.textColor = [UIColor blackColor];
            _orderNumberLabel.font = HEL_14;
            _orderNumberLabel.textAlignment = NSTextAlignmentLeft;
            _orderNumberLabel.backgroundColor = [UIColor clearColor];
            [_orderView addSubview:_orderNumberLabel];
            
            _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMainScreenWidth - 10 - 10 -10- 130, _orderNumberLabel.frame.origin.y, 130, 30)];
            _timeLabel.textColor = UIColorFromRGB(0x666666);
            _timeLabel.textAlignment = NSTextAlignmentRight;
            _timeLabel.font = HEL_14;
            _timeLabel.backgroundColor = [UIColor clearColor];
            [_orderView addSubview:_timeLabel];
            
            UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 44, _orderView.frame.size.width, 1)];
            line1.backgroundColor = UIColorFromRGB(0xcccccc);
            [_orderView addSubview:line1];
            
            _takeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, line1.frame.origin.y +line1.frame.size.height +12, 17, 22)];
            _takeImageView.image = Take_image;
            [_orderView addSubview:_takeImageView];
            
            _takeAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(_takeImageView.frame.origin.x +_takeImageView.frame.size.width +5, line1.frame.origin.y +line1.frame.size.height, _orderView.frame.size.width - 10 - _takeImageView.frame.origin.x - _takeImageView.frame.size.width - 5, 44)];
            _takeAddressLabel.numberOfLines = 0;
            _takeAddressLabel.font = HEL_16;
            _takeAddressLabel.backgroundColor = [UIColor clearColor];
            _takeAddressLabel.textAlignment = NSTextAlignmentLeft;
            _takeAddressLabel.textColor = UIColorFromRGB(0x666666);
            [_orderView addSubview:_takeAddressLabel];
            
            UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(23, _takeAddressLabel.frame.origin.y + _takeAddressLabel.frame.size.height, _orderView.frame.size.width - 23, 1)];
            line2.backgroundColor = UIColorFromRGB(0xcccccc);
            [_orderView addSubview:line2];
            
            _sendImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, line2.frame.origin.y +line2.frame.size.height +12, 17, 22)];
            _sendImageView.image = Send_image;
            [_orderView addSubview:_sendImageView];
            
            _sendAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(_sendImageView.frame.origin.x +_sendImageView.frame.size.width +5, line2.frame.origin.y +line2.frame.size.height, _orderView.frame.size.width - 10 - _sendImageView.frame.origin.x - _sendImageView.frame.size.width - 5, 44)];
            _sendAddressLabel.numberOfLines = 0;
            _sendAddressLabel.font = HEL_16;
            _sendAddressLabel.backgroundColor = [UIColor clearColor];
            _sendAddressLabel.textAlignment = NSTextAlignmentLeft;
            _sendAddressLabel.textColor = UIColorFromRGB(0x666666);
            [_orderView addSubview:_sendAddressLabel];
            
            UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, _sendAddressLabel.frame.origin.y + _sendAddressLabel.frame.size.height, _orderView.frame.size.width , 1)];
            line3.backgroundColor = UIColorFromRGB(0xcccccc);
            [_orderView addSubview:line3];
            
            _listenButton = [[UIButton alloc]initWithFrame:CGRectMake(10, line3.frame.origin.y+line3.frame.size.height+11, 134, 23)];
            [_listenButton setImage:Listen_image forState:UIControlStateNormal];
            [_listenButton addTarget:self action:@selector(clickListenButton:) forControlEvents:UIControlEventTouchUpInside];
            [_orderView addSubview:_listenButton];
            
            
            [self.contentView addSubview:_orderView];
        }
        else
        {
            _orderView = [[UIView alloc]init];
            _orderView.backgroundColor = [UIColor whiteColor];
            _orderView.layer.borderWidth = 1.0f;
            _orderView.layer.cornerRadius = 4.0;
            _orderView.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
            _orderView.frame = CGRectMake(10, 0, kMainScreenWidth-20, 179);
            
            _orderNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 150, 30)];
            _orderNumberLabel.textColor = [UIColor blackColor];
            _orderNumberLabel.font = HEL_14;
            _orderNumberLabel.textAlignment = NSTextAlignmentLeft;
            _orderNumberLabel.backgroundColor = [UIColor clearColor];
            [_orderView addSubview:_orderNumberLabel];

            
            _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMainScreenWidth - 10 - 10 -10- 130, _orderNumberLabel.frame.origin.y, 130, 30)];
            _timeLabel.textColor = UIColorFromRGB(0x666666);
            _timeLabel.textAlignment = NSTextAlignmentRight;
            _timeLabel.font = HEL_14;
            _timeLabel.backgroundColor = [UIColor clearColor];
            [_orderView addSubview:_timeLabel];
            
            UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 44, _orderView.frame.size.width, 1)];
            line1.backgroundColor = UIColorFromRGB(0xcccccc);
            [_orderView addSubview:line1];
            
            _takeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, line1.frame.origin.y +line1.frame.size.height +12, 17, 22)];
            _takeImageView.image = Take_image;
            [_orderView addSubview:_takeImageView];
            
            _takeAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(_takeImageView.frame.origin.x +_takeImageView.frame.size.width +5, line1.frame.origin.y +line1.frame.size.height, _orderView.frame.size.width - 10 - _takeImageView.frame.origin.x - _takeImageView.frame.size.width - 5, 44)];
            _takeAddressLabel.numberOfLines = 0;
            _takeAddressLabel.font = HEL_16;
            _takeAddressLabel.backgroundColor = [UIColor clearColor];
            _takeAddressLabel.textAlignment = NSTextAlignmentLeft;
            _takeAddressLabel.textColor = UIColorFromRGB(0x666666);
            [_orderView addSubview:_takeAddressLabel];
            
            UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(23, _takeAddressLabel.frame.origin.y + _takeAddressLabel.frame.size.height, _orderView.frame.size.width - 23, 1)];
            line2.backgroundColor = UIColorFromRGB(0xcccccc);
            [_orderView addSubview:line2];
            
            _sendImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, line2.frame.origin.y +line2.frame.size.height +12, 17, 22)];
            _sendImageView.image = Send_image;
            [_orderView addSubview:_sendImageView];
            
            _sendAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(_sendImageView.frame.origin.x +_sendImageView.frame.size.width +5, line2.frame.origin.y +line2.frame.size.height, _orderView.frame.size.width - 10 - _sendImageView.frame.origin.x - _sendImageView.frame.size.width - 5, 44)];
            _sendAddressLabel.numberOfLines = 0;
            _sendAddressLabel.font = HEL_16;
            _sendAddressLabel.backgroundColor = [UIColor clearColor];
            _sendAddressLabel.textAlignment = NSTextAlignmentLeft;
            _sendAddressLabel.textColor = UIColorFromRGB(0x666666);
            [_orderView addSubview:_sendAddressLabel];
            
            UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, _sendAddressLabel.frame.origin.y + _sendAddressLabel.frame.size.height, _orderView.frame.size.width , 1)];
            line3.backgroundColor = UIColorFromRGB(0xcccccc);
            [_orderView addSubview:line3];
            
            _listenButton = [[UIButton alloc]initWithFrame:CGRectMake(10, line3.frame.origin.y+line3.frame.size.height+11, 134, 23)];
            [_listenButton setImage:Listen_image forState:UIControlStateNormal];
            [_listenButton addTarget:self action:@selector(clickListenButton:) forControlEvents:UIControlEventTouchUpInside];
            [_orderView addSubview:_listenButton];
            
            _addCommentButton = [[UIButton alloc]initWithFrame:CGRectMake(_listenButton.frame.origin.x + _listenButton.frame.size.width +11, line3.frame.origin.y+line3.frame.size.height+11, 134, 23)];
            [_addCommentButton setImage:Add_comment_image forState:UIControlStateNormal];
            [_addCommentButton addTarget:self action:@selector(clickAddCommentButton) forControlEvents:UIControlEventTouchUpInside];
            [_orderView addSubview:_addCommentButton];
            [self.contentView addSubview:_orderView];
        }
        
    }
    
    return self;
    
    
}

-(void)setCellContentWithOrderModel:(XCOrderModel *)model cellType:(MyOrderCellType)type
{
    self.model = model;
    
    if (type == MyOrderCellType_YuYueZhong)
    {
        _timeLabel.text = model.orderTime;
        _takeAddressLabel.text = model.takeAddress;
        _sendAddressLabel.text = model.sendAddress;
        
        
    }
    else if (type == MyOrderCellType_YiSongXi)
    {
        _orderNumberLabel.text = [NSString stringWithFormat:@"订单号:%@",model.orderNumber];
        _timeLabel.text = model.orderTime;
        _takeAddressLabel.text = model.takeAddress;
        _sendAddressLabel.text = model.sendAddress;
    }
    else
    {
        _orderNumberLabel.text = [NSString stringWithFormat:@"订单号:%@",model.orderNumber];
        _timeLabel.text = model.orderTime;
        _takeAddressLabel.text = model.takeAddress;
        _sendAddressLabel.text = model.sendAddress;
    }
}




-(void)clickCancleButton
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickCancleOrderButtonWithOrderModel:)]) {
        [_delegate clickCancleOrderButtonWithOrderModel:self.model];
    }
}

-(void)clickListenButton:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickListenYuyinButtonWithOrderModel:)]) {
        [_delegate clickListenYuyinButtonWithOrderModel:self.model];
    }
}

-(void)clickAddCommentButton
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickAddCommentButtonWithOrderModel:)])
    {
        [_delegate clickAddCommentButtonWithOrderModel:self.model];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
