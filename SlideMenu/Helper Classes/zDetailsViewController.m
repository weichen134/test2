//
//  zDetailsViewController.m
//  SlideMenu
//
//  Created by main on 15/9/16.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "zDetailsViewController.h"
#import "zCourseViewController.h"
#import "fujianCell.h"
#import "fujianViewController.h"
#import "User.h"
#import "AFHTTPRequestOperationManager.h"


#import "fViewController.h"
@interface zDetailsViewController ()
@property (nonatomic,strong)UIButton *courseButton;
@end

@implementation zDetailsViewController
@synthesize bwsmWebview,height,bwsmString,document_url;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.beishu = 200;
    self.viewA = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    self.viewA.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.viewA];
    
    // Do any additional setup after loading the view.
    [self.zaibanWebview setScalesPageToFit:YES];
    [self.bwsmWebview setScalesPageToFit:YES];
    self.navigationController.navigationBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
    self.automaticallyAdjustsScrollViewInsets = false;
    self.fujianView = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-50, self.view.bounds.size.height - 80, 40, 40)];
    self.fujianView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn_fujian_dan.png"]];
    self.fujianView.layer.masksToBounds = YES;
    self.fujianView.layer.cornerRadius = 20;
    self.fujianView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.fujianView.hidden = YES;
    [self.view addSubview:self.fujianView];
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(touchPop) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backNavigationItem;
    
    self.courseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _courseButton.frame = CGRectMake(0, 0, 20, 20);
    [_courseButton setImage:[UIImage imageNamed:@"licheng_white.png"] forState:UIControlStateNormal];
    [_courseButton addTarget:self action:@selector(course) forControlEvents:UIControlEventTouchDown];
    
    if ([self.subAppname rangeOfString:@"发文"].location != NSNotFound || [self.subAppname rangeOfString:@"会签"].location != NSNotFound||[self.subAppname rangeOfString:@"收文"].location != NSNotFound) {
        UIBarButtonItem *courseNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:_courseButton];
        self.navigationItem.rightBarButtonItem = courseNavigationItem;
    }
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = self.biaotititle;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.frame = CGRectMake(0, 0, self.navigationItem.titleView.bounds.size.width, 20);
    self.navigationItem.titleView = titleLabel;

    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(exit)];
    [self.fujianView addGestureRecognizer:tapGesture];
    
    [self xiangqingData];
    [self fujianData];
    
    //风火轮
    self.zaibanWebview.delegate = self;
    _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame : CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)] ;
    _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    _activityIndicatorView.layer.cornerRadius = 15;
    _activityIndicatorView.layer.masksToBounds = YES;
    _activityIndicatorView.alpha = 0.7;
    _activityIndicatorView.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0];
    [_activityIndicatorView setCenter: self.view.center] ;
    [self.view addSubview : _activityIndicatorView];
    
    //添加两个可以缩放html页面文字的按钮，一个加，一个减
    //加号
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(self.view.frame.size.width-55, self.view.frame.size.height - 280, 50, 50);
    
    [addButton setImage:[UIImage imageNamed:@"加.png"] forState:UIControlStateNormal];
    [self.zaibanWebview addSubview:addButton];
    addButton.backgroundColor = [UIColor lightGrayColor];
    addButton.alpha = 0.5;
    [addButton.layer setCornerRadius:5.0];
    [addButton addTarget:self action:@selector(plusBeishu) forControlEvents:UIControlEventTouchUpInside];
    //减号
    UIButton *cutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cutButton.frame = CGRectMake(self.view.frame.size.width-55, self.view.frame.size.height - 220, 50, 50);
    
    [cutButton setImage:[UIImage imageNamed:@"减.png"] forState:UIControlStateNormal];
    [self.zaibanWebview addSubview:cutButton];
    cutButton.alpha = 0.5;
    cutButton.backgroundColor = [UIColor lightGrayColor];
    [cutButton.layer setCornerRadius:5.0];
    [cutButton addTarget:self action:@selector(cutBeishu) forControlEvents:UIControlEventTouchUpInside];
    if ([self.subAppname rangeOfString:@"收文"].location != NSNotFound )
    {
        [addButton setHidden:YES];
        [cutButton setHidden:YES];
    }
    
}

-(void)plusBeishu
{
    self.beishu += 10;
    NSString *str1 = [NSString stringWithFormat:@"%d",self.beishu];
    NSString *str2 = @"%";
    NSString *str = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%@%@'",str1,str2];
    
    [self.zaibanWebview stringByEvaluatingJavaScriptFromString:str];
    
}

-(void)cutBeishu
{
    self.beishu -= 10;
    NSString *str1 = [NSString stringWithFormat:@"%d",self.beishu];
    NSString *str2 = @"%";
    NSString *str = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%@%@'",str1,str2];
    
    [self.zaibanWebview stringByEvaluatingJavaScriptFromString:str];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

//办文说明获取
- (void)xiangqingData
{
    self.bwsmString = @"";
    NSDictionary *dic = @{@"loginname":self.loginName,
                          };
    NSString *url = [NSString stringWithFormat:@"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=getWorkflowContent&instanceGUID=%@",self.instanceID];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *Manager = [AFHTTPRequestOperationManager manager];
    [Manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"success"] isEqual:@1]||[[responseObject objectForKey:@"success"] isEqual:@"ture"]) {
            NSDictionary *contentDic = [responseObject objectForKey:@"content"];
            self.document_url = [contentDic objectForKey:@"document_url"];
            //办文说明
            self.bwsmString = [contentDic objectForKey:@"bwsm"];
            [self performSelector:@selector(changeHeightOfBwsmWebView) withObject:nil afterDelay:0.1];
            //详情
            [self showMainDocument];
        }else{
            [self shujuyichang];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self fuwuyichang];
    }];
}

//正文显示
-(void)showMainDocument
{
    if ([self.subAppname rangeOfString:@"收文"].location != NSNotFound) {
        NSString *changgeSubAppname = [self.subAppname stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *url = [NSString stringWithFormat:@"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=getWorkflowDocument&instanceGUID=%@&subappname=%@",self.instanceID,changgeSubAppname];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
       
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [self.zaibanWebview loadRequest:request];
    } else
    {
        [self.zaibanWebview setScalesPageToFit:YES];
        if (document_url == nil) {
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:nil]];
            [self.zaibanWebview loadRequest:request];
        } else {
            NSString *url = [NSString stringWithFormat:@"http://gwjh.zjwater.gov.cn/ydapi/%@",document_url];
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
            [self.zaibanWebview loadRequest:request];
        }
        
    }
}

-(void)changeHeightOfBwsmWebView;
{
    if (self.bwsmString == nil || self.bwsmString.length ==0) {
        self.height.constant = 0;
    } else {
        self.height.constant = 32;
        [self.bwsmWebview loadHTMLString:[NSString stringWithFormat:@"<html><head><style>body{background-color:transparent;font-size:50px;font-weight:bold}</style></head><body><marquee scrollamount=7><font color=\"#E02603\">办文说明: </font><font color=\"#3BED73\">%@</font></marquee></body></html>",self.bwsmString] baseURL:nil];
        
    }
}



- (void)fujianData
{
    NSDictionary *dic = @{@"loginname":self.loginName,
                          };
    
    NSString *url = [NSString stringWithFormat:@"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=getFiles&instanceGUID=%@",self.instanceID];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *Manager = [AFHTTPRequestOperationManager manager];
    [Manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] isEqual:@1]||[[responseObject objectForKey:@"success"] isEqual:@"ture"]) {
            self.fujianTableview = [[UITableView alloc]init];
            self.fujianTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
            self.fujianTableview.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
            
            
            self.content = [responseObject objectForKey:@"content"];
            NSArray *attachment = [self.content objectForKey:@"attachment"];
            NSArray *editattachment = [self.content objectForKey:@"editattachment"];
            NSArray *fkfj = [self.content objectForKey:@"fkfj"];
            _fujianNum = attachment.count+editattachment.count+fkfj.count;
            self.fujianTableview.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 44*_fujianNum);
            //        self.fujianTableview.backgroundColor = [UIColor colorWithRed:226/255.0 green:241/255.0 blue:254/255.0 alpha:1.0];
            //            self.fujianTableview.delegate = self;
            //            self.fujianTableview.dataSource = self;
            [self.view addSubview:self.fujianTableview];
            if (_fujianNum == 0) {
                self.fujianTableview.hidden = YES;
                self.fujianView.hidden = YES;
            }else{
                self.fujianTableview.hidden = NO;
                self.fujianView.hidden = NO;
            }
            //            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(exit)];
            //            UITapGestureRecognizer *tapGestureWeb = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(exitHidden)];
            //            [self.fujianView addGestureRecognizer:tapGesture];
            //            [self.view addGestureRecognizer:tapGestureWeb];
            //            [self.zaibanWebview addGestureRecognizer:tapGestureWeb];
            //
            //            NSMutableArray *statuses = [[NSMutableArray alloc]init];
            //            [statuses addObjectsFromArray:attachment];
            //            [statuses addObjectsFromArray:editattachment];
            //            [statuses addObjectsFromArray:fkfj];
            //            NSMutableArray *statusModels = [NSMutableArray arrayWithCapacity:statuses.count];
            //            for (NSDictionary *statusInfo in statuses) {
            //
            //                fujianModel *statusModel = [[fujianModel alloc]initWithDictionary:statusInfo];
            //                [statusModels addObject:statusModel];
            //            }
            //            self.statusesArray = statusModels;
            //            [self.fujianTableview reloadData];
        }else{
            [self shujuyichang];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
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

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    return _fujianNum;
//}
//
//
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    fujianCell *fuCell = (fujianCell *)[tableView dequeueReusableCellWithIdentifier:@"fujianCell"];
//    if (!fuCell) {
//        fuCell= (fujianCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"fujianCell" owner:self options:nil]  lastObject];
//    }
//    fuCell.numLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
//    [fuCell setStatusModel:self.statusesArray[indexPath.row]];
//    return fuCell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//{
//    _fModel = [self.statusesArray objectAtIndex:indexPath.row];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
//    // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
//    fujianViewController *fujian = [storyboard instantiateViewControllerWithIdentifier:@"fujianViewController"];
//    fujian.idstance = _fModel.instance;
//    fujian.titleL = _fModel.title;
//    [self.navigationController pushViewController:fujian animated:YES];
//    [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationOptionTransitionCurlUp animations:^{
//        self.fujianTableview.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 44*_fujianNum);
//    } completion:nil];
//    [self.fujianTableview deselectRowAtIndexPath:[self.fujianTableview indexPathForSelectedRow] animated:YES];
//}


- (void)exit
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
    fViewController *fView = [storyboard instantiateViewControllerWithIdentifier:@"fViewController"];
    fView.delegate = self;
    fView.loginName = self.loginName;
    fView.instanceID = self.instanceID;
    fView.subAppname = self.subAppname;
    fView.content = self.content;
    [self.navigationController pushViewController:fView animated:YES];
}

- (void)exitHidden
{
    [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        self.fujianTableview.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 44*_fujianNum);
    } completion:nil];
}

- (void)course
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
    zCourseViewController *zCourse = [storyboard instantiateViewControllerWithIdentifier:@"zCourseViewController"];
    zCourse.loginName =self.loginName;
    zCourse.biaotititle = self.biaotititle;
    zCourse.subAppname = self.subAppname;
    zCourse.instanceID = self.instanceID;
    zCourse.taskName = self.taskName;
    [self.navigationController pushViewController:zCourse animated:YES];
}


//webView代理、风火轮
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [_activityIndicatorView startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '300%'";
    [webView stringByEvaluatingJavaScriptFromString:str];
    [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(delay) userInfo:nil repeats:YES];
    
    [_activityIndicatorView stopAnimating];
}

-(void)delay
{
    
    [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(delay:) userInfo:nil repeats:YES];
    
}

-(void)delay:(NSTimer*)timer
{
    self.viewA.alpha -= 0.3;
    
    if (self.viewA.alpha < 0)
    {
        [timer setFireDate:[NSDate distantFuture]];
        
    }
}


@end
