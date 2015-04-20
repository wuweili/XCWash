//
//  XCUserInfoTableViewCell.h
//  XCWash
//
//  Created by wuweiqing on 15/3/18.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPersonnalNameTextFieldTag        1001


@protocol XCUserInfoTableViewCellDelegate <NSObject>

-(void)messaeSwitchValueChange:(BOOL)isSwitchOn;

@end


@interface XCUserInfoTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *cellTitleLabel;
@property(nonatomic,strong)UILabel *cellContentLabel;
@property(nonatomic,strong)UISwitch *cellSwitch;

@property(nonatomic,strong)UITextField *cellTextField;

@property(nonatomic,strong)NSIndexPath *indexPath;


@property(nonatomic,weak)id<XCUserInfoTableViewCellDelegate>delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath;

-(void)setCellContentWithTitle:(NSString *)title contentText:(NSString *)contentTtext indexPath:(NSIndexPath *)indexPath switchOn:(BOOL)switchOn;

@end
