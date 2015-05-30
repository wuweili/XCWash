//
//  XCOrderDetailTableViewCell.h
//  XCWash
//
//  Created by wuweiqing on 15/5/30.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCAllClothesView.h"
#import "XCOrderModel.h"

@interface XCOrderDetailTableViewCell : UITableViewCell

@property(nonatomic,strong)UIView *orderView;

@property(nonatomic,strong)UILabel *orderNumberTitleLabel;

@property(nonatomic,strong)UILabel *orderStatusLabel;

@property(nonatomic,strong)UILabel *recieveAddressLabel;

@property(nonatomic,strong)UILabel *sendAddressLabel;

@property(nonatomic,strong)UILabel *applyLabel;

@property(nonatomic,strong)UILabel *xiadanTimeLabel;

@property(nonatomic,strong)UILabel *shangmenTimeLabel;

@property(nonatomic,strong)UILabel *paisongTimeLabel;

@property(nonatomic,strong)UILabel *finshTimeLabel;

@property(nonatomic,strong)XCAllClothesView *allClothesView;

@property(nonatomic,strong)UILabel *totalPriceTitleLabel;

@property(nonatomic,strong)UILabel *totalPriceLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier orderDetailModel:(XCOrderDetailModel *)model;


-(void)setCellContentWithOrderDetailModel:(XCOrderDetailModel *)model;


@end
