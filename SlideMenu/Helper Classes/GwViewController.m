//
//  GwViewController.m
//  SlideMenu
//
//  Created by main on 15/9/24.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "GwViewController.h"
#import "fxViewController.h"
#import "gwDataModel.h"
#import "gwTableViewCell.h"
#import "ysybTableViewCell.h"
#import "GDataXMLNode.h"
#import "AFHTTPRequestOperationManager.h"
#import "SearchViewController.h"

#import "MJRefresh.h"

//#define HOST_URL @"http://gwjh.zjwater.gov.cn/yddldapi/library"
@interface GwViewController ()
@property(nonatomic,strong) NSMutableData *soapData;
@property (nonatomic,strong) NSMutableArray *arrayContent;
@property (nonatomic,strong)gwDataModel *gwModel;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic) int spageNum;
@property (nonatomic)BOOL needLoading;
@property(nonatomic,strong)NSString *total;
@end

@implementation GwViewController
@synthesize gwModel;
@synthesize soapData;
@synthesize spageNum;
@synthesize needLoading;
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
//        [self.gwTableview reloadData];
//        [self getDocument];
//    }else{
//        needLoading = YES;
//    }
//    
//    [self.activityIndicatorView startAnimating];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.total = @"0";
    self.spageNum = 1;
    self.type = 1;
    self.arrayContent = [[NSMutableArray alloc] init];
    needLoading = NO;
    self.gwTableview.delegate = self;
    self.gwTableview.dataSource = self;
    self.gwTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.gwTableview.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
    
    if ([self.appnameStr isEqual:@"一事一表"])
    {
        self.wenhLabel.text = @"处室收发";
    }
    
    //下拉刷新
    [self.gwTableview addHeaderWithTarget:self action:@selector(headerRereshing)];
    //上拉加载
    [self.gwTableview addFooterWithTarget:self action:@selector(footerRereshing)];
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(touchPop) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backNavigationItem;
    
    UIButton * searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(0, 0, 20, 20);
    [searchButton setImage:[UIImage imageNamed:@"Search.png"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(touchPush) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *searNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    self.navigationItem.rightBarButtonItem = searNavigationItem;
//    if ([self.appnameStr isEqual:@"发文"]) {
//        searchButton.hidden = NO;
//    }else{
//        searchButton.hidden = YES;
//    }
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    self.titleLabel.frame = CGRectMake(0, 0, 320, 20);
    self.navigationItem.titleView = self.titleLabel;
    [self getDocument];
    
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchPop
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)touchPush
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
    SearchViewController *search = [storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    search.appnameStr = self.appnameStr;
    search.loginName = self.loginName;
    search.title = self.title;
    [self.navigationController pushViewController:search animated:YES];
}


//分享／收藏请求数据
- (void)getDocument
{
    
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",spageNum];
    NSDictionary *dic = @{@"loginname":self.loginName,
                          @"pageNum":pageNumStr,
                          @"pageSize":@"20",
                          @"title":@"",
                          @"appname":self.appnameStr,
                          };
    
    AFHTTPRequestOperationManager *Manager = [AFHTTPRequestOperationManager manager];
    NSString *url = @"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=library";
    [Manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSArray *statuses = [responseObject objectForKey:@"content"];
        self.total = [responseObject objectForKey:@"total"];
        
        for (NSDictionary *statusInfo in statuses) {
            gwDataModel *statusModel = [[gwDataModel alloc]initWithDictionary:statusInfo];
            [self.arrayContent addObject:statusModel];
        }
        [self.gwTableview reloadData];
        [self.activityIndicatorView stopAnimating];
        [self.gwTableview headerEndRefreshing];
        [self.gwTableview footerEndRefreshing];

        if ([self.appnameStr isEqual:@"fawen"]) {
            self.titleLabel.text = [NSString stringWithFormat:@"发文库(%@)",self.total];
        } else if ([self.appnameStr isEqual:@"shouwen"]) {
            self.titleLabel.text = [NSString stringWithFormat:@"收文库(%@)",self.total];
        }
        else if ([self.appnameStr isEqual:@"一事一表"]) {
            self.titleLabel.text = [NSString stringWithFormat:@"一事一表(%ld)",(unsigned long)self.arrayContent.count];
        }

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
    return self.arrayContent.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    gwTableViewCell *gwCell = [[gwTableViewCell alloc]init];
    ysybTableViewCell *ysybCell = [[ysybTableViewCell  alloc]init];
    if ([self.appnameStr isEqual:@"fawen"] ||[self.appnameStr isEqual:@"shouwen"]) {
        gwCell = [tableView dequeueReusableCellWithIdentifier:@"gwTableViewCell" forIndexPath:indexPath];
        if (self.arrayContent.count >0 ) {
            [gwCell setStatusModel:self.arrayContent[indexPath.row]];
        }
        return gwCell;
    }else{
        ysybCell = [tableView dequeueReusableCellWithIdentifier:@"ysybTableViewCell" forIndexPath:indexPath];
        if (self.arrayContent.count >0 ) {
            [ysybCell setStatusModel:self.arrayContent[indexPath.row]];
        }
        return ysybCell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
   gwModel = [self.arrayContent objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    fxViewController *fxVC = [storyboard instantiateViewControllerWithIdentifier:@"fxViewController"];
    
    fxVC.fiPath = gwModel.filePath;
    fxVC.titleStr = gwModel.title;
    self.title = gwModel.title;
    fxVC.Value = 0;
    if ([self.appnameStr isEqual:@"fawen"] ||[self.appnameStr isEqual:@"shouwen"]) {
        [self.navigationController pushViewController:fxVC animated:YES];
    }
    
    [self.gwTableview deselectRowAtIndexPath:[self.gwTableview indexPathForSelectedRow] animated:YES];
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}


//UITableView的刷新
- (void)headerRereshing
{
    if (self.arrayContent == nil)
    {
        self.arrayContent = [[NSMutableArray alloc]init];
    }
    else
    {
        [self.arrayContent removeAllObjects];
        self.spageNum = 1;
    }

    [self getDocument];
//    [self.gwTableview headerEndRefreshing];
    
    
}



//上拉加载
- (void)footerRereshing
{
//    // 1.添加假数据
//    if (self.arrayContent.count == 20+spageNum*20) {
//        
//    }
    if (self.arrayContent.count < 10)
    {
        self.spageNum = 1;
        [self.arrayContent removeAllObjects];
    }
    else
    {
        spageNum += 1;
    }
    
    [self getDocument];
//    [self.gwTableview footerEndRefreshing];
}
@end
