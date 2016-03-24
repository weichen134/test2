//
//  HomeViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "HomeViewController.h"
#import "KxMenu.h"
#import "AFHTTPRequestOperationManager.h"
#import "AppDelegate.h"
#import "LeftMenuViewController.h"
#import "SlideNavigationController.h"
#import "loginTabBarController.h"

#import "MJRefresh.h"
@implementation HomeViewController
@synthesize spageNum;
@synthesize cellNum;
@synthesize needLoading;
@synthesize type;
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
    self.automaticallyAdjustsScrollViewInsets = false;
//    if (needLoading == YES) {
//        if (self.statusesArray ==nil) {
//            self.statusesArray = [[NSMutableArray alloc]init];
//        }
//        else{
//            [self.statusesArray removeAllObjects];
//        }
//        [self.homeTableview reloadData];
//        [self daibanData];
//    }else{
//        needLoading = YES;
//    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.spageNum = 1;
    self.statusesArray = [[NSMutableArray alloc]init];
    cellNum = 1;
    self.type = 1;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    self.loginName = [ user objectForKey:@"loginname"];
    
    //右上角齿轮
//    UIButton * setButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    setButton.frame = CGRectMake(0, 0, 24, 24);
//    
//    [setButton setImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
//    [setButton addTarget:self action:@selector(RightSet:) forControlEvents:UIControlEventTouchDown];
//    UIBarButtonItem *setNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:setButton];
//    self.navigationItem.rightBarButtonItem = setNavigationItem;
    
    self.homeTableview.delegate = self;
    self.homeTableview.dataSource = self;
    self.homeTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.homeTableview.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
    //下拉刷新
    [self.homeTableview addHeaderWithTarget:self action:@selector(headerRereshing)];
    //上拉加载
    [self.homeTableview addFooterWithTarget:self action:@selector(footerRereshing)];
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    self.titleLabel.frame = CGRectMake(0, 0, 320, 20);
    self.navigationItem.titleView = self.titleLabel;
    
    [SlideNavigationController sharedInstance].enableSwipeGesture = NO;
    
    [self daibanData];
    
    UIScreenEdgePanGestureRecognizer *leftEdgeGesture =
    [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(slideMenu)];
    leftEdgeGesture.edges = UIRectEdgeLeft;           // 右滑显示
    [self.view addGestureRecognizer:leftEdgeGesture];
}


-(void)slideMenu
{
     [[SlideNavigationController sharedInstance] openMenu:1 withCompletion:nil];
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}


- (void)daibanData
{
    
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",spageNum];
    NSDictionary *dic = @{@"loginname":self.loginName,
                          @"pageNum":pageNumStr,
                          @"pageSize":@"20",
                          };
    
    AFHTTPRequestOperationManager *WillManager = [AFHTTPRequestOperationManager manager];
    NSString *url = @"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=findAllTodo";

    [WillManager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        //NSLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] isEqual:@1]||[[responseObject objectForKey:@"success"] isEqual:@"ture"] || [[responseObject objectForKey:@"success"] isEqual:@0])
        {
//            if (self.type == 1)
//            {
//                [self.statusesArray removeAllObjects];
//            }
            
            
            NSArray *statuses = [responseObject objectForKey:@"content"];
            NSString *total = [responseObject objectForKey:@"total"];
            NSLog(@"-=-=-=-=-==-=%@",total);
//            NSMutableArray *statusModels = [NSMutableArray arrayWithCapacity:statuses.count];
            for (NSDictionary *statusInfo in statuses) {
                
                daibanModel *statusModel = [[daibanModel alloc]initWithDictionary:statusInfo];
                [self.statusesArray addObject:statusModel];
            }
//            self.statusesArray = statusModels;
            cellNum = (int)self.statusesArray.count;
            self.titleLabel.text = [NSString stringWithFormat:@"待办事项(%@)",total];
            [self.homeTableview headerEndRefreshing];

            [self.homeTableview reloadData];
        }else
        {
            self.titleLabel.text = @"待办事项(0)";
            [self shujuyichang];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.titleLabel.text = @"待办事项(0)";
        [self fuwuyichang];
    }];
}

//数据异常处理
- (void)shujuyichang
{
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"" message:@"服务器请求:获取失败" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    [alertview show];
}

//服务器异常处理
- (void)fuwuyichang
{
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"" message:@"服务器异常" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    [alertview show];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (cellNum ==0) {
        return 1;
    }else{
        return self.statusesArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _daibanCell = [tableView dequeueReusableCellWithIdentifier:@"daibanCell"];
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    if (cellNum == 0) {
        cell.textLabel.text = @"无待办事项";
        cell.userInteractionEnabled = NO;
        cell.textAlignment = NSTextAlignmentCenter;
        return cell;
    } else {
        if (self.statusesArray.count > 0)
        {
            [_daibanCell setStatusModel:self.statusesArray[indexPath.row]];
            self.jiezhiDate = _daibanCell.jiezhiDate.text;
        }
    }
    
    return _daibanCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _dModel = [self.statusesArray objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
    detailsController *details = [storyboard instantiateViewControllerWithIdentifier:@"detailsController"];
    details.instanceID = _dModel.instance;
    details.biaotititle = _dModel.title;
    details.subAppname = _dModel.subAppName;
    details.taskName = _dModel.taskName;
    details.taskExpireDate = _dModel.taskExpireDate;
    details.loginName = self.loginName;
    details.jiezhiDate = self.jiezhiDate;
    [self.navigationController pushViewController:details animated:YES];
    [self.homeTableview deselectRowAtIndexPath:[self.homeTableview indexPathForSelectedRow] animated:YES];
  
}



//- (BOOL)isMenuOpen
//{
//    return (self.horizontalLocation == 0) ? NO : YES;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"111");
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = @"删除";
    return str;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0)
//{
//    return YES;
//}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0)
//{
//    return NO;
//}


//UITableView的刷新
- (void)headerRereshing
{
    //清除数据
    if (self.statusesArray ==nil) {
        self.statusesArray = [[NSMutableArray alloc]init];
    } else {
        [self.statusesArray removeAllObjects];
        
        self.spageNum = 1;
    }

    [self daibanData];
    //[self.homeTableview headerEndRefreshing];
}
//上拉加载
- (void)footerRereshing
{

    spageNum += 1;

    [self daibanData];

    [self.homeTableview footerEndRefreshing];
}

//- (void)RightSet:(UIButton *)sender
//{
//    NSArray *menuItems =
//    @[
//      [KxMenuItem menuItem:@"注销"
//                     image:nil
//                    target:self
//                    action:@selector(logoutApplication)],
//      [KxMenuItem menuItem:@"退出"
//                     image:nil
//                    target:self
//                    action:@selector(exitApplication)],
//      [KxMenuItem menuItem:@"取消"
//                     image:nil
//                    target:self
//                    action:NULL],];
//    [KxMenu showMenuInView:self.view fromRect:sender.frame menuItems:menuItems];
//    
//}

- (void)logoutApplication
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSString *isLogin = @"No";
    [[NSNotificationCenter defaultCenter]postNotificationName:@"judgeIsLogin" object:self userInfo:@{@"777":isLogin}];

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
