//
//  XCMakeOrderTableViewCell.h
//  XCWash
//
//  Created by wuweiqing on 15/4/5.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickDate.h"

#define kOrderTimeTextFieldTag      1000

#define kRecieveTextFieldTag        2000
#define kSendTextFieldTag           2001
#define kSendMessageTextFieldTag           4000

typedef NS_ENUM(NSInteger, MakeOrderMethod)
{
    MakeOrderMethod_normal,
    MakeOrderMethod_yuyin
    
    
};




@protocol XCMakeOrderTableViewCellDelegate <NSObject>

-(void)changeDate:(NSString *)date withCell:(id)cell;
-(void)disMissPickerWithCell:(id)cell;

@end


@interface XCMakeOrderTableViewCell : UITableViewCell<PickDateDelegate>

@property(nonatomic,strong)UIImageView *cellHeadImageView;
@property(nonatomic,strong)UILabel *cellContentLabel;
@property(nonatomic,strong)UITextField *cellTextField;
@property(nonatomic,strong)PickDate *datePicker;
@property(nonatomic,weak)id<XCMakeOrderTableViewCellDelegate>delegate;
@property(nonatomic,strong)NSIndexPath *selfIndexPath;

@property(nonatomic,assign )MakeOrderMethod makeOrderMethod;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath makeOrderMethod:(MakeOrderMethod)makeOrderMethod;


-(void)setcellContentWithIndexPath:(NSIndexPath *)indexPath andContentStr:(NSString *)text makeOrderMethod:(MakeOrderMethod)makeOrderMethod;;


@end
