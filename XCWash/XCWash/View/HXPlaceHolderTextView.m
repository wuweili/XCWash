//
//  HXPlaceHolderTextView.m
//  BJXH-patient
//
//  Created by wu weili on 14-7-31.
//  Copyright (c) 2014年 archermind. All rights reserved.
//

#import "HXPlaceHolderTextView.h"

@implementation HXPlaceHolderTextView

@synthesize placeholder,placeholderColor,placeHolderLabel;

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setPlaceholder:@""];
        [self setPlaceholderColor:UIColorFromRGB(0x8e8e93)];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        
        
    }
    return self;
}

- (void)textChanged:(NSNotification *)notification

{
    if([[self placeholder] length] == 0)
    {
        return;
    }
    if([[self text] length] == 0)
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    else
    {
        [[self viewWithTag:999] setAlpha:0];
    }
    
}
-(void)setText:(NSString *)text{
    [super setText:text];
    [self textChanged:nil];
}

-(void)drawRect:(CGRect)rect
{
    if( [[self placeholder] length] > 0 )
    {
        if ( placeHolderLabel == nil )
        {
            if(CurrentSystemVersion >=7.0)
            {
                placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(4,8,self.bounds.size.width - 16,0)];
            }
            else
            {
                placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,0,self.bounds.size.width - 16,0)];
            }
            
            placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            placeHolderLabel.numberOfLines = 0;
            
            placeHolderLabel.font = self.font;
            
            placeHolderLabel.backgroundColor = [UIColor clearColor];
            
            placeHolderLabel.textColor = self.placeholderColor;
            
            placeHolderLabel.alpha = 0;
            
            placeHolderLabel.tag = 999;
            
            [self addSubview:placeHolderLabel];
            
        }
        placeHolderLabel.text = self.placeholder;
        
        [placeHolderLabel sizeToFit];
        
        [self sendSubviewToBack:placeHolderLabel];
    }
    if( [NSString isBlankString:[self text]] && [[self placeholder] length] > 0 )
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [super drawRect:rect];
}

-(void)isEmptyWithTip:(NSString *)tipStr
{
    placeHolderLabel.text = tipStr;
    placeHolderLabel.textColor = [UIColor redColor];
}

-(void)isReset
{
    placeHolderLabel.text = self.placeholder;
    placeHolderLabel.textColor = UIColorFromRGB(0x8e8e93);
}

@end
