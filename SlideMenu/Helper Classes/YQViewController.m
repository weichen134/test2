//
//  YQViewController.m
//  SlideMenu
//
//  Created by main on 15/11/5.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "YQViewController.h"
#import "yqDataModel.h"
#import "yqTableViewCell.h"
#import "AFHTTPRequestOperationManager.h"
#import "fxViewController.h"
#import "MJRefresh.h"

@interface YQViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *arrayContent;
@property (nonatomic,strong) yqDataModel *zsModel;
@property (nonatomic) int spageNum;
@property (nonatomic)BOOL needLoading;
@property (nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong)NSString *total;


@end

@implementation YQViewController
@synthesize zsModel;
@synthesize spageNum;
@synthesize needLoading;
@synthesize cellNum;
@synthesize type;
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
    self.automaticallyAdjustsScrollViewInsets = false;
//    if (needLoading == YES) {
//        if (self.arrayContent ==nil) {
//            self.arrayContent = [[NSMutableArray alloc]init];
//        }else{
//            [self.arrayContent removeAllObjects];
//        }
//        [self.YQTableView reloadData];
//        [self shareDate];
//    }else{
//        needLoading = YES;
//    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    needLoading = NO;
    spageNum = 1;
    cellNum = 1;
    self.type = 1;
    self.total = @"0";
    self.arrayContent = [[NSMutableArray alloc]init];
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(touchPop) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backNavigationItem;
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    self.titleLabel.frame = CGRectMake(0, 0, 320, 20);
    self.navigationItem.titleView = self.titleLabel;
    
    self.YQTableView.delegate =self;
    self.YQTableView.dataSource = self;
    self.YQTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.YQTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
    //下拉刷新
    [self.YQTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //上拉加载
    [self.YQTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    [self shareDate];
    //风火轮
    _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame : CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)] ;
    _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    _activityIndicatorView.layer.cornerRadius = 15;
    _activityIndicatorView.layer.masksToBounds = YES;
    _activityIndicatorView.alpha = 0.7;
    _activityIndicatorView.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0];
    [_activityIndicatorView setCenter: self.view.center] ;
    [self.view addSubview : _activityIndicatorView];
    
    [self.activityIndicatorView startAnimating];
}
- (void)touchPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

//分享／收藏请求数据
- (void)shareDate
{
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",spageNum];
    NSDictionary *dic = @{@"loginname":self.loginName,
                          @"pageNum":pageNumStr,
                          @"pageSize":@"20",
                          @"fabulanmu":@"{0A10C80C-0000-0000-1A69-233B01111011}",
                          };
    
    AFHTTPRequestOperationManager *Manager = [AFHTTPRequestOperationManager manager];
    NSString *url = @"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=gongxiang";
    [Manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"%@",responseObject);
//        if (self.type == 1)
//        {
//            [self.arrayContent removeAllObjects];
//        }
        NSArray *statuses = [responseObject objectForKey:@"content"];
        self.total = [responseObject objectForKey:@"total"];
        //        NSMutableArray *statusModels = [NSMutableArray arrayWithCapacity:statuses.count];
        for (NSDictionary *statusInfo in statuses) {
            //        初始化model
            yqDataModel *statusModel = [[yqDataModel alloc]initWithDictionary:statusInfo];
            [self.arrayContent addObject:statusModel];
        }
        cellNum = (int)self.arrayContent.count;
        [self.YQTableView reloadData];
        [self.YQTableView headerEndRefreshing];
        [self.activityIndicatorView stopAnimating];
        self.titleLabel.text = [NSString stringWithFormat:@"舆情监测(%@)",self.total];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"" message:@"服务器异常" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alertview show];
    }];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (cellNum == 0)
    {
        return 1;
    }else{
        return self.arrayContent.count;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    yqTableViewCell *yqCell = [[yqTableViewCell alloc]init];
    yqCell = [tableView dequeueReusableCellWithIdentifier:@"yqTableViewCell"];
    
    if (0 == cellNum)
    {
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        cell.textLabel.text = @"暂无数据";
        cell.userInteractionEnabled = NO;
        cell.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
    else
    {
        if (self.arrayContent.count >0 )
        {
            [yqCell setStatusModel:self.arrayContent[indexPath.row]];
        }
    }
    return yqCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    zsModel = [self.arrayContent objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    fxViewController *fxVC = [storyboard instantiateViewControllerWithIdentifier:@"fxViewController"];
    fxVC.fiPath = zsModel.filePath;
    fxVC.titleStr = zsModel.biaotiStr;
    fxVC.Value = 1;
    [self.navigationController pushViewController:fxVC animated:YES];
    
    [self.YQTableView deselectRowAtIndexPath:[self.YQTableView indexPathForSelectedRow] animated:YES];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}


//UITableView的刷新
- (void)headerRereshing
{
    //清除数据
    if (self.arrayContent ==nil) {
        self.arrayContent = [[NSMutableArray alloc]init];
    } else {
        [self.arrayContent removeAllObjects];
        self.spageNum = 1;
    }

    [self shareDate];
//    [self.YQTableView headerEndRefreshing];
}
//上拉加载
- (void)footerRereshing
{
//    // 1.添加假数据
//    if (self.arrayContent.count == 20+spageNum*20) {
//        
//    }

    spageNum += 1;
    [self shareDate];
    [self.YQTableView footerEndRefreshing];
}

@end
