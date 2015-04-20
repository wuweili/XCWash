//
//  XCUserInfoTableViewCell.m
//  XCWash
//
//  Created by wuweiqing on 15/3/18.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCUserInfoTableViewCell.h"

@implementation XCUserInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self)
    {
        
        self.indexPath = indexPath;
        
        _cellTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(32, 0, 80, self.frame.size.height)];
        _cellTitleLabel.textAlignment = NSTextAlignmentLeft;
        _cellTitleLabel.font = HEL_16;
        _cellTitleLabel.backgroundColor = [UIColor clearColor];
        _cellTitleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_cellTitleLabel];
        
        
        if (indexPath.section == 0 )
        {
            
            if (indexPath.row == 0)
            {
                _cellContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.size.width+_cellTitleLabel.frame.origin.x, 0, kMainScreenWidth-15-(_cellTitleLabel.frame.size.width+_cellTitleLabel.frame.origin.x), self.frame.size.height)];
                _cellContentLabel.textAlignment = NSTextAlignmentRight;
                _cellContentLabel.font = HEL_16;
                _cellContentLabel.backgroundColor = [UIColor clearColor];
                _cellContentLabel.textColor = UIColorFromRGB(0x666666);
                self.accessoryView =_cellContentLabel;
            }
            else
            {
                _cellTextField = [[UITextField alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+5, 0, 520/2, 49)];
                _cellTextField.borderStyle = UITextBorderStyleNone;
                _cellTextField.textColor = [UIColor blackColor];
                _cellTextField.textAlignment = NSTextAlignmentRight;
                _cellTextField.adjustsFontSizeToFitWidth = YES;
                _cellTextField.returnKeyType = UIReturnKeyDone;
                _cellTextField.font = HEL_14;
                _cellTextField.backgroundColor = [UIColor clearColor];
                
                _cellTextField.placeholder = @"输入个人昵称";
                _cellTextField.font = HEL_14;
                _cellTextField.tag = kPersonnalNameTextFieldTag;
                self.accessoryView =_cellTextField;
                
            }
            
  
            
            
            
   
        }
        else
        {
            _cellSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 53, 32)];
            _cellSwitch.onTintColor = UIColorFromRGB(0x1190d9);
            _cellSwitch.on = YES;
            [_cellSwitch addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
            
            self.accessoryView =_cellSwitch;
            
           
            
        }
        
        
    }
    
    return self;
    
}

-(void)setCellContentWithTitle:(NSString *)title contentText:(NSString *)contentTtext indexPath:(NSIndexPath *)indexPath switchOn:(BOOL)switchOn
{
    self.indexPath = indexPath;
    
    _cellTitleLabel.text = title;
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        _cellContentLabel.text = contentTtext;
    }
    else if (indexPath.section == 0 && indexPath.row == 1)
    {
        _cellTextField.text = contentTtext;
    }
    else
    {
        if (!switchOn)
        {
            _cellSwitch.on = NO;

        }
        else
        {
            _cellSwitch.on = YES;
        }
    }
}


-(void)switchValueChange:(UISwitch *)paramSender
{
    if ([paramSender isOn])
    {
        DDLogInfo(@"switch is turn on");
    }
    else
    {
        DDLogInfo(@"switch is turn off");
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(messaeSwitchValueChange:)])
    {
        [_delegate messaeSwitchValueChange:paramSender.on];
    }
    
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    
    if (self.indexPath.section == 0)
    {
        if (self.indexPath.row == 0)
        {
            CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xcccccc).CGColor);
            CGContextStrokeRect(context, CGRectMake(32, rect.size.height, rect.size.width-32, 1));
        }
        else
        {
            CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xcccccc).CGColor);
            CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
        }
    }
    else
    {
        CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xcccccc).CGColor);
        CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
    }
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
