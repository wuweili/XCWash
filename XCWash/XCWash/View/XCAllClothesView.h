//
//  XCAllClothesView.h
//  XCWash
//
//  Created by wuweiqing on 15/5/30.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCOrderModel.h"


@interface XCClothesView : UIView

@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,strong)UILabel *clothesNameLabel;

@property(nonatomic,strong)UILabel *priceLabel;

@property(nonatomic,strong)UILabel *totalLabel;


-(id)initWithClothesModel:(XCOrderClothesModel*)model;



@end


@interface XCAllClothesView : UIView

-(id)initWithClothesArray:(NSMutableArray *)array;
-(void)refreshWithClothesArray:(NSMutableArray *)array ;

@end
