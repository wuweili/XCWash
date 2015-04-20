//
//  XCMessageCenterTableViewCell.h
//  XCWash
//
//  Created by wuweiqing on 15/3/29.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCMessageModel.h"

@interface XCMessageCenterTableViewCell : UITableViewCell

@property(nonatomic,strong)UIView *messageView;
@property(nonatomic,strong)UILabel *messageLabel;
@property(nonatomic,strong)UILabel *timeLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

-(void)setCellContentWithMessageModel:(XCMessageModel *)model;

+(CGFloat)heightForCellWithMessageModel:(XCMessageModel *)model;

@end
