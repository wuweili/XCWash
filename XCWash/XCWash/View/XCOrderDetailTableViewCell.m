//
//  XCOrderDetailTableViewCell.m
//  XCWash
//
//  Created by wuweiqing on 15/5/30.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCOrderDetailTableViewCell.h"

@implementation XCOrderDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier orderDetailModel:(XCOrderDetailModel *)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _orderView = [[UIView alloc]init];
        _orderView.backgroundColor = [UIColor whiteColor];
        _orderView.layer.borderWidth = 1.0f;
        _orderView.layer.cornerRadius = 4.0;
        _orderView.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        _orderView.frame = CGRectMake(10, 0, kMainScreenWidth-20, 10+26+15+7*20+85*[model.attrList count]+20+10);
        
        _orderNumberTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 220, 26)];
        _orderNumberTitleLabel.textAlignment = NSTextAlignmentLeft;
        _orderNumberTitleLabel.textColor = [UIColor blackColor];
        _orderNumberTitleLabel.font = HEL_14;
        _orderNumberTitleLabel.text = [NSString stringWithFormat:@"订单号：%@",model.o_no];
        [_orderView addSubview:_orderNumberTitleLabel];
        
        
        _orderStatusLabel = [[UILabel alloc]initWithFrame:CGRectMake(_orderView.frame.size.width - 10-50, 10, 50, 26)];
        
        _orderStatusLabel.textColor = UIColorFromRGB(0XFC7777);
        _orderStatusLabel.textAlignment = NSTextAlignmentRight;
        _orderStatusLabel.font = HEL_14;
    
        NSString *statusStr = @"";
        if ([model.o_status isEqualToString:@"0"])
        {
            statusStr = @"新建";
        }
        else if ([model.o_status isEqualToString:@"10"])
        {
            statusStr = @"已接收";
        }
        else if ([model.o_status isEqualToString:@"20"])
        {
            statusStr = @"待取件";
        }
        else if ([model.o_status isEqualToString:@"30"])
        {
            statusStr = @"已取件";
        }
        else if ([model.o_status isEqualToString:@"32"])
        {
            statusStr = @"洗涤中";
        }
        else if ([model.o_status isEqualToString:@"34"])
        {
            statusStr = @"洗涤完成";
        }
        else if ([model.o_status isEqualToString:@"40"])
        {
            statusStr = @"待派送";
        }
        else if ([model.o_status isEqualToString:@"50"])
        {
            statusStr = @"已完成";
        }
        else if ([model.o_status isEqualToString:@"90"])
        {
            statusStr = @"已取消";
        }
       
        _orderStatusLabel.text = statusStr;
        [_orderView addSubview:_orderStatusLabel];
        
        _recieveAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_orderNumberTitleLabel.frame)+15, _orderView.frame.size.width - 20, 20)];
        _recieveAddressLabel.textColor = UIColorFromRGB(0x666666);
        _recieveAddressLabel.textAlignment = NSTextAlignmentLeft;
        _recieveAddressLabel.font = HEL_12;
        _recieveAddressLabel.text = [NSString stringWithFormat:@"收货地址：%@",model.o_cu_et_add];
        [_orderView addSubview:_recieveAddressLabel];
        
        
        _sendAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_recieveAddressLabel.frame), _orderView.frame.size.width - 20, 20)];
        _sendAddressLabel.textColor = UIColorFromRGB(0x666666);
        _sendAddressLabel.textAlignment = NSTextAlignmentLeft;
        _sendAddressLabel.font = HEL_12;
        _sendAddressLabel.text = [NSString stringWithFormat:@"送货地址：%@",model.o_cu_ets_add];
        [_orderView addSubview:_sendAddressLabel];
        
        
        _applyLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_sendAddressLabel.frame), _orderView.frame.size.width - 20, 20)];
        _applyLabel.textColor = UIColorFromRGB(0x666666);
        _applyLabel.textAlignment = NSTextAlignmentLeft;
        _applyLabel.font = HEL_12;
        _applyLabel.text = [NSString stringWithFormat:@"是否预约：%@",@"否"];
        [_orderView addSubview:_applyLabel];

        _xiadanTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_applyLabel.frame), _orderView.frame.size.width - 20, 20)];
        _xiadanTimeLabel.textColor = UIColorFromRGB(0x666666);
        _xiadanTimeLabel.textAlignment = NSTextAlignmentLeft;
        _xiadanTimeLabel.font = HEL_12;
        _xiadanTimeLabel.text = [NSString stringWithFormat:@"下单时间：%@",model.o_time];
        [_orderView addSubview:_xiadanTimeLabel];

        
        self.shangmenTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_xiadanTimeLabel.frame), _orderView.frame.size.width - 20, 20)];
        self.shangmenTimeLabel.textColor = UIColorFromRGB(0x666666);
        self.shangmenTimeLabel.textAlignment = NSTextAlignmentLeft;
        self.shangmenTimeLabel.font = HEL_12;
        self.shangmenTimeLabel.text = [NSString stringWithFormat:@"上门时间：%@",model.o_at_time];
        [_orderView addSubview:self.shangmenTimeLabel];
        
        
        self.paisongTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.shangmenTimeLabel.frame), _orderView.frame.size.width - 20, 20)];
        self.paisongTimeLabel.textColor = UIColorFromRGB(0x666666);
        self.paisongTimeLabel.textAlignment = NSTextAlignmentLeft;
        self.paisongTimeLabel.font = HEL_12;
        self.paisongTimeLabel.text = [NSString stringWithFormat:@"派送时间："];
        [_orderView addSubview:self.paisongTimeLabel];
        
        
        self.finshTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.paisongTimeLabel.frame), _orderView.frame.size.width - 20, 20)];
        self.finshTimeLabel.textColor = UIColorFromRGB(0x666666);
        self.finshTimeLabel.textAlignment = NSTextAlignmentLeft;
        self.finshTimeLabel.font = HEL_12;
        self.finshTimeLabel.text = [NSString stringWithFormat:@"完成时间：%@",model.o_finish_time];
        [_orderView addSubview:self.finshTimeLabel];
        
        self.allClothesView = [[XCAllClothesView alloc]initWithClothesArray:model.attrList];
        [_orderView addSubview:self.allClothesView];
        
        
        self.totalPriceTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.allClothesView.frame), 50, 20)];
        self.totalPriceTitleLabel.textColor = [UIColor blackColor];
        self.totalPriceTitleLabel.textAlignment = NSTextAlignmentLeft;
        self.totalPriceTitleLabel.font = HEL_12;
        self.totalPriceTitleLabel.text = [NSString stringWithFormat:@"总价"];
        [_orderView addSubview:self.totalPriceTitleLabel];
        
        
        self.totalPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(_orderView.frame.size.width - 10 - 100, CGRectGetMaxY(self.allClothesView.frame), 100, 20)];
        self.totalPriceLabel.textColor = UIColorFromRGB(0xfc7777);
        self.totalPriceLabel.textAlignment = NSTextAlignmentLeft;
        self.totalPriceLabel.font = HEL_12;
        self.totalPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.o_total_price];
        [_orderView addSubview:self.totalPriceLabel];
        
        [self.contentView addSubview:_orderView];
        

    }
    
    return self;
    
    
    
}

-(void)setCellContentWithOrderDetailModel:(XCOrderDetailModel *)model
{
    _orderView.frame = CGRectMake(10, 0, kMainScreenWidth-20, 10+26+15+7*20+85*[model.attrList count]+20+10);
    
    _orderNumberTitleLabel.text = [NSString stringWithFormat:@"订单号：%@",model.o_no];
    
    NSString *statusStr = @"";
    if ([model.o_status isEqualToString:@"0"])
    {
        statusStr = @"新建";
    }
    else if ([model.o_status isEqualToString:@"10"])
    {
        statusStr = @"已接收";
    }
    else if ([model.o_status isEqualToString:@"20"])
    {
        statusStr = @"待取件";
    }
    else if ([model.o_status isEqualToString:@"30"])
    {
        statusStr = @"已取件";
    }
    else if ([model.o_status isEqualToString:@"32"])
    {
        statusStr = @"洗涤中";
    }
    else if ([model.o_status isEqualToString:@"34"])
    {
        statusStr = @"洗涤完成";
    }
    else if ([model.o_status isEqualToString:@"40"])
    {
        statusStr = @"待派送";
    }
    else if ([model.o_status isEqualToString:@"50"])
    {
        statusStr = @"已完成";
    }
    else if ([model.o_status isEqualToString:@"90"])
    {
        statusStr = @"已取消";
    }
    
    _orderStatusLabel.text = statusStr;

    
    _recieveAddressLabel.text = [NSString stringWithFormat:@"收货地址：%@",model.o_cu_et_add];
    
    _sendAddressLabel.text = [NSString stringWithFormat:@"送货地址：%@",model.o_cu_ets_add];
    
    
    _applyLabel.text = [NSString stringWithFormat:@"是否预约：%@",@"否"];
    
    _xiadanTimeLabel.text = [NSString stringWithFormat:@"下单时间：%@",model.o_time];
    
    self.shangmenTimeLabel.text = [NSString stringWithFormat:@"上门时间：%@",model.o_at_time];
    
    self.paisongTimeLabel.text = [NSString stringWithFormat:@"派送时间："];
    
    self.finshTimeLabel.text = [NSString stringWithFormat:@"完成时间：%@",model.o_finish_time];
    
    [self.allClothesView refreshWithClothesArray:model.attrList];
    
    if ([model.attrList count]>0)
    {
        self.totalPriceTitleLabel.frame = CGRectMake(10, CGRectGetMaxY(self.allClothesView.frame), 50, 20);
        
        self.totalPriceLabel.frame =CGRectMake(_orderView.frame.size.width - 10 - 100, CGRectGetMaxY(self.allClothesView.frame), 100, 20);
    }
    else
    {
        self.totalPriceTitleLabel.frame = CGRectMake(10, CGRectGetMaxY(self.finshTimeLabel.frame), 50, 20);
        
        self.totalPriceLabel.frame =CGRectMake(_orderView.frame.size.width - 10 - 100, CGRectGetMaxY(self.finshTimeLabel.frame), 100, 20);
    }
    

    self.totalPriceTitleLabel.text = [NSString stringWithFormat:@"总价"];
    
    if ([NSString isBlankString:model.o_total_price])
    {
        self.totalPriceLabel.text = [NSString stringWithFormat:@"%@",model.o_total_price];
    }
    else
    {
        self.totalPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.o_total_price];
    }
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
