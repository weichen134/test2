//
//  MenuViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "UserViewController.h"
#import "TableViewCell.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"
#import "SlideNavigationController.h"
#import "AFHTTPRequestOperationManager.h"
#import "User.h"
#import "AppDelegate.h"
#import "loginTabBarController.h"
@implementation LeftMenuViewController

-(UIButton*)quitBtn
{
    if (!_quitBtn)
    {
        _quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _quitBtn.frame = CGRectMake(130, self.view.frame.size.height - 100,130, 50);
        [_quitBtn setImage:[UIImage imageNamed:@"tuichu_head"] forState:UIControlStateNormal];
        [_quitBtn setTitle:@" 退出" forState:UIControlStateNormal];
        [_quitBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
    }
    return _quitBtn;
}


-(UIButton*)logoutBtn
{
    if (!_logoutBtn)
    {
        _logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _logoutBtn.frame = CGRectMake(0, self.view.frame.size.height - 100,130, 50);
        [_logoutBtn setImage:[UIImage imageNamed:@"zhuxiao_head"] forState:UIControlStateNormal];
        [_logoutBtn setTitle:@" 注销" forState:UIControlStateNormal];
        [_logoutBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
    }
    return _logoutBtn;
}

-(void)quitApplacation
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


-(void)logoutApplacation
{
  
    [[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:NO];
 
    NSString *isLogin = @"No";
    [[NSNotificationCenter defaultCenter]postNotificationName:@"judgeIsLogin" object:self userInfo:@{@"777":isLogin}];
}



#pragma mark - UIViewController Methods -

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.slideOutAnimationEnabled = YES;
    
    return [super initWithCoder:aDecoder];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.zaibanTotal = @"0";
    self.daibanTotal = @"0";
    self.touxiangView.layer.masksToBounds =YES;
    self.touxiangView.layer.cornerRadius = 30;
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:242/255.0 blue:245/255.0 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = false;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    self.imgeStr = [ user objectForKey:@"userImge"];
    self.userName = [ user objectForKey:@"userName"];
    self.emailStr = [ user objectForKey:@"userEmail"];
    self.telePhoneStr = [ user objectForKey:@"userPhone"];
    self.countryStr = [ user objectForKey:@"userCountry"];
    self.cityStr = [ user objectForKey:@"userCity"];
    self.sexStr = [ user objectForKey:@"userSex"];
    self.mobile = [ user objectForKey:@"usermobile"];
    self.loginNameStr = [ user objectForKey:@"loginname"];
    self.userNameLabel.text =[ user objectForKey:@"userName"];
    
    NSLog(@"%@",self.userName);
   // NSString *imagestr = [ user objectForKey:@"userImge"];
    NSLog(@"%@",self.loginNameStr);
    NSURL *imageUrl =[NSURL URLWithString:self.imgeStr];
    NSData * data = [NSData dataWithContentsOfURL:imageUrl];
    UIImageView *touxiangImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.touxiangView.bounds.size.width, self.touxiangView.bounds.size.height)];
    touxiangImage.layer.masksToBounds = YES;
    touxiangImage.layer.cornerRadius = self.touxiangView.bounds.size.width/2;
    touxiangImage.image = [UIImage imageWithData:data];
    [self.touxiangView addSubview:touxiangImage];
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
//    UITapGestureRecognizer *touxiangTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touxiangTouch)];
//    [self.touxiangView addGestureRecognizer:touxiangTap];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"123" object:nil];
    self.tableView.backgroundColor = [UIColor colorWithRed:241/255.0 green:242/255.0 blue:245/255.0 alpha:1.0];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled =NO;
    [self daibanData];
    [self zaibanData];
    [self.view addSubview:self.quitBtn];
    [self.quitBtn addTarget:self action:@selector(quitApplacation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.logoutBtn];
    [self.logoutBtn addTarget:self action:@selector(logoutApplacation) forControlEvents:UIControlEventTouchUpInside];
    
    //注销退出的边框线
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor lightGrayColor];
    line1.frame = CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 1.5);
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor lightGrayColor];
    line2.frame = CGRectMake(0, self.view.frame.size.height - 100 + 50, self.view.frame.size.width, 1.5);
    UIView *line3 = [[UIView alloc]init];
    line3.backgroundColor = [UIColor lightGrayColor];
    line3.frame = CGRectMake(130, self.view.frame.size.height - 100, 1.5, 50);
    [self.view addSubview:line1];
    [self.view addSubview:line2];
    [self.view addSubview:line3];
    
    _quitBtn.frame = CGRectMake(130, self.view.frame.size.height - 100,130, 50);
    //版本信息
    UILabel *label = [UILabel new];
    label.text = @"浙江水利厅移动办公iOS版 v1.1.0";
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, self.view.frame.size.height-25, 260, 30);
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:label];

}

-(void)notice:(NSNotification *)text
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    self.loginNameStr = [user objectForKey:@"loginname"];
    self.userNameLabel.text =[ user objectForKey:@"userName"];
    self.imgeStr = [ user objectForKey:@"userImge"];
    self.zaibanTotal = @"0";
    self.daibanTotal = @"0";
    
    NSURL *imageUrl =[NSURL URLWithString:self.imgeStr];
    NSData * data = [NSData dataWithContentsOfURL:imageUrl];
    UIImageView *touxiangImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.touxiangView.bounds.size.width, self.touxiangView.bounds.size.height)];
    touxiangImage.layer.masksToBounds = YES;
    touxiangImage.layer.cornerRadius = self.touxiangView.bounds.size.width/2;
    touxiangImage.image = [UIImage imageWithData:data];
    [self.touxiangView addSubview:touxiangImage];
    
    [self daibanData];
    [self zaibanData];
    [self.tableView reloadData];
    
}





#pragma mark - UITableView Delegate & Datasrouce -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TableViewCell *Leftcell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
        switch (indexPath.row)
    {
        case 0:
            Leftcell.LeftView.image = [UIImage imageNamed:@"待办"];
            Leftcell.TilleLabel.text = @"待办事项";
            Leftcell.NumLabel.text = [NSString stringWithFormat:@"%@",self.daibanTotal];
            break;
        case 1:
            Leftcell.LeftView.image = [UIImage imageNamed:@"在办"];
            Leftcell.TilleLabel.text = @"在办事项";
            Leftcell.NumLabel.text = [NSString stringWithFormat:@"%@",self.zaibanTotal];
            break;
            
        case 2:
            Leftcell.LeftView.image = [UIImage imageNamed:@"分享"];
            Leftcell.TilleLabel.text = @"分享/收藏";
            Leftcell.NumLabel.hidden = YES;
            break;
    }
    
    Leftcell.backgroundColor = [UIColor clearColor];
    return Leftcell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                             bundle: nil];
    
    UIViewController *vc ;
    switch (indexPath.row)
    {
        case 0:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
            break;
            
        case 1:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"ProfileViewController"];
            break;
            
        case 2:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"ShareViewController"];
            break;
            
    }
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                     andCompletion:nil];
}

//- (BOOL)prefersStatusBarHidden{
//    return YES;
//}

- (void)daibanData
{
    NSDictionary *dic = @{@"loginname":self.loginNameStr,
                          @"pageNum":@0,
                          @"pageSize":@20,
                          };
    
    AFHTTPRequestOperationManager *WillManager = [AFHTTPRequestOperationManager manager];
    NSString *url = @"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=findAllTodo";
    [WillManager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSArray *statuses3 = [responseObject objectForKey:@"content"];
//        _daibanNum = (int)statuses3.count;
        self.daibanTotal = [responseObject objectForKey:@"total"];
        [self.tableView reloadData];        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

- (void)zaibanData
{
    NSDictionary *dic3 = @{@"loginname":self.loginNameStr,
                           @"pageNum":@0,
                           @"pageSize":@20,
                           };

    AFHTTPRequestOperationManager *Manager3 = [AFHTTPRequestOperationManager manager];
    NSString *url3 = @"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=getWorkflowDoingList";
    [Manager3 GET:url3 parameters:dic3 success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSArray *statuses3 = [responseObject objectForKey:@"content"];
//        _zaibanNum = (int)statuses3.count;
        self.zaibanTotal = [responseObject objectForKey:@"total"];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
}

- (void)shareData
{
    NSDictionary *dic4 = @{@"loginname":self.loginNameStr,
                           @"pageNum":@0,
                           @"pageSize":@20,
                           @"fabulanmu":@"{0A10C80C-0000-0000-1A69-233B01111011}",
                           };
    AFHTTPRequestOperationManager *Manager4 = [AFHTTPRequestOperationManager manager];
    NSString *url4 = @"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=gongxiang";
    [Manager4 GET:url4 parameters:dic4 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *statuses3 = [responseObject objectForKey:@"content"];
        _shareNum = (int)statuses3.count;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

//点击头像
- (void)touxiangTouch
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
    UserViewController *userControll = [storyboard instantiateViewControllerWithIdentifier:@"UserViewController"];
//
//    userControll.userName = self.userName;
//    userControll.imgeStr = self.imgeStr;
//    userControll.sexStr = self.sexStr;
//    userControll.telePhoneStr =self.telePhoneStr;
//    userControll.emailStr = self.emailStr;
//    userControll.countryStr = self.countryStr;
//    userControll.cityStr = self.cityStr;
//    userControll.mobile = self.mobile;
    [[SlideNavigationController sharedInstance] pushViewController:userControll animated:NO];

}

@end
