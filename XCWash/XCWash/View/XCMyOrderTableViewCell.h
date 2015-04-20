//
//  XCMyOrderTableViewCell.h
//  XCWash
//
//  Created by wuweiqing on 15/3/19.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCOrderModel.h"

typedef NS_ENUM(NSInteger, MyOrderCellType)
{
    MyOrderCellType_YuYueZhong,
    MyOrderCellType_YiSongXi,
    MyOrderCellType_Finsh
};

@protocol XCMyOrderTableViewCellDelegate <NSObject>

-(void)clickCancleOrderButtonWithOrderModel:(XCOrderModel *)model;

-(void)clickListenYuyinButtonWithOrderModel:(XCOrderModel *)model;

-(void)clickAddCommentButtonWithOrderModel:(XCOrderModel *)model;

@end



@interface XCMyOrderTableViewCell : UITableViewCell

@property(nonatomic,strong)UIView *orderView;
@property(nonatomic,strong)UIButton *cancleOrderButton;
@property(nonatomic,strong)UILabel *orderNumberLabel;


@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIImageView *takeImageView;
@property(nonatomic,strong)UIImageView *sendImageView;
@property(nonatomic,strong)UILabel *takeAddressLabel;
@property(nonatomic,strong)UILabel *sendAddressLabel;
@property(nonatomic,strong)UIButton*listenButton;
@property(nonatomic,strong)UIButton*addCommentButton;

@property(nonatomic,assign)MyOrderCellType myOrderType;

@property(nonatomic,strong)XCOrderModel *model;

@property(nonatomic,weak)id<XCMyOrderTableViewCellDelegate>delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(MyOrderCellType)type;

-(void)setCellContentWithOrderModel:(XCOrderModel *)model cellType:(MyOrderCellType)type;


@end
