//
//  fujianViewController.m
//  SlideMenu
//
//  Created by main on 15/9/18.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "fujianViewController.h"

@interface fujianViewController ()

@end

@implementation fujianViewController
@synthesize fjType,filePath,subAppName;

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.beishu = 200;
    self.viewA = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    self.viewA.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.viewA];
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(touchPop) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backNavigationItem;
    
    if ([self.titleL rangeOfString:@"."].location != NSNotFound) {
        self.titleL = [self.titleL componentsSeparatedByString:@"."][0];
    }
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = self.titleL;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.frame = CGRectMake(0, 0, self.navigationItem.titleView.bounds.size.width, 20);
    self.navigationItem.titleView = titleLabel;
    
    self.fujianWebview.opaque=NO;
    [self.fujianWebview setScalesPageToFit:YES];
    
    
    [self showFujian];
    
    //风火轮
    self.fujianWebview.delegate = self;
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
    addButton.frame = CGRectMake(280, 80, 20, 20);
    
    [addButton setImage:[UIImage imageNamed:@"11111.png"] forState:UIControlStateNormal];

    [self.fujianWebview addSubview:addButton];
    addButton.alpha = 0.5;
    
    [addButton addTarget:self action:@selector(plusBeishu) forControlEvents:UIControlEventTouchUpInside];
    //减号
    UIButton *cutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cutButton.frame = CGRectMake(280, 100, 20, 20);
    
    [cutButton setImage:[UIImage imageNamed:@"22222.png"] forState:UIControlStateNormal];
    [self.fujianWebview addSubview:cutButton];
    cutButton.alpha = 0.5;
    [cutButton addTarget:self action:@selector(cutBeishu) forControlEvents:UIControlEventTouchUpInside];
    if ([self.fjType isEqualToString:@"1"]||[self.fjType isEqualToString:@"4"])
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
    
    [self.fujianWebview stringByEvaluatingJavaScriptFromString:str];
    
}

-(void)cutBeishu
{
    self.beishu -= 10;
    NSString *str1 = [NSString stringWithFormat:@"%d",self.beishu];
    NSString *str2 = @"%";
    NSString *str = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%@%@'",str1,str2];
    
    [self.fujianWebview stringByEvaluatingJavaScriptFromString:str];
    
}

-(void)showFujian;
{
    if ([self.subAppName rangeOfString:@"收文"].location != NSNotFound)
    {
        NSString *url = [NSString stringWithFormat:@"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=filedownload&instanceGUID=%@&type=%@",self.idstance,fjType];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [self.fujianWebview loadRequest:request];
    } else if ([self.subAppName rangeOfString:@"发文"].location != NSNotFound  && [fjType isEqualToString:@"1"] == YES) {
        NSString *url = [NSString stringWithFormat:@"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=filedownload&instanceGUID=%@&type=%@",self.idstance,fjType];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"url======%@",url);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [self.fujianWebview loadRequest:request];
    }
    else
    {
        if (filePath == nil) {
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:nil]];
            [self.fujianWebview loadRequest:request];
        } else {
            NSString *url = [NSString stringWithFormat:@"http://gwjh.zjwater.gov.cn/ydapi/%@",filePath];
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"url ======= %@",url);
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
            [self.fujianWebview loadRequest:request];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

//webView代理、风火轮
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [_activityIndicatorView startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(delay) userInfo:nil repeats:YES];
    
    [_activityIndicatorView stopAnimating];
    
    //放大
    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'";
    [webView stringByEvaluatingJavaScriptFromString:str];
    
    if ([self.subAppName rangeOfString:@"收文"].location != NSNotFound)
    {
        CGPoint top = CGPointMake(0, -60); // can also use CGPointZero here
        [self.fujianWebview.scrollView setContentOffset:top animated:YES];
    } else if ([self.subAppName rangeOfString:@"发文"].location != NSNotFound  && [fjType isEqualToString:@"1"] == YES) {
        CGPoint top = CGPointMake(0, -60); // can also use CGPointZero here
        [self.fujianWebview.scrollView setContentOffset:top animated:YES];
    }
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
