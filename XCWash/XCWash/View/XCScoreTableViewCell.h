//
//  XCScoreTableViewCell.h
//  XCWash
//
//  Created by wuweiqing on 15/3/30.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCScoreRecordModel.h"

@interface XCScoreTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *scoreLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

-(void)setCellContentWithScoreRecordModel:(XCScoreRecordModel *)model;

@end
