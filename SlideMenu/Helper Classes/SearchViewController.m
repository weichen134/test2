//
//  SearchViewController.m
//  SlideMenu
//
//  Created by main on 15/10/16.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "SearchViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "GDataXMLNode.h"
#import "gwDataModel.h"
#import "searchTableViewCell.h"
#import "fxViewController.h"
#import "ysybTableViewCell.h"
#import "MJRefresh.h"
#define HOST_URL @"http://gwjh.zjwater.gov.cn/yddldapi/library"

@interface SearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray *arrayContent;
@property (nonatomic,strong)gwDataModel *gwModel;
@property(nonatomic,strong) NSMutableData *soapData;
@property (nonatomic)BOOL needLoading;
@property(nonatomic,strong)NSString *totalCount;
@property(nonatomic,strong)NSString *total;
@end

@implementation SearchViewController
@synthesize soapData;
@synthesize gwModel;
@synthesize spageNum;
@synthesize needLoading;
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
    self.automaticallyAdjustsScrollViewInsets = false;
    if (needLoading == YES) {
        if (self.arrayContent ==nil) {
            self.arrayContent = [[NSMutableArray alloc]init];
        }else{
            [self.arrayContent removeAllObjects];
        }
        [self getDocument];
    }else{
        needLoading = YES;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化数据
    spageNum = 1;
    self.arrayContent = [[NSMutableArray alloc] init];
    needLoading =NO;
    _searChBar.delegate = self;
    _searChBar.placeholder = @"请输入标题内容";
    [_searChBar becomeFirstResponder];
    
    self.searchTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.searchTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(touchPop) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backNavigationItem;
    
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = @"搜索(0)";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    self.titleLabel.frame = CGRectMake(0, 0, 320, 20);
    self.navigationItem.titleView = self.titleLabel;
    
    
    
    //下拉刷新
    [self.searchTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //上拉加载
    [self.searchTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    //风火轮
    _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame : CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)] ;
    _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    _activityIndicatorView.layer.cornerRadius = 15;
    _activityIndicatorView.layer.masksToBounds = YES;
    _activityIndicatorView.alpha = 0.7;
    _activityIndicatorView.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0];
    [_activityIndicatorView setCenter: self.view.center] ;
    [self.view addSubview : _activityIndicatorView];
    
    
}

- (void)touchPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

//分享／收藏请求数据
- (void)getDocument
{
    
//    NSString *str = [self.searChBar.text stringByAddingPercentEscapesUsingEncoding:NSUnicodeStringEncoding];
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    
//    NSData *data = [self.searChBar.text  dataUsingEncoding: enc];
//    
//    NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];
    
    NSString *str = [self.searChBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",spageNum];

    NSDictionary *dic = @{@"loginname":self.loginName,
                          @"pageNum":pageNumStr,
                          @"pageSize":@"20",
                          @"title":str,
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
        [self.searchTableView reloadData];
        [self.activityIndicatorView stopAnimating];
        [self.searchTableView headerEndRefreshing];
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


#pragma mark-
#pragma mark -NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [soapData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [soapData appendData:data];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *soapXML = [[NSString alloc] initWithBytes:[soapData mutableBytes]
                                                 length:[soapData length]
                                               encoding:NSUTF8StringEncoding];
    //解析XML得到JSON
    //解析JSON，使用
    
    //转换成data
    GDataXMLDocument *document=[[GDataXMLDocument alloc] initWithXMLString:soapXML options:0 error:nil];
    GDataXMLElement* rootNode = [document rootElement];
    NSArray *rootChilds=[rootNode children];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    for (GDataXMLNode *node in rootChilds) {
        NSString *nodeName=node.name;
        [dic setValue:[node stringValue] forKey:nodeName];
    }
    NSString * dic1 = [dic objectForKey:@"soap:Body"];
    NSData *da= [dic1 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:da options:NSJSONReadingAllowFragments error:&error];
    NSArray *statuses = [jsonObject objectForKey:@"content"];
    self.totalCount = [jsonObject objectForKey:@"total"];
//    NSMutableArray *statusModels = [NSMutableArray arrayWithCapacity:statuses.count];
    for (NSDictionary *statusInfo in statuses) {
        
        gwDataModel *statusModel = [[gwDataModel alloc]initWithDictionary:statusInfo];
        [self.arrayContent addObject:statusModel];
    }
    
//    self.arrayContent = statusModels;
    self.titleLabel.text = [NSString stringWithFormat:@"搜索(%@)",self.totalCount];
    [self.searchTableView reloadData];

}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
{
    NSLog(@"调用失败处理");
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.arrayContent.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    searchTableViewCell *gwCell = [[searchTableViewCell alloc]init];
    ysybTableViewCell *ysybCell = [[ysybTableViewCell  alloc]init];
    if ([self.appnameStr isEqual:@"fawen"] ||[self.appnameStr isEqual:@"shouwen"]) {
        gwCell = [tableView dequeueReusableCellWithIdentifier:@"searchTableViewCell" forIndexPath:indexPath];
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
    fxVC.Value = 0;
    if ([self.appnameStr isEqual:@"fawen"] ||[self.appnameStr isEqual:@"shouwen"]) {
        [self.navigationController pushViewController:fxVC animated:YES];
    }
    
    
    [self.searchTableView deselectRowAtIndexPath:[self.searchTableView indexPathForSelectedRow] animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}

//搜索栏开始编辑时调用
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.searChBar.showsCancelButton=NO;
    return YES;
}
// 结束
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    self.searChBar.showsCancelButton=NO;
    return YES;
}
//键盘search 按钮点击事件
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.arrayContent removeAllObjects];
    spageNum = 1;
    [self getDocument];
    [self.activityIndicatorView startAnimating];
    [self.searChBar resignFirstResponder];
}

//UITableView的刷新
- (void)headerRereshing
{
    if (self.arrayContent ==nil) {
        self.arrayContent = [[NSMutableArray alloc]init];
    }else{
        [self.arrayContent removeAllObjects];
        spageNum = 1;
    }
    [self getDocument];

}
//上拉加载
- (void)footerRereshing
{
//    // 1.添加假数据
//    if (self.arrayContent.count == 20+spageNum*20) {
//        
//    }
    spageNum += 1;
    [self getDocument];
    [self.searchTableView footerEndRefreshing];
    
}
@end
