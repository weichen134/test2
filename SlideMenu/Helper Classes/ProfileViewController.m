//
//  ProfileViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "ProfileViewController.h"
#import "KxMenu.h"
#import "AppDelegate.h"
#import "AFHTTPRequestOperationManager.h"

#import "MJRefresh.h"
@implementation ProfileViewController
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
//        else
//        {
//            [self.statusesArray removeAllObjects];
//        }
//        [self.zaibanTableview reloadData];
//        [self zaibanData];
//    }else{
//        needLoading = YES;
//    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.statusesArray = [[NSMutableArray alloc]init];
    cellNum = 1 ;
    self.spageNum = 0;
    self.type = 1;
    needLoading = NO;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    self.loginName = [user objectForKey:@"loginname"];
    
//
//    //右上角齿轮
//    UIButton * setButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    setButton.frame = CGRectMake(0, 0, 24, 24);
//    [setButton setImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
//    [setButton addTarget:self action:@selector(RightSet:) forControlEvents:UIControlEventTouchDown];
//    UIBarButtonItem *setNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:setButton];
//    self.navigationItem.rightBarButtonItem = setNavigationItem;
    
    self.zaibanTableview.delegate = self;
    self.zaibanTableview.dataSource = self;
    self.zaibanTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.zaibanTableview.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
    //下拉刷新
    [self.zaibanTableview addHeaderWithTarget:self action:@selector(headerRereshing)];
    //上拉加载
    [self.zaibanTableview addFooterWithTarget:self action:@selector(footerRereshing)];
    
    
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    self.titleLabel.frame = CGRectMake(0, 0, 320, 20);
    self.navigationItem.titleView = self.titleLabel;
    
    [self zaibanData];
    
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
//    NSNotification * notice = [NSNotification notificationWithName:@"123" object:nil userInfo:@{@"1":self.loginName}];
//    //发送消息
//    [[NSNotificationCenter defaultCenter]postNotification:notice];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"123" object:nil];
    return YES;
}
//-(void)passTrendValues:(NSString *)loginStr{
//    self.loginName = loginStr;
//}
- (void)zaibanData
{

    //NSLog(@"11111111111%@",self.statusesArray);
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    self.loginName = [user objectForKey:@"loginname"];
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",spageNum];
    NSDictionary *dic = @{@"loginname":self.loginName,
                          @"pageNum":pageNumStr,
                          @"pageSize":@"20",
                          };
    
    AFHTTPRequestOperationManager *WillManager = [AFHTTPRequestOperationManager manager];
    NSString *url = @"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=getWorkflowDoingList";
    [WillManager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject)
    {

        if ([[responseObject objectForKey:@"success"] isEqual:@1]||[[responseObject objectForKey:@"success"] isEqual:@"ture"])
        {

            
            NSArray *statuses = [responseObject objectForKey:@"content"];
            NSString *total = [responseObject objectForKey:@"total"];
//            NSMutableArray *statusModels = [NSMutableArray arrayWithCapacity:statuses.count];
            for (NSDictionary *statusInfo in statuses) {
                
                zaibanModel *statusModel = [[zaibanModel alloc]initWithDictionary:statusInfo];
                [self.statusesArray addObject:statusModel];
                
                
            }
//            self.statusesArray = statusModels;
            cellNum = (int)self.statusesArray.count;
            self.titleLabel.text = [NSString stringWithFormat:@"在办事项(%@)",total];

            [self.zaibanTableview reloadData];
            [self.zaibanTableview headerEndRefreshing];
        }else{
            self.titleLabel.text = @"在办事项(0)";
            [self shujuyichang];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.titleLabel.text = @"在办事项(0)";
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
    if (cellNum == 0)
    {
        return 1;
    }else{
        return self.statusesArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _zaibanCell = [tableView dequeueReusableCellWithIdentifier:@"zaibanCell"];
    if (cellNum == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        cell.textLabel.text = @"无在办事项";
        cell.userInteractionEnabled = NO;
        cell.textAlignment = NSTextAlignmentCenter;
        return cell;
    } else {
        if (self.statusesArray.count > 0) {
            [_zaibanCell setStatusModel:self.statusesArray[indexPath.row]];
        }
    }
    return _zaibanCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    _zModel = [self.statusesArray objectAtIndex:indexPath.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    zDetailsViewController *zDetails = [storyboard instantiateViewControllerWithIdentifier:@"zDetailsViewController"];
    zDetails.instanceID = _zModel.instance;
    zDetails.biaotititle = _zModel.title;
    zDetails.subAppname = _zModel.subAppName;
    zDetails.taskName = _zModel.taskName;
    zDetails.loginName = self.loginName;
    zDetails.jiezhiDate = self.jiezhiDate;
    [self.navigationController pushViewController:zDetails animated:YES];
    
    [self.zaibanTableview deselectRowAtIndexPath:[self.zaibanTableview indexPathForSelectedRow] animated:YES];
}

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


//UITableView的刷新
- (void)headerRereshing
{
    if (self.statusesArray == nil) {
        self.statusesArray = [[NSMutableArray alloc]init];
    }else{
        [self.statusesArray removeAllObjects];
        self.spageNum = 0;
    }

    
    [self zaibanData];
//    [self.zaibanTableview headerEndRefreshing];
}
//上拉加载
- (void)footerRereshing
{
    // 1.添加假数据
//    if (self.statusesArray.count == 20+spageNum*0) {
//        
//    }
    spageNum += 1;

    [self zaibanData];
    [self.zaibanTableview footerEndRefreshing];
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
