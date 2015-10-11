//
//  XCWashPriceTableViewCell.h
//  XCWash
//
//  Created by wuweiqing on 15/4/5.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCGoodsTypeModel.h"


@interface XCWashPriceTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UILabel *otherDescLabel;
@property(nonatomic,strong)UILabel *oldPriceLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

-(void)setCellContentWithWashPriceModel:(XCGoodsModel*)model
;
@end
