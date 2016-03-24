//
//  fxViewController.m
//  SlideMenu
//
//  Created by main on 15/9/24.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "fxViewController.h"

@interface fxViewController ()
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)NSString *url;
@end

@implementation fxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.viewA = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    self.viewA.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.viewA];
    
    self.fxWebView.delegate = self;
    self.fxWebView.scrollView.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
    self.automaticallyAdjustsScrollViewInsets = false;
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(touchPop) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backNavigationItem;
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = self.titleStr;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    self.titleLabel.frame = CGRectMake(0, 0, self.navigationItem.titleView.bounds.size.width, 20);
    self.navigationItem.titleView = self.titleLabel;
    
    [self.fxWebView setScalesPageToFit:YES];
    if ([self.fiPath isEqualToString:@""])
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 60)];
        label.center = self.view.center;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:20];
        label.text = @"此文无正文";
        [self.view addSubview:label];
    }
    else
    {
        if (self.Value == 0)
        {
            self.url = self.fiPath;
        }
        else
        {
            
            self.url = [NSString stringWithFormat:@"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=filedownload&instanceGUID=%@&type=2",self.fiPath];
        }
        
    }
//    if (self.Value == 0)
//    {
//        self.url = self.fiPath;
//    }else{
//        self.url = [NSString stringWithFormat:@"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=filedownload&instanceGUID=%@&type=2",self.fiPath];
//    }
    
    self.url = [self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.fxWebView loadRequest:request];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchPop
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(delay) userInfo:nil repeats:YES];
    
    [self.activityIndicator stopAnimating];
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
