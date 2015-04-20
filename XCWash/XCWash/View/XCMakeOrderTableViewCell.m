//
//  XCMakeOrderTableViewCell.m
//  XCWash
//
//  Created by wuweiqing on 15/4/5.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCMakeOrderTableViewCell.h"

@implementation XCMakeOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath makeOrderMethod:(MakeOrderMethod)makeOrderMethod;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    
    if (self)
    {
        _selfIndexPath = indexPath;

        self.makeOrderMethod = makeOrderMethod;
        
        if (makeOrderMethod == MakeOrderMethod_yuyin)
        {
            _cellHeadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 16, 17, 22)];
            _cellHeadImageView.backgroundColor = [UIColor clearColor];
            [self.contentView addSubview:_cellHeadImageView];
            
            _cellTextField = [[UITextField alloc]initWithFrame:CGRectMake(_cellHeadImageView.frame.origin.x+_cellHeadImageView.frame.size.width+5, 0, 520/2, 49)];
            _cellTextField.borderStyle = UITextBorderStyleNone;
            _cellTextField.textColor = [UIColor blackColor];
            _cellTextField.textAlignment = NSTextAlignmentLeft;
            _cellTextField.adjustsFontSizeToFitWidth = YES;
            _cellTextField.returnKeyType = UIReturnKeyDone;
            _cellTextField.font = HEL_14;
            _cellTextField.backgroundColor = [UIColor clearColor];
            
            if (indexPath.row == 0)
            {
                _cellHeadImageView.image = XC_Make_order_recieve_image;
                _cellTextField.placeholder = @"取件地址";
                _cellTextField.font = HEL_14;
                _cellTextField.tag = kRecieveTextFieldTag;
                
                
            }
            else
            {
                _cellHeadImageView.image = XC_Make_order_send_image;
                _cellTextField.placeholder = @"洗好后送回哪里";
                _cellTextField.font = HEL_14;
                _cellTextField.tag = kSendTextFieldTag;
                
                
            }
            
            [self.contentView addSubview:_cellTextField];

        }
        else
        {
            if (indexPath.section == 2)
            {
                _cellContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,49)];
                _cellContentLabel.numberOfLines = 0;
                _cellContentLabel.font = HEL_14;
                _cellContentLabel.backgroundColor = [UIColor clearColor];
                _cellContentLabel.textAlignment = NSTextAlignmentCenter;
                if (indexPath.row == 0)
                {
                    _cellContentLabel.textColor = [UIColor blackColor];
                }
                else
                {
                    _cellContentLabel.textColor = UIColorFromRGB(0x666666);
                    
                }
                
                [self.contentView addSubview:_cellContentLabel];
                
                
                
            }
            else if (indexPath.section == 0)
            {
                _cellHeadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 16, 17, 17)];
                _cellHeadImageView.image = XC_order_time_image;
                _cellHeadImageView.backgroundColor = [UIColor clearColor];
                [self.contentView addSubview:_cellHeadImageView];
                
                _cellTextField = [[UITextField alloc]initWithFrame:CGRectMake(_cellHeadImageView.frame.origin.x+_cellHeadImageView.frame.size.width+5, 0, 520/2, 49)];
                _cellTextField.borderStyle = UITextBorderStyleNone;
                _cellTextField.textColor = [UIColor blackColor];
                _cellTextField.textAlignment = NSTextAlignmentLeft;
                _cellTextField.adjustsFontSizeToFitWidth = YES;
                _cellTextField.returnKeyType = UIReturnKeyDone;
                _cellTextField.placeholder = @"上门取件时间";
                _cellTextField.font = HEL_14;
                //_cellTextField.delegate = self;
                _cellTextField.enabled = YES;
                _cellTextField.tag = kOrderTimeTextFieldTag;
                _cellTextField.backgroundColor = [UIColor clearColor];
                
                _datePicker = [[PickDate alloc] initWithFrame:CGRectMake(0, self.frame.size.height, 320, 216+44)];
                _datePicker.delegate = self;
                
                _cellTextField.inputView = _datePicker;
                [self.contentView addSubview:_cellTextField];
                
                
            }
            else if (indexPath.section == 1)
            {
                _cellHeadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 16, 17, 22)];
                _cellHeadImageView.backgroundColor = [UIColor clearColor];
                [self.contentView addSubview:_cellHeadImageView];
                
                _cellTextField = [[UITextField alloc]initWithFrame:CGRectMake(_cellHeadImageView.frame.origin.x+_cellHeadImageView.frame.size.width+5, 0, 520/2, 49)];
                _cellTextField.borderStyle = UITextBorderStyleNone;
                _cellTextField.textColor = [UIColor blackColor];
                _cellTextField.textAlignment = NSTextAlignmentLeft;
                _cellTextField.adjustsFontSizeToFitWidth = YES;
                _cellTextField.returnKeyType = UIReturnKeyDone;
                _cellTextField.font = HEL_14;
                _cellTextField.backgroundColor = [UIColor clearColor];
                
                if (indexPath.row == 0)
                {
                    _cellHeadImageView.image = XC_Make_order_recieve_image;
                    _cellTextField.placeholder = @"取件地址";
                    _cellTextField.font = HEL_14;
                    _cellTextField.tag = kRecieveTextFieldTag;
                    
                    
                }
                else
                {
                    _cellHeadImageView.image = XC_Make_order_send_image;
                    _cellTextField.placeholder = @"洗好后送回哪里";
                    _cellTextField.font = HEL_14;
                    _cellTextField.tag = kSendTextFieldTag;
                    
                    
                }
                
                [self.contentView addSubview:_cellTextField];
                
                
                
                
            }
            else
            {
                _cellHeadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 16, 18, 17)];
                _cellHeadImageView.image = XC_seng_message_tip_image;
                _cellHeadImageView.backgroundColor = [UIColor clearColor];
                [self.contentView addSubview:_cellHeadImageView];
                
                _cellTextField = [[UITextField alloc]initWithFrame:CGRectMake(_cellHeadImageView.frame.origin.x+_cellHeadImageView.frame.size.width+5, 0, 520/2,49)];
                _cellTextField.borderStyle = UITextBorderStyleNone;
                _cellTextField.textColor = [UIColor blackColor];
                _cellTextField.textAlignment = NSTextAlignmentLeft;
                _cellTextField.adjustsFontSizeToFitWidth = YES;
                _cellTextField.returnKeyType = UIReturnKeyDone;
                _cellTextField.backgroundColor = [UIColor clearColor];
                _cellTextField.placeholder = @"给金牌服务员的话";
                _cellTextField.font = HEL_14;
                _cellTextField.tag = kSendMessageTextFieldTag;
                [self.contentView addSubview:_cellTextField];
            }
        }
        
        
    }
    
    return self;
}

-(void)setcellContentWithIndexPath:(NSIndexPath *)indexPath andContentStr:(NSString *)text makeOrderMethod:(MakeOrderMethod)makeOrderMethod;
{
    _selfIndexPath = indexPath;
    
    self.makeOrderMethod = makeOrderMethod;
    
    if (makeOrderMethod == MakeOrderMethod_yuyin)
    {
        _cellTextField.text = text;

    }
    else
    {
        if (indexPath.section == 2)
        {
            _cellContentLabel.text = text;
        }
        else
        {
            _cellTextField.text = text;
        }
    }
    
    
}


#pragma mark -- PickDateDelegate - 

-(void)changeDate:(NSString *)date
{
    if (_delegate && [_delegate respondsToSelector:@selector(changeDate:withCell:)]) {
        [_delegate changeDate:date withCell:self];
    }
}

-(void)dissmissPicker
{
    if (_delegate && [_delegate respondsToSelector:@selector(disMissPickerWithCell:)]) {
        
        [_delegate disMissPickerWithCell:self];
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    if (self.makeOrderMethod == MakeOrderMethod_yuyin)
    {
        if (_selfIndexPath.row == 0)
        {
            //下分割线
            CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xcccccc).CGColor);
            CGContextStrokeRect(context, CGRectMake(32, rect.size.height, rect.size.width-32, 1));
        }
        else
        {
            //下分割线
            CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xcccccc).CGColor);
            CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
        }

    }
    else
    {
        if (_selfIndexPath.section == 0)
        {
            //下分割线
            CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xcccccc).CGColor);
            CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
        }
        else if (_selfIndexPath.section == 1)
        {
            //上分割线
            //        CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0x9e9e9e).CGColor);
            //        CGContextStrokeRect(context, CGRectMake(15, 2, rect.size.width-15, 0.5));
            if (_selfIndexPath.row == 0)
            {
                //下分割线
                CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xcccccc).CGColor);
                CGContextStrokeRect(context, CGRectMake(32, rect.size.height, rect.size.width-32, 1));
            }
            else
            {
                //下分割线
                CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xcccccc).CGColor);
                CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
            }
            
            
            
            
            
        }
        else if (_selfIndexPath.section == 2)
        {
            if (_selfIndexPath.row == 0)
            {
                //下分割线
                CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xcccccc).CGColor);
                CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
            }
            else
            {
                //下分割线
                CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xcccccc).CGColor);
                CGContextStrokeRect(context, CGRectMake(13, rect.size.height, rect.size.width-26, 1));
            }
            
        }
        else
        {
            //下分割线
            CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xcccccc).CGColor);
            CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
        }

    }
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
