//
//  UserViewController.m
//  SlideMenu
//
//  Created by main on 15/10/15.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "UserViewController.h"
#import "userCell.h"
#import "AppDelegate.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *titleL = [[UILabel alloc]init];
    titleL.textColor = [UIColor whiteColor];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.font = [UIFont boldSystemFontOfSize:17];
    titleL.text = @"个人中心";
    titleL.frame = CGRectMake(0, 0, 320, 20);
    self.navigationItem.titleView = titleL;
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backRoot) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backNavigationItem;
    
    self.userTableView.delegate = self;
    self.userTableView.dataSource = self;
    self.userTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.userTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
    
}

- (void)backRoot{
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    UIViewController *v3 = [viewcontrollers objectAtIndex:1];
    [self.navigationController popToViewController:v3 animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    @property (nonatomic,strong)NSString *userName;
    //    @property (nonatomic,strong)NSString *imgeStr;
    //    @property (nonatomic,strong)NSString *sexStr;
    //    @property (nonatomic,strong)NSString *telePhoneStr;
    //    @property (nonatomic,strong)NSString *emailStr;
    //    @property (nonatomic,strong)NSString *countryStr;
    //    @property (nonatomic,strong)NSString *cityStr;
     userCell *cell = (userCell *)[tableView dequeueReusableCellWithIdentifier:@"userCell"];
    switch (indexPath.row)
    {
        case 0:
            cell.biaotiLabel.text = @"所在城市";
            cell.titleLabel.text = self.cityStr;
            break;
        case 1:
            cell.biaotiLabel.text = @"性别";
            if([self.sexStr isEqual:@"1"] ){
                cell.titleLabel.text = @"男";
            }else{
                cell.titleLabel.text = @"女";
            }
            break;
        case 2:
            cell.biaotiLabel.text = @"个人电话";
            cell.titleLabel.text = self.mobile;
            break;
        case 3:
            cell.biaotiLabel.text = @"办公电话";
            cell.titleLabel.text = self.telePhoneStr;
            break;
        case 4:
            cell.biaotiLabel.text = @"电子邮箱";
            cell.titleLabel.text = self.emailStr;
            break;
        case 5:
            cell.biaotiLabel.text = @"注销账号";
            cell.biaotiLabel.textColor = [UIColor blackColor];
            cell.titleLabel.hidden =YES;
            break;
        case 6:
            cell.biaotiLabel.text = @"退出账号";
            cell.biaotiLabel.textColor = [UIColor blackColor];
            cell.titleLabel.hidden =YES;
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 5:
            [self logoutApplication];
            break;
        case 6:
            [self exitApplication];
            break;
    }
    
    [self.userTableView deselectRowAtIndexPath:[self.userTableView indexPathForSelectedRow] animated:NO];
}

- (void)logoutApplication
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)exitApplication
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
}
@end
