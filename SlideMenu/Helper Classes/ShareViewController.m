//
//  ShareViewController.m
//  SlideMenu
//
//  Created by main on 15/9/17.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "ShareViewController.h"
#import "GwViewController.h"
#import "ZSViewController.h"
#import "YQViewController.h"
#import "XQViewController.h"
#import "KxMenu.h"
#import "AppDelegate.h"
@interface ShareViewController ()
@property (nonatomic,strong)UILabel *titleLabel;
@end

@implementation ShareViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
    self.automaticallyAdjustsScrollViewInsets = false;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    self.loginName = [ user objectForKey:@"loginname"];

//    UIButton * setButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    setButton.frame = CGRectMake(0, 0, 24, 24);
//    [setButton setImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
//    [setButton addTarget:self action:@selector(RightSet:) forControlEvents:UIControlEventTouchDown];
//    UIBarButtonItem *setNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:setButton];
//    self.navigationItem.rightBarButtonItem = setNavigationItem;
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"分享/收藏";
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    self.titleLabel.frame = CGRectMake(0, 0, self.navigationItem.titleView.bounds.size.width, 20);
    self.navigationItem.titleView = self.titleLabel;
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"share_yqtb"]];
    [self.shareView1 addSubview:imageView1];
    UIImageView *imageView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"share_xqtb"]];
    [self.shareView2 addSubview:imageView2];
    UIImageView *imageView3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"share_zstb"]];
    [self.shareView3 addSubview:imageView3];
    UIImageView *imageView4 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"share_fwk"]];
    [self.shareView4 addSubview:imageView4];
    UIImageView *imageView5 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"share_swk"]];
    [self.shareView5 addSubview:imageView5];
    
    //暂时隐藏一事一表
//    self.shareView6.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"一事一表"]];
    
    UITapGestureRecognizer *yqtbTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(yqtbTap)];
    [self.shareView1 addGestureRecognizer:yqtbTap];
    UITapGestureRecognizer *xqtbTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xqtbTap)];
    [self.shareView2 addGestureRecognizer:xqtbTap];
    UITapGestureRecognizer *zstbTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zstbTap)];
    [self.shareView3 addGestureRecognizer:zstbTap];
    UITapGestureRecognizer *gwTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gwTap)];
    [self.shareView4 addGestureRecognizer:gwTap];
    UITapGestureRecognizer *gwTap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gwTap2)];
    [self.shareView5 addGestureRecognizer:gwTap2];
//    UITapGestureRecognizer *gwTap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gwTap3)];
//    [self.shareView6 addGestureRecognizer:gwTap3];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
//    NSNotification * notice = [NSNotification notificationWithName:@"123" object:nil userInfo:@{@"1":self.loginName}];
//    //发送消息
//    [[NSNotificationCenter defaultCenter]postNotification:notice];
    return YES;
}

-(void)yqtbTap
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    YQViewController *yqVC = [storyboard instantiateViewControllerWithIdentifier:@"YQViewController"];
    yqVC.loginName = self.loginName;
    [self.navigationController pushViewController:yqVC animated:YES];
    
}
-(void)xqtbTap
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    XQViewController *xqVC = [storyboard instantiateViewControllerWithIdentifier:@"XQViewController"];
    xqVC.loginName = self.loginName;
    [self.navigationController pushViewController:xqVC animated:YES];
    
}
-(void)zstbTap
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    ZSViewController *zsVC = [storyboard instantiateViewControllerWithIdentifier:@"ZSViewController"];
    zsVC.loginName = self.loginName;
    [self.navigationController pushViewController:zsVC animated:YES];
}
-(void)gwTap
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    GwViewController *gwVC = [storyboard instantiateViewControllerWithIdentifier:@"GwViewController"];
    gwVC.appnameStr = @"fawen";
    gwVC.loginName = self.loginName;
    [self.navigationController pushViewController:gwVC animated:YES];
}
-(void)gwTap2
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    GwViewController *gwVC = [storyboard instantiateViewControllerWithIdentifier:@"GwViewController"];
    gwVC.appnameStr = @"shouwen";
    gwVC.loginName = self.loginName;
    [self.navigationController pushViewController:gwVC animated:YES];
}
-(void)gwTap3
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    GwViewController *gwVC = [storyboard instantiateViewControllerWithIdentifier:@"GwViewController"];
    gwVC.appnameStr = @"一事一表";
    gwVC.loginName = self.loginName;
    [self.navigationController pushViewController:gwVC animated:YES];
}



- (void)RightSet:(UIButton *)sender
{
    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"注销"
                     image:nil
                    target:self
                    action:@selector(logoutApplication)],
      [KxMenuItem menuItem:@"退出"
                     image:nil
                    target:self
                    action:@selector(exitApplication)],
      [KxMenuItem menuItem:@"取消"
                     image:nil
                    target:self
                    action:NULL],];
    [KxMenu showMenuInView:self.view fromRect:sender.frame menuItems:menuItems];
    
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
