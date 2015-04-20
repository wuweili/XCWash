//
//  XCServiceContentViewController.m
//  XCWash
//
//  Created by wuweiqing on 15/3/18.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCServiceContentViewController.h"

@interface XCServiceContentViewController ()

@end

@implementation XCServiceContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"服务内容";

    
}

-(void)clickLeftNavMenu
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
