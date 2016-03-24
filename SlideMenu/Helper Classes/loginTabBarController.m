//
//  loginTabBarController.m
//  SlideMenu
//
//  Created by main on 15/9/29.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "loginTabBarController.h"
#import "SlideNavigationController.h"
#import "LeftMenuViewController.h"

@interface loginTabBarController ()

@end

@implementation loginTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:48/255.0 green:107/255.0 blue:191/255.0 alpha:1.0];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"欢迎登录";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.frame = CGRectMake(0, 0, self.navigationItem.titleView.bounds.size.width, 20);
    self.navigationItem.titleView = titleLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
