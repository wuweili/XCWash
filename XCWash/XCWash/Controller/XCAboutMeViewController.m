//
//  XCAboutMeViewController.m
//  XCWash
//
//  Created by 吴伟庆 on 15/3/17.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCAboutMeViewController.h"
#import "XCAboutMeTableViewCell.h"
#import "XCServiceContentViewController.h"
#import "XCCompanyViewController.h"


@interface XCAboutMeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_dataArray;
    
    UITableView *_aboutMeTableView;
    
    UIView *_headView;
    
    UIView *_footView;
}

@end

@implementation XCAboutMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
    [self initData];
    
    [self initHeadView];
    
    [self initFootView];
    
    [self initTableView];
    
    
    
}

-(void)initUI
{
    self.title = @"关于我们";
}

-(void)initData
{
    _dataArray = [NSArray arrayWithObjects:@"服务内容",@"公司介绍", nil];
}

-(void)initHeadView
{
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 308/2)];
    _headView.backgroundColor = [UIColor clearColor];
    
    UIImageView *logoImageView = [[UIImageView alloc]init];
    logoImageView.frame = CGRectMake(kMainScreenWidth/2-122/4, 50/2, 122/2, 122/2);
    logoImageView.image = XCLogo_image;
    
    
    logoImageView.backgroundColor = [UIColor clearColor];
    [_headView addSubview:logoImageView];
    
    NSDictionary* dict = [[NSBundle mainBundle]infoDictionary];
    
    UILabel *versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, logoImageView.frame.origin.y +logoImageView.frame.size.height +15, kMainScreenWidth, 30)];
    
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.textColor = UIColorFromRGB(0x1190d9);
    versionLabel.text = [@"协成洗涤 v" stringByAppendingString:[dict objectForKey:@"CFBundleVersion"]];
    [_headView addSubview:versionLabel];

}

-(void)initFootView
{
    _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 60)];
    
    _footView.backgroundColor = [UIColor clearColor];
    
    
    UILabel *footLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, kMainScreenWidth, 20)];
    
    footLabel.textAlignment = NSTextAlignmentCenter;
    footLabel.textColor = UIColorFromRGB(0x666666);
    footLabel.text = @"客服电话：400-0000-8888";
    [_footView addSubview:footLabel];

}


-(void)initTableView
{
    _aboutMeTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,kMainScreenWidth ,kScreenHeightNoStatusAndNoNaviBarHeight) style:UITableViewStyleGrouped];
    _aboutMeTableView.delegate=self;
    _aboutMeTableView.dataSource=self;
    _aboutMeTableView.showsVerticalScrollIndicator = NO;
    _aboutMeTableView.backgroundColor = [UIColor clearColor];
    _aboutMeTableView.backgroundView = nil;
    _aboutMeTableView.tableHeaderView = _headView;
    _aboutMeTableView.tableFooterView = _footView;
    _aboutMeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_aboutMeTableView];
}

-(void)clickLeftNavMenu
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UITableViewDelegate -

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }
    else
    {
        return 10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.section)
    {
        case 0:
        {
            XCServiceContentViewController *serviceMVC = [[XCServiceContentViewController alloc]init];
            
            [self.navigationController pushViewController:serviceMVC animated:YES];
            
        }
            break;
        case 1:
        {
            XCCompanyViewController *compangMVC = [[XCCompanyViewController alloc]init];
            [self.navigationController pushViewController:compangMVC animated:YES];
            
        }
            break;
            
        default:
            break;
    }
    
    
    
    
    
}

#pragma mark - UITableViewDataSource -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"aboutCell%d",indexPath.row];
    
    XCAboutMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[XCAboutMeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.font = HEL_16;
    
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.section];
    
    return cell;
    
    
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
