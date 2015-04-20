//
//  XCLeftSideTableViewCell.m
//  XCWash
//
//  Created by 吴伟庆 on 15/3/15.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCLeftSideTableViewCell.h"
#import "UIImageView+Avatar.h"

@implementation XCLeftSideTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        if (indexPath.row == 0)
        {
            _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 20, 70, 70)];
            _headImageView.backgroundColor = [UIColor clearColor];
            
            [self.contentView addSubview:_headImageView];
            
            _cellTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _headImageView.frame.origin.y+_headImageView.frame.size.height +10, MAX_LEFT_SIDE_WIDTH, 30)];
            _cellTitleLabel.textAlignment = NSTextAlignmentCenter;
            _cellTitleLabel.font = HEL_16;
            _cellTitleLabel.textColor = [UIColor blackColor];
            [self.contentView addSubview:_cellTitleLabel];
        }
        else
        {
            _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(18, 13, 18, 18)];
            _headImageView.backgroundColor = [UIColor clearColor];
            
            [self.contentView addSubview:_headImageView];
            
            _cellTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_headImageView.frame.origin.x+_headImageView.frame.size.width +10, _headImageView.frame.origin.y, self.frame.size.width, 20)];
            _cellTitleLabel.textAlignment = NSTextAlignmentLeft;
            _cellTitleLabel.font = HEL_16;
            _cellTitleLabel.backgroundColor = [UIColor clearColor];
            _cellTitleLabel.textColor = [UIColor blackColor];
            [self.contentView addSubview:_cellTitleLabel];

        }
    }
    
    return self;
    
}

-(void)setCellContentWithIndexPath:(NSIndexPath *)indexPath imageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray
{
    if (indexPath.row == 0)
    {
        [_headImageView setUserAvatarWithUserId:[XCUserModel shareInstance].userId headUrl:[XCUserModel shareInstance].userPictureUrl withSize:70 update:YES];
        _cellTitleLabel.text = [XCUserModel shareInstance].userName;
        
    }
    else
    {
        UIImage *image = [imageArray objectAtIndex:indexPath.row-1 ];
        NSString *title = [titleArray objectAtIndex:indexPath.row-1 ];
        _headImageView.image = image;
        _cellTitleLabel.text = title;
        
    }
}



- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    
    //上分割线，
    //    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    //    CGContextStrokeRect(context, CGRectMake(space_to_left, -1, rect.size.width -space_to_left, 1));
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xCCCCCC).CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
