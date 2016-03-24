//
//  updateViewController.m
//  SlideMenu
//
//  Created by 不贱不粘 on 16/1/19.
//  Copyright © 2016年 Aryan Ghassemi. All rights reserved.
//

#import "updateViewController.h"

@interface updateViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation updateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.webView setScalesPageToFit:NO];
    self.webView.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    NSString *url = @"http://m.zjwater.gov.cn/oa.aspx?plg_nld=1&plg_uin=1&plg_auth=1&plg_nld=1&plg_usr=1&plg_vkey=1&plg_dev=1";
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
    self.navigationItem.hidesBackButton = YES;
    
    NSString *js_fit_code = [NSString stringWithFormat:@"var meta = document.createElement('meta');"
                             "meta.name = 'viewport';"
                             "meta.content = 'width=device-width, initial-scale=1.0,minimum-scale=0.1, maximum-scale=2.0, user-scalable=yes';"
                             "document.getElementsByTagName('head')[0].appendChild(meta);"
                             ];
    [self.webView stringByEvaluatingJavaScriptFromString:js_fit_code];
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
