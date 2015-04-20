//
//  XCScoreTableViewCell.m
//  XCWash
//
//  Created by wuweiqing on 15/3/30.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCScoreTableViewCell.h"

@implementation XCScoreTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 200, 29)];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = HEL_15;
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.backgroundColor= [UIColor clearColor];
        [self.contentView addSubview:_contentLabel];
        
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_contentLabel.frame.origin.x, _contentLabel.frame.origin.y+_contentLabel.frame.size.height, 200, 19)];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = HEL_12;
        _timeLabel.textColor = UIColorFromRGB(0x999999);
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_timeLabel];
        
        _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMainScreenWidth-20- 80, 1, 80, 47)];
        _scoreLabel.font = HEL_18;
        _scoreLabel.textAlignment = NSTextAlignmentRight;
        _scoreLabel.textColor = UIColorFromRGB(0x1190d9);
        _scoreLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_scoreLabel];
        
    }

    return self;
    
}


-(void)setCellContentWithScoreRecordModel:(XCScoreRecordModel *)model
{
    _contentLabel.text = model.scoreRecordContent;
    _timeLabel.text = model.scoreRecordTime;
    _scoreLabel.text = [NSString stringWithFormat:@"+%@",model.scoreRecordScore];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
