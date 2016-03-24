//
//  zCourseViewController.m
//  SlideMenu
//
//  Created by main on 15/9/17.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "zCourseViewController.h"
#import "yuanView.h"
#import "jianchengView.h"
#import "yijianView.h"
#import "AFHTTPRequestOperationManager.h"
#import "User.h"
@interface zCourseViewController ()
@property (nonatomic,strong)yuanView *yuanView1;
@property (nonatomic,strong)yuanView *yuanView2;
@property (nonatomic,strong)yuanView *yuanView3;
@property (nonatomic,strong)yuanView *yuanView4;
@property (nonatomic,strong)UIImageView *imageView1;
@property (nonatomic,strong)UIImageView *imageView2;
@property (nonatomic,strong)UIImageView *imageView3;
@property (nonatomic,strong)UIImageView *imageView4;

@property (nonatomic,strong)jianchengView *jianchengView1;
@property (nonatomic) int a;
@property (nonatomic) int b;
@property (nonatomic) int c;
@property (nonatomic) int d;
@property (nonatomic) int e;
@property (nonatomic,strong)NSArray *actarry1;
@property (nonatomic,strong)NSArray *actarry2;
@property (nonatomic,strong)NSArray *actarry3;
@property (nonatomic,strong)NSArray *actarry4;
@property (nonatomic,strong)NSArray *sactarry1;
@property (nonatomic,strong)NSArray *sactarry2;
@property (nonatomic,strong)NSArray *sactarry3;
@property (nonatomic,strong)NSArray *sactarry4;
@property (nonatomic,strong)NSArray *arrayCScomment;
@property (nonatomic,strong)NSArray *arrayCScontent;
@property (nonatomic)float textHeight;
@property (nonatomic)float ztextHeight;
@end

@implementation zCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.yuanView2 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
    self.yuanView3 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
    self.yuanView4 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
    self.imageView1 = [[UIImageView alloc]init];
    self.imageView2 = [[UIImageView alloc]init];
    self.imageView3 = [[UIImageView alloc]init];
    self.imageView4 = [[UIImageView alloc]init];
    
    self.courseScroll.userInteractionEnabled = YES;
    self.courseScroll.scrollEnabled =YES;
    self.courseScroll.directionalLockEnabled = NO;
    self.courseScroll.canCancelContentTouches = YES;
    self.courseScroll.showsHorizontalScrollIndicator = NO;
    self.courseScroll.showsVerticalScrollIndicator = NO;
    self.courseScroll.bounces = NO;
    
    self.navigationController.navigationBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = self.biaotititle;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.frame = CGRectMake(0, 0, self.navigationItem.titleView.bounds.size.width, 20);
    self.navigationItem.titleView = titleLabel;
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(touchPop) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backNavigationItem;
    
    [self xiangqingData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchPop
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)xiangqingData
{
    NSDictionary *dic = @{@"loginname":self.loginName,
                          };
    
    
    NSString *url = [NSString stringWithFormat:@"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=getWorkflowContent&instanceGUID=%@",self.instanceID];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *Manager = [AFHTTPRequestOperationManager manager];
    [Manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"success"] isEqual:@1]||[[responseObject objectForKey:@"success"] isEqual:@"ture"]) {
            self.arrayCScomment = [responseObject objectForKey:@"comment"];
            self.taskNameStr = [[responseObject objectForKey:@"task_name"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            for (int a = 0; a<self.arrayCScomment.count; a++) {
                if ([self.subAppname rangeOfString:@"发文"].location != NSNotFound || [self.subAppname rangeOfString:@"会签"].location != NSNotFound) {
                    if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"核稿"].location != NSNotFound){
                        NSDictionary *contentDic1  = [self.arrayCScomment objectAtIndex:a];
                        _actarry1 = [[NSArray alloc]init];
                        _actarry1 = [contentDic1 objectForKey:@"content"];
                    }
                    if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"会签"].location != NSNotFound){
                        NSDictionary *contentDic1  = [self.arrayCScomment objectAtIndex:a];
                        _actarry2 = [[NSArray alloc]init];
                        _actarry2 = [contentDic1 objectForKey:@"content"];
                    }
                    if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"核签"].location != NSNotFound){
                        NSDictionary *contentDic1  = [self.arrayCScomment objectAtIndex:a];
                        _actarry3 = [[NSArray alloc]init];
                        _actarry3 = [contentDic1 objectForKey:@"content"];
                    }
                    if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"签发"].location != NSNotFound){
                        NSDictionary *contentDic1  = [self.arrayCScomment objectAtIndex:a];
                        _actarry4 = [[NSArray alloc]init];
                        _actarry4 = [contentDic1 objectForKey:@"content"];
                    }
                }
                else if([self.subAppname rangeOfString:@"收文"].location != NSNotFound)
                {
                    if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"拟办意见"].location != NSNotFound){
                        NSDictionary *contentDic1  = [self.arrayCScomment objectAtIndex:a];
                        _sactarry1 = [[NSArray alloc]init];
                        _sactarry1 = [contentDic1 objectForKey:@"content"];
                    }
                    if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"领导批示"].location != NSNotFound){
                        NSDictionary *contentDic1  = [self.arrayCScomment objectAtIndex:a];
                        _sactarry2 = [[NSArray alloc]init];
                        _sactarry2 = [contentDic1 objectForKey:@"content"];
                    }
                    if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"部门意见"].location != NSNotFound){
                        NSDictionary *contentDic1  = [self.arrayCScomment objectAtIndex:a];
                        _sactarry3 = [[NSArray alloc]init];
                        _sactarry3 = [contentDic1 objectForKey:@"content"];
                    }
                    if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"办理结果"].location != NSNotFound){
                        NSDictionary *contentDic1  = [self.arrayCScomment objectAtIndex:a];
                        _sactarry4 = [[NSArray alloc]init];
                        _sactarry4 = [contentDic1 objectForKey:@"content"];
                    }
                }
            }
            
            [self lichengData];
        }else{
            [self shujuyichang];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self fuwuyichang];
    }];
}


//历程数据
- (void)lichengData
{
    NSDictionary *dic = @{@"loginname":self.loginName,
                          };
    NSString *url = [NSString stringWithFormat:@"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=viewtracking&instanceGUID=%@",self.instanceID];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *Manager = [AFHTTPRequestOperationManager manager];
    [Manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //                NSLog(@"－－－viewtracking%@",responseObject);
        if ([[responseObject objectForKey:@"success"] isEqual:@1]||[[responseObject objectForKey:@"success"] isEqual:@"ture"]) {
            self.arrayCScontent = [responseObject objectForKey:@"content"];
            
            if ([self.subAppname rangeOfString:@"发文"].location != NSNotFound || [self.subAppname rangeOfString:@"会签"].location != NSNotFound) {
                [self fawenView];
            }else if([self.subAppname rangeOfString:@"收文"].location != NSNotFound)
            {
                [self shouwenView];
            }else if ([self.subAppname rangeOfString:@"加班"].location != NSNotFound)
            {
                
            }
            else if ([self.subAppname rangeOfString:@"出差"].location != NSNotFound)
            {
                
            }else if ([self.subAppname rangeOfString:@"请假"].location != NSNotFound)
            {
                
            }
            UIView *taskLabelView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-30, self.view.bounds.size.width, 30)];
            taskLabelView.backgroundColor = [UIColor colorWithRed:253/255.0 green:126/255.0 blue:6/255.0 alpha:1.0];
            UILabel *taskLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
//            taskLabel.backgroundColor = [UIColor colorWithRed:253/255.0 green:126/255.0 blue:6/255.0 alpha:1.0];
            taskLabel.textAlignment = NSTextAlignmentCenter;
            taskLabel.textColor = [UIColor whiteColor];
            taskLabel.text = self.taskNameStr;
            [self.view addSubview:taskLabelView];
            [taskLabelView addSubview:taskLabel];
            if (taskLabel.text.length > taskLabel.bounds.size.width) {
                CGRect frame = taskLabel.frame;
                frame.origin.x = 0;
                frame.size.width = taskLabel.text.length;
                taskLabel.frame = frame;
                
                [UIView beginAnimations:@"testAnimation" context:NULL];
                [UIView setAnimationDuration:8.8f];
                [UIView setAnimationCurve:UIViewAnimationCurveLinear];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationRepeatAutoreverses:NO];
                [UIView setAnimationRepeatCount:999999];
                frame = taskLabel.frame;
                frame.origin.x = self.view.bounds.size.width-taskLabel.text.length;
                taskLabel.frame = frame;
                [UIView commitAnimations];
            }
            
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

//发文视图
- (void)fawenView
{
    UIImageView *viewSt= [[UIImageView alloc]initWithFrame:CGRectMake(40, 0, 2, 20)];
    viewSt.backgroundColor = [UIColor colorWithRed:0 green:117/255.0 blue:255/255.0 alpha:1.0];
    [self.courseScroll addSubview:viewSt];
    //拟稿
    for (int a = 0; a<self.arrayCScontent.count; a++) {
        //拟稿
        if ([[[self.arrayCScontent[a] objectForKey:@"taskName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] isEqual:@"发文拟稿"]) {
            self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
            self.yuanView1.view.frame = CGRectMake(28, 20, self.yuanView1.ViewY.frame.size.width, 26);
            self.yuanView1.nLabel.text = @"1";
            self.yuanView1.nLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:117/255.0 blue:255/255.0 alpha:1.0];
            self.yuanView1.leixLabel.text = @"拟稿";
            
            self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
            self.jianchengView1.view.frame = CGRectMake(39, 46, self.jianchengView1.ViewJ.frame.size.width, 50);
            
            NSDictionary *contentDic = [[NSDictionary alloc]init];
            contentDic = [self.arrayCScontent objectAtIndex:a];
            NSArray *actarry = [[NSArray alloc]init];
            actarry = [contentDic objectForKey:@"actors"];
            NSDictionary *actors = [[NSDictionary alloc]init];
            actors = [actarry objectAtIndex:0 ];
            
            NSString *date = [[contentDic objectForKey:@"updateDateString"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
            NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
            [inputFormatter setTimeZone:timeZone];
            [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSDate* inputDate = [inputFormatter dateFromString:date];
            NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
            
            [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *strd = [outputFormatter stringFromDate:inputDate];
            self.jianchengView1.dateLabel.text = strd;
            
            
            
            NSString *strb = [[actors objectForKey:@"deptname"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if ([strb rangeOfString:@","].location != NSNotFound) {
                strb = [strb componentsSeparatedByString:@","][1];
                self.danweiStr = strb;
            }else{
                self.danweiStr = strb;
            }
            NSString *name  = [[actors objectForKey:@"username"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *zhiwuStr = [[actors objectForKey:@"personJob"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if (![self.danweiStr isEqual:@""]) {
                if ([zhiwuStr isEqual:[NSNull class]] || [zhiwuStr isEqual:@""]) {
                    self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",name,self.danweiStr];
                }else{
                    self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@,%@)",name,self.danweiStr,zhiwuStr];
                }
            }else{
                if ([zhiwuStr isEqual:[NSNull class]] || [zhiwuStr isEqual:@""]) {
                    self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@",name];
                }else{
                    self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",name,zhiwuStr];
                }
            }

            self.jianchengView1.yijianLabel.hidden = YES;
            [self.courseScroll addSubview:self.yuanView1.view];
            [self.courseScroll addSubview:self.jianchengView1.view];
        }
    }
    
    //核稿
    for (int a= 0; a<self.arrayCScomment.count;a++) {
        if (_actarry1.count != 0) {
            if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"核稿"].location != NSNotFound) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                
                self.yuanView1.view.frame = CGRectMake(28, 96, self.yuanView1.ViewY.frame.size.width, 26);
                self.yuanView1.nLabel.text = @"2";
                self.yuanView1.nLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:117/255.0 blue:255/255.0 alpha:1.0];
                self.yuanView1.leixLabel.text = @"核稿";
                [self.courseScroll addSubview:self.yuanView1.view];
                NSDictionary *contentDic1 = [[NSDictionary alloc]init];
                contentDic1 = [self.arrayCScomment objectAtIndex:a];
                NSArray *actarry1 = [[NSArray alloc]init];
                actarry1 = [contentDic1 objectForKey:@"content"];
                
                for (long i = 0; i<actarry1.count; i++) {
                    _b++;
                    self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                    self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+122+50*(_b-1), self.jianchengView1.view.frame.size.width, 50);
                    
                    NSDictionary *actors1 = [actarry1 objectAtIndex:i];
                    NSString *yijianStr = [actors1 objectForKey:@"commentContent"];
                    CGSize titleSize = [yijianStr sizeWithFont:[UIFont fontWithName:@"Arial" size:11.0] constrainedToSize:CGSizeMake(self.jianchengView1.yijianLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    _ztextHeight += titleSize.height;
                    _textHeight = titleSize.height;
                    [self.jianchengView1 testPlusHeight:_textHeight];
                    NSDictionary *dateDic = [actors1 objectForKey:@"commentDate"];
                    long time = [[dateDic objectForKey:@"time"] longLongValue]/1000;
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
                    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
                    [outputFormatter setTimeZone:timeZone];
                    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSString *str = [outputFormatter stringFromDate:date];
                    self.jianchengView1.dateLabel.text = str;
                    
                    self.jianchengView1.yijianLabel.text = yijianStr;
                    self.danweiStr = [[actors1 objectForKey:@"commentDeptName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSString *name = [[actors1 objectForKey:@"commentPerson"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSString *zhiwuStr = [[actors1 objectForKey:@"personJob"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    if (![self.danweiStr isEqual:@""]) {
                        if ([zhiwuStr isEqual:[NSNull class]] || [zhiwuStr isEqual:@""]) {
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",name,self.danweiStr];
                        }else{
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@,%@)",name,self.danweiStr,zhiwuStr];
                        }
                    }else{
                        if ([zhiwuStr isEqual:[NSNull class]] || [zhiwuStr isEqual:@""]) {
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@",name];
                        }else{
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",name,zhiwuStr];
                        }
                    }
                    //                self.QCoureH.labelt.text = strd1;
                    //横条颜色变化
                    

                    [self.courseScroll addSubview:self.jianchengView1.view];
                }
            }}else{
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                self.yuanView1.view.frame = CGRectMake(28, 96, self.yuanView1.ViewY.frame.size.width, 26);
                self.yuanView1.nLabel.text = @"2";
                self.yuanView1.leixLabel.text = @"核稿";
                [self.courseScroll addSubview:self.yuanView1.view];
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+122, 2, 50)];
                imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                [self.courseScroll addSubview:imageView];
            }
        
    }
    //会签
    for (int a= 0; a<self.arrayCScomment.count;a++) {
        if (_actarry2.count != 0) {
            if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"会签"].location != NSNotFound) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_actarry1.count != 0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+122+_actarry1.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                }else{
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+122+50, self.yuanView1.ViewY.frame.size.width, 26);
                }
                
                self.yuanView1.nLabel.text = @"3";
                self.yuanView1.nLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:117/255.0 blue:255/255.0 alpha:1.0];
                self.yuanView1.leixLabel.text = @"会签";
                [self.courseScroll addSubview:self.yuanView1.view];
                NSDictionary *contentDic1 = [[NSDictionary alloc]init];
                contentDic1 = [self.arrayCScomment objectAtIndex:a];
                NSArray *actarry1 = [[NSArray alloc]init];
                actarry1 = [contentDic1 objectForKey:@"content"];
                
                for (long i = 0; i<actarry1.count; i++) {
                    _c++;
                    self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                    if (_actarry1.count != 0){
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+148+_actarry1.count*50+50*(_c-1), self.jianchengView1.view.frame.size.width, 50);
                    }else{
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+148+50+50*(_c-1), self.jianchengView1.view.frame.size.width, 50);
                    }
                    
                    NSDictionary *actors1 = [actarry1 objectAtIndex:i];
                    NSString *yijianStr = [actors1 objectForKey:@"commentContent"];
                    CGSize titleSize = [yijianStr sizeWithFont:[UIFont fontWithName:@"Arial" size:11.0] constrainedToSize:CGSizeMake(self.jianchengView1.yijianLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    _ztextHeight += titleSize.height;
                    _textHeight = titleSize.height;
                    [self.jianchengView1 testPlusHeight:_textHeight];
                    
                    NSDictionary *dateDic = [actors1 objectForKey:@"commentDate"];
                    
                    long time = [[dateDic objectForKey:@"time"] longLongValue]/1000;
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
                    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
                    [outputFormatter setTimeZone:timeZone];
                    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSString *str = [outputFormatter stringFromDate:date];
                    self.jianchengView1.dateLabel.text = str;
                    
                    self.jianchengView1.yijianLabel.text = yijianStr;
                    self.danweiStr = [[actors1 objectForKey:@"commentDeptName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSString *name = [[actors1 objectForKey:@"commentPerson"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSString *zhiwuStr = [[actors1 objectForKey:@"personJob"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    if (![self.danweiStr isEqual:@""]) {
                        if ([zhiwuStr isEqual:[NSNull class]] || [zhiwuStr isEqual:@""]) {
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",name,self.danweiStr];
                        }else{
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@,%@)",name,self.danweiStr,zhiwuStr];
                        }
                    }else{
                        if ([zhiwuStr isEqual:[NSNull class]] || [zhiwuStr isEqual:@""]) {
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@",name];
                        }else{
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",name,zhiwuStr];
                        }
                    }
                    //                self.QCoureH.labelt.text = strd1;


                    [self.courseScroll addSubview:self.jianchengView1.view];
                }
            }}else{
                if (_actarry1.count !=0) {
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+122+50*_actarry1.count, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"3";
                    self.yuanView1.leixLabel.text = @"会签";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+148+50*_actarry1.count, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else{
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+122+50, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"3";
                    self.yuanView1.leixLabel.text = @"会签";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+148+50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
            }
        
    }
    //核签
    for (int a= 0; a<self.arrayCScomment.count;a++) {
        if (_actarry3.count != 0) {
            if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"核签"].location != NSNotFound) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                
                if (_actarry1.count != 0 && _actarry2.count != 0) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+_actarry2.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                }else if (_actarry1.count != 0 && _actarry2.count == 0) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                }else if (_actarry1.count == 0 && _actarry2.count != 0) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry2.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                }else if (_actarry1.count == 0 && _actarry2.count == 0) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+100, self.yuanView1.ViewY.frame.size.width, 26);
                }
                self.yuanView1.nLabel.text = @"4";
                self.yuanView1.nLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:117/255.0 blue:255/255.0 alpha:1.0];
                self.yuanView1.leixLabel.text = @"核签";
                [self.courseScroll addSubview:self.yuanView1.view];
                NSDictionary *contentDic1 = [[NSDictionary alloc]init];
                contentDic1 = [self.arrayCScomment objectAtIndex:a];
                NSArray *actarry1 = [[NSArray alloc]init];
                actarry1 = [contentDic1 objectForKey:@"content"];
                
                for (long i = 0; i<actarry1.count; i++) {
                    _d++;
                    self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                    if (_actarry1.count != 0 && _actarry2.count != 0) {
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+50*(_d-1), self.jianchengView1.view.frame.size.width, 50);
                    }else if (_actarry1.count != 0 && _actarry2.count == 0) {
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+_actarry1.count*50+50+50*(_d-1), self.jianchengView1.view.frame.size.width, 50);
                    }else if (_actarry1.count == 0 && _actarry2.count != 0) {
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+_actarry2.count*50+50+50*(_d-1), self.jianchengView1.view.frame.size.width, 50);
                    }else if (_actarry1.count == 0 && _actarry2.count == 0) {
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+100+50*(_d-1), self.jianchengView1.view.frame.size.width, 50);
                    }
                    
                    NSDictionary *actors1 = [actarry1 objectAtIndex:i];
                    NSString *yijianStr = [actors1 objectForKey:@"commentContent"];
                    CGSize titleSize = [yijianStr sizeWithFont:[UIFont fontWithName:@"Arial" size:11.0] constrainedToSize:CGSizeMake(self.jianchengView1.yijianLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    _ztextHeight += titleSize.height;
                    _textHeight = titleSize.height;
                    [self.jianchengView1 testPlusHeight:_textHeight];
                    NSDictionary *dateDic = [actors1 objectForKey:@"commentDate"];
                    
                    long time = [[dateDic objectForKey:@"time"] longLongValue]/1000;
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
                    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
                    [outputFormatter setTimeZone:timeZone];
                    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSString *str = [outputFormatter stringFromDate:date];
                    self.jianchengView1.dateLabel.text = str;
                    
                    self.jianchengView1.yijianLabel.text = yijianStr;
                    self.danweiStr = [[actors1 objectForKey:@"commentDeptName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSString *name = [[actors1 objectForKey:@"commentPerson"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSString *zhiwuStr = [[actors1 objectForKey:@"personJob"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    if (![self.danweiStr isEqual:@""]) {
                        if ([zhiwuStr isEqual:[NSNull class]] || [zhiwuStr isEqual:@""]) {
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",name,self.danweiStr];
                        }else{
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@,%@)",name,self.danweiStr,zhiwuStr];
                        }
                    }else{
                        if ([zhiwuStr isEqual:[NSNull class]] || [zhiwuStr isEqual:@""]) {
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@",name];
                        }else{
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",name,zhiwuStr];
                        }
                    }
                
                    [self.courseScroll addSubview:self.jianchengView1.view];
                }
            }}else{
                if (_actarry1.count !=0 && _actarry2.count !=0) {
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+_actarry2.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"4";
                    self.yuanView1.leixLabel.text = @"核签";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50*_actarry1.count+_actarry2.count*50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if (_actarry1.count !=0 && _actarry2.count ==0){
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"4";
                    self.yuanView1.leixLabel.text = @"核签";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if (_actarry1.count ==0 && _actarry2.count !=0){
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry2.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"4";
                    self.yuanView1.leixLabel.text = @"核签";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50*_actarry2.count+50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if (_actarry1.count ==0 && _actarry2.count ==0){
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+100, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"4";
                    self.yuanView1.leixLabel.text = @"核签";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+100, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
            }
        
    }
    //签发
    for (int a= 0; a<self.arrayCScomment.count;a++) {
        if (_actarry4.count != 0) {
            if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"签发"].location != NSNotFound) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_actarry1.count !=0 && _actarry2.count != 0 && _actarry3.count !=0) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                }else if(_actarry1.count !=0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                }else if(_actarry1.count !=0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+100, self.yuanView1.ViewY.frame.size.width, 26);
                }else if(_actarry1.count !=0 && _actarry2.count == 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+50+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                }else if(_actarry1.count ==0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+150, self.yuanView1.ViewY.frame.size.width, 26);
                }else if(_actarry1.count ==0 && _actarry2.count != 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry2.count*50+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                }else if(_actarry1.count ==0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry2.count*50+100, self.yuanView1.ViewY.frame.size.width, 26);
                }else if(_actarry1.count ==0 && _actarry2.count == 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                }
                self.yuanView1.nLabel.text = @"5";
                self.yuanView1.nLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:117/255.0 blue:255/255.0 alpha:1.0];
                self.yuanView1.leixLabel.text = @"签发";
                [self.courseScroll addSubview:self.yuanView1.view];
                NSDictionary *contentDic1 = [[NSDictionary alloc]init];
                contentDic1 = [self.arrayCScomment objectAtIndex:a];
                NSArray *actarry1 = [[NSArray alloc]init];
                actarry1 = [contentDic1 objectForKey:@"content"];
                
                for (long i = 0; i<actarry1.count; i++) {
                    _e++;
                    self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                    if (_actarry1.count !=0 && _actarry2.count != 0 && _actarry3.count !=0) {
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+_actarry2.count*50+_actarry3.count*50+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                    }else if(_actarry1.count !=0 && _actarry2.count != 0 && _actarry3.count ==0){
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+_actarry2.count*50+50+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                    }else if(_actarry1.count !=0 && _actarry2.count == 0 && _actarry3.count ==0){
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+100+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                    }else if(_actarry1.count !=0 && _actarry2.count == 0 && _actarry3.count !=0){
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+50+_actarry3.count*50+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                    }else if(_actarry1.count ==0 && _actarry2.count == 0 && _actarry3.count ==0){
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+150+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                    }else if(_actarry1.count ==0 && _actarry2.count != 0 && _actarry3.count !=0){
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+50+_actarry2.count*50+_actarry3.count*50+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                    }else if(_actarry1.count ==0 && _actarry2.count != 0 && _actarry3.count ==0){
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry2.count*50+100+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                    }else if(_actarry1.count ==0 && _actarry2.count == 0 && _actarry3.count !=0){
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+100+_actarry3.count*50+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                    }
                    
                    NSDictionary *actors1 = [actarry1 objectAtIndex:i];
                    NSString *yijianStr = [actors1 objectForKey:@"commentContent"];
                    CGSize titleSize = [yijianStr sizeWithFont:[UIFont fontWithName:@"Arial" size:11.0] constrainedToSize:CGSizeMake(self.jianchengView1.yijianLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    _ztextHeight += titleSize.height;
                    _textHeight = titleSize.height;
                    [self.jianchengView1 testPlusHeight:_textHeight];
                    
                    NSDictionary *dateDic = [actors1 objectForKey:@"commentDate"];
                    
                    long time = [[dateDic objectForKey:@"time"] longLongValue]/1000;
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
                    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
                    [outputFormatter setTimeZone:timeZone];
                    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSString *str = [outputFormatter stringFromDate:date];
                    self.jianchengView1.dateLabel.text = str;
                    
                    self.jianchengView1.yijianLabel.text = yijianStr;
                    self.danweiStr = [[actors1 objectForKey:@"commentDeptName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSString *name = [[actors1 objectForKey:@"commentPerson"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSString *zhiwuStr = [[actors1 objectForKey:@"personJob"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    if (![self.danweiStr isEqual:@""]) {
                        if ([zhiwuStr isEqual:[NSNull class]] || [zhiwuStr isEqual:@""]) {
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",name,self.danweiStr];
                        }else{
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@,%@)",name,self.danweiStr,zhiwuStr];
                        }
                    }else{
                        if ([zhiwuStr isEqual:[NSNull class]] || [zhiwuStr isEqual:@""]) {
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@",name];
                        }else{
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",name,zhiwuStr];
                        }
                    }
                
                    [self.courseScroll addSubview:self.jianchengView1.view];
                }
            }}else{
                if (_actarry1.count !=0 && _actarry2.count != 0 && _actarry3.count !=0) {
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"5";
                    self.yuanView1.leixLabel.text = @"签发";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+_actarry1.count*50+_actarry2.count*50+_actarry3.count*50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count !=0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"5";
                    self.yuanView1.leixLabel.text = @"签发";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+_actarry1.count*50+_actarry2.count*50+50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count !=0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+100, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"5";
                    self.yuanView1.leixLabel.text = @"签发";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+_actarry1.count*50+100, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count !=0 && _actarry2.count == 0 && _actarry3.count !=0){
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry3.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"5";
                    self.yuanView1.leixLabel.text = @"签发";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+_actarry1.count*50+_actarry3.count*50+50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count ==0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+150, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"5";
                    self.yuanView1.leixLabel.text = @"签发";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+150, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count ==0 && _actarry2.count != 0 && _actarry3.count !=0){
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry3.count*50+_actarry2.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"5";
                    self.yuanView1.leixLabel.text = @"签发";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+_actarry3.count*50+_actarry2.count*50+50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count ==0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry2.count*50+100, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"5";
                    self.yuanView1.leixLabel.text = @"签发";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+_actarry2.count*50+100, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count ==0 && _actarry2.count == 0 && _actarry3.count !=0){
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry3.count*50+100, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"5";
                    self.yuanView1.leixLabel.text = @"签发";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+_actarry3.count*50+100, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
            }
        
    }
    
    [self.courseScroll setContentSize:CGSizeMake(self.courseScroll.bounds.size.width, (_actarry1.count+_actarry2.count+_actarry3.count+_actarry4.count)*50+400+_ztextHeight)];
}
//收文视图
- (void)shouwenView
{
    UIImageView *viewSt= [[UIImageView alloc]initWithFrame:CGRectMake(40, 0, 2, 20)];
    viewSt.backgroundColor = [UIColor colorWithRed:0 green:117/255.0 blue:255/255.0 alpha:1.0];
    [self.courseScroll addSubview:viewSt];
    
    
    for (int a = 0; a<self.arrayCScontent.count; a++) {
        //收文登记
        if ([[[self.arrayCScontent[a] objectForKey:@"taskName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] isEqual:@"收文登记"]) {
            self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
            self.yuanView1.view.frame = CGRectMake(28, 20, self.yuanView1.ViewY.frame.size.width, 26);
            self.yuanView1.nLabel.text = @"1";
            self.yuanView1.nLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:117/255.0 blue:255/255.0 alpha:1.0];
            self.yuanView1.leixLabel.text = @"收文登记";
            
            self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
            self.jianchengView1.view.frame = CGRectMake(39, 46, self.jianchengView1.ViewJ.frame.size.width, 50);
            
            NSDictionary *contentDic = [[NSDictionary alloc]init];
            contentDic = [self.arrayCScontent objectAtIndex:a];
            NSArray *actarry = [[NSArray alloc]init];
            actarry = [contentDic objectForKey:@"actors"];
            NSDictionary *actors = [[NSDictionary alloc]init];
            actors = [actarry objectAtIndex:0 ];
            
            NSString *date = [[contentDic objectForKey:@"updateDateString"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
            NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
            [inputFormatter setTimeZone:timeZone];
            [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSDate* inputDate = [inputFormatter dateFromString:date];
            NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
            
            [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *strd = [outputFormatter stringFromDate:inputDate];
            self.jianchengView1.dateLabel.text = strd;

            NSString *strb = [[actors objectForKey:@"deptname"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if ([strb rangeOfString:@","].location != NSNotFound) {
                strb = [strb componentsSeparatedByString:@","][1];
                self.danweiStr = strb;
            }else{
                self.danweiStr = strb;
            }
            NSString *name  = [[actors objectForKey:@"username"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *zhiwuStr = [[actors objectForKey:@"personJob"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if (![self.danweiStr isEqual:@""]) {
                if ([zhiwuStr isEqual:[NSNull class]] || [zhiwuStr isEqual:@""]) {
                    self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",name,self.danweiStr];
                }else{
                    self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@,%@)",name,self.danweiStr,zhiwuStr];
                }
            }else{
                if ([zhiwuStr isEqual:[NSNull class]] || [zhiwuStr isEqual:@""]) {
                    self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@",name];
                }else{
                    self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",name,zhiwuStr];
                }
            }

            self.jianchengView1.yijianLabel.hidden = YES;
            [self.courseScroll addSubview:self.yuanView1.view];
            [self.courseScroll addSubview:self.jianchengView1.view];
        }
    }
    
    //拟办意见
    for (int a= 0; a<self.arrayCScomment.count;a++) {
        if (_sactarry1.count != 0) {
            if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"拟办意见"].location != NSNotFound) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                
                self.yuanView1.view.frame = CGRectMake(28, 96, self.yuanView1.ViewY.frame.size.width, 26);
                self.yuanView1.nLabel.text = @"2";
                self.yuanView1.nLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:117/255.0 blue:255/255.0 alpha:1.0];
                self.yuanView1.leixLabel.text = @"拟办意见";
                [self.courseScroll addSubview:self.yuanView1.view];
                NSDictionary *contentDic1 = [[NSDictionary alloc]init];
                contentDic1 = [self.arrayCScomment objectAtIndex:a];
                NSArray *actarry1 = [[NSArray alloc]init];
                actarry1 = [contentDic1 objectForKey:@"content"];
                
                for (long i = 0; i<actarry1.count; i++) {
                    _b++;
                    self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                    self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+122+50*(_b-1), self.jianchengView1.view.frame.size.width, 50);
                    
                    NSDictionary *actors1 = [actarry1 objectAtIndex:i];
                    NSString *yijianStr = [actors1 objectForKey:@"commentContent"];
                    CGSize titleSize = [yijianStr sizeWithFont:[UIFont fontWithName:@"Arial" size:11.0] constrainedToSize:CGSizeMake(self.jianchengView1.yijianLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    _ztextHeight += titleSize.height;
                    _textHeight = titleSize.height;
                    [self.jianchengView1 testPlusHeight:_textHeight];
                    
                    NSDictionary *dateDic = [actors1 objectForKey:@"commentDate"];
                    long time = [[dateDic objectForKey:@"time"] longLongValue]/1000;
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
                    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
                    [outputFormatter setTimeZone:timeZone];
                    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSString *str = [outputFormatter stringFromDate:date];
                    self.jianchengView1.dateLabel.text = str;
                    
                    self.jianchengView1.yijianLabel.text = yijianStr;
                    self.danweiStr = [[actors1 objectForKey:@"commentDeptName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSString *name = [[actors1 objectForKey:@"commentPerson"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSString *zhiwuStr = [[actors1 objectForKey:@"personJob"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    if (![self.danweiStr isEqual:@""]) {
                        if ([zhiwuStr isEqual:[NSNull class]] || [zhiwuStr isEqual:@""]) {
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",name,self.danweiStr];
                        }else{
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@,%@)",name,self.danweiStr,zhiwuStr];
                        }
                    }else{
                        if ([zhiwuStr isEqual:[NSNull class]] || [zhiwuStr isEqual:@""]) {
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@",name];
                        }else{
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",name,zhiwuStr];
                        }
                    }
                    //                self.QCoureH.labelt.text = strd1;
                    [self.courseScroll addSubview:self.jianchengView1.view];
                }
            }}
        else{
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                self.yuanView1.view.frame = CGRectMake(28, 96, self.yuanView1.ViewY.frame.size.width, 26);
                self.yuanView1.nLabel.text = @"2";
                self.yuanView1.leixLabel.text = @"拟办意见";
                [self.courseScroll addSubview:self.yuanView1.view];
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+122, 2, 50)];
                imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                [self.courseScroll addSubview:imageView];
            }
        
    }
    //领导意见
    for (int a= 0; a<self.arrayCScomment.count;a++) {
        if (_sactarry2.count != 0) {
            if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"领导批示"].location != NSNotFound) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_sactarry1.count != 0) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+122+50*_sactarry1.count, self.yuanView1.ViewY.frame.size.width, 26);
                }else{
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+122+50, self.yuanView1.ViewY.frame.size.width, 26);
                }
                
                self.yuanView1.nLabel.text = @"3";
                self.yuanView1.nLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:117/255.0 blue:255/255.0 alpha:1.0];
                self.yuanView1.leixLabel.text = @"领导批示";
                [self.courseScroll addSubview:self.yuanView1.view];
                NSDictionary *contentDic1 = [[NSDictionary alloc]init];
                contentDic1 = [self.arrayCScomment objectAtIndex:a];
                NSArray *actarry1 = [[NSArray alloc]init];
                actarry1 = [contentDic1 objectForKey:@"content"];
                
                for (long i = 0; i<actarry1.count; i++) {
                    _c++;
                    self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                    if (_sactarry1.count != 0) {
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+148+50*_sactarry1.count+50*(_c-1), self.jianchengView1.view.frame.size.width, 50);
                    }else{
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+148+50+50*(_c-1), self.jianchengView1.view.frame.size.width, 50);
                    }
                    
                    NSDictionary *actors1 = [actarry1 objectAtIndex:i];
                    NSString *yijianStr = [actors1 objectForKey:@"commentContent"];
                    CGSize titleSize = [yijianStr sizeWithFont:[UIFont fontWithName:@"Arial" size:11.0] constrainedToSize:CGSizeMake(self.jianchengView1.yijianLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    _ztextHeight += titleSize.height;
                    _textHeight = titleSize.height;
                    [self.jianchengView1 testPlusHeight:_textHeight];
                    
                    NSDictionary *dateDic = [actors1 objectForKey:@"commentDate"];
                    long time = [[dateDic objectForKey:@"time"] longLongValue]/1000;
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
                    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
                    [outputFormatter setTimeZone:timeZone];
                    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSString *str = [outputFormatter stringFromDate:date];
                    self.jianchengView1.dateLabel.text = str;
                    
                    self.jianchengView1.yijianLabel.text = yijianStr;
                    self.danweiStr = [[actors1 objectForKey:@"commentDeptName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSString *name = [[actors1 objectForKey:@"commentPerson"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSString *zhiwuStr = [[actors1 objectForKey:@"personJob"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    if (![self.danweiStr isEqual:@""]) {
                        if ([zhiwuStr isEqual:[NSNull class]] || [zhiwuStr isEqual:@""]) {
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",name,self.danweiStr];
                        }else{
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@,%@)",name,self.danweiStr,zhiwuStr];
                        }
                    }else{
                        if ([zhiwuStr isEqual:[NSNull class]] || [zhiwuStr isEqual:@""]) {
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@",name];
                        }else{
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",name,zhiwuStr];
                        }
                    }

                    [self.courseScroll addSubview:self.jianchengView1.view];
                }
            }}else{
                if (_sactarry1.count !=0) {
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+122+50*_sactarry1.count, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"3";
                    self.yuanView1.leixLabel.text = @"领导批示";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+148+50*_sactarry1.count, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else{
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+122+50, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"3";
                    self.yuanView1.leixLabel.text = @"领导批示";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+148+50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
            }
        
    }
    //部门意见
    for (int a= 0; a<self.arrayCScomment.count;a++) {
        if (_sactarry3.count != 0) {
            if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"部门意见"].location != NSNotFound) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_sactarry1.count != 0 && _sactarry2.count != 0) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_sactarry1.count*50+_sactarry2.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                }else if (_sactarry1.count != 0 && _sactarry2.count == 0) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_sactarry1.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                }else if (_sactarry1.count == 0 && _sactarry2.count != 0) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_sactarry2.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                }else if (_sactarry1.count == 0 && _sactarry2.count == 0) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+100, self.yuanView1.ViewY.frame.size.width, 26);
                }
                
                self.yuanView1.nLabel.text = @"4";
                self.yuanView1.nLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:117/255.0 blue:255/255.0 alpha:1.0];
                self.yuanView1.leixLabel.text = @"部门意见";
                [self.courseScroll addSubview:self.yuanView1.view];
                NSDictionary *contentDic1 = [[NSDictionary alloc]init];
                contentDic1 = [self.arrayCScomment objectAtIndex:a];
                NSArray *actarry1 = [[NSArray alloc]init];
                actarry1 = [contentDic1 objectForKey:@"content"];
                
                for (long i = 0; i<actarry1.count; i++) {
                    _d++;
                    self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                    if (_sactarry1.count != 0 && _sactarry2.count != 0) {
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+_sactarry1.count*50+_sactarry2.count*50+50*(_d-1), self.jianchengView1.view.frame.size.width, 50);
                    }else if (_sactarry1.count != 0 && _sactarry2.count == 0) {
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+_sactarry1.count*50+50+50*(_d-1), self.jianchengView1.view.frame.size.width, 50);
                    }else if (_sactarry1.count == 0 && _sactarry2.count != 0) {
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+_sactarry2.count*50+50+50*(_d-1), self.jianchengView1.view.frame.size.width, 50);
                    }else if (_sactarry1.count == 0 && _sactarry2.count == 0) {
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+100+50*(_d-1), self.jianchengView1.view.frame.size.width, 50);
                    }
                    
                    
                    NSDictionary *actors1 = [actarry1 objectAtIndex:i];
                    NSString *yijianStr = [actors1 objectForKey:@"commentContent"];
                    CGSize titleSize = [yijianStr sizeWithFont:[UIFont fontWithName:@"Arial" size:11.0] constrainedToSize:CGSizeMake(self.jianchengView1.yijianLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    _ztextHeight += titleSize.height;
                    _textHeight = titleSize.height;
                    [self.jianchengView1 testPlusHeight:_textHeight];
                    NSDictionary *dateDic = [actors1 objectForKey:@"commentDate"];
                    self.jianchengView1.yijianLabel.text = yijianStr;
                    long time = [[dateDic objectForKey:@"time"] longLongValue]/1000;
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
                    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
                    [outputFormatter setTimeZone:timeZone];
                    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSString *str = [outputFormatter stringFromDate:date];
                    self.jianchengView1.dateLabel.text = str;
                    
                    self.danweiStr = [[actors1 objectForKey:@"commentDeptName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSString *name = [[actors1 objectForKey:@"commentPerson"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSString *zhiwuStr = [[actors1 objectForKey:@"personJob"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    if (![self.danweiStr isEqual:@""]) {
                        if ([zhiwuStr isEqual:[NSNull class]] || [zhiwuStr isEqual:@""]) {
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",name,self.danweiStr];
                        }else{
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@,%@)",name,self.danweiStr,zhiwuStr];
                        }
                    }else{
                        if ([zhiwuStr isEqual:[NSNull class]] || [zhiwuStr isEqual:@""]) {
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@",name];
                        }else{
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",name,zhiwuStr];
                        }
                    }

                    [self.courseScroll addSubview:self.jianchengView1.view];
                }
            }}else{
                if (_sactarry1.count !=0 && _sactarry2.count !=0) {
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_sactarry1.count*50+_sactarry2.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"4";
                    self.yuanView1.leixLabel.text = @"部门意见";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50*_sactarry1.count+_sactarry2.count*50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if (_sactarry1.count !=0 && _sactarry2.count ==0){
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_sactarry1.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"4";
                    self.yuanView1.leixLabel.text = @"部门意见";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50*_sactarry1.count+50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if (_sactarry1.count ==0 && _sactarry2.count !=0){
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_sactarry2.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"4";
                    self.yuanView1.leixLabel.text = @"部门意见";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50*_sactarry2.count+50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if (_sactarry1.count ==0 && _sactarry2.count ==0){
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+100, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"4";
                    self.yuanView1.leixLabel.text = @"部门意见";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+100, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
            }
        
    }
    //办理结果
    for (int a= 0; a<self.arrayCScomment.count;a++) {
        if (_sactarry4.count != 0) {
            if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"办理结果"].location != NSNotFound) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_sactarry1.count !=0 && _sactarry2.count != 0 && _sactarry3.count !=0) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_sactarry1.count*50+_sactarry2.count*50+_sactarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                }else if(_sactarry1.count !=0 && _sactarry2.count != 0 && _sactarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_sactarry1.count*50+_sactarry2.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                }else if(_sactarry1.count !=0 && _sactarry2.count == 0 && _sactarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_sactarry1.count*50+100, self.yuanView1.ViewY.frame.size.width, 26);
                }else if(_sactarry1.count !=0 && _sactarry2.count == 0 && _sactarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_sactarry1.count*50+50+_sactarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                }else if(_sactarry1.count ==0 && _sactarry2.count == 0 && _sactarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+150, self.yuanView1.ViewY.frame.size.width, 26);
                }else if(_sactarry1.count ==0 && _sactarry2.count != 0 && _sactarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_sactarry2.count*50+_sactarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                }else if(_sactarry1.count ==0 && _sactarry2.count != 0 && _sactarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_sactarry2.count*50+100, self.yuanView1.ViewY.frame.size.width, 26);
                }else if(_sactarry1.count ==0 && _sactarry2.count == 0 && _sactarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+_sactarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                }
                self.yuanView1.nLabel.text = @"5";
                self.yuanView1.nLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:117/255.0 blue:255/255.0 alpha:1.0];
                self.yuanView1.leixLabel.text = @"办理结果";
                [self.courseScroll addSubview:self.yuanView1.view];
                NSDictionary *contentDic1 = [[NSDictionary alloc]init];
                contentDic1 = [self.arrayCScomment objectAtIndex:a];
                NSArray *actarry1 = [[NSArray alloc]init];
                actarry1 = [contentDic1 objectForKey:@"content"];
                
                for (long i = 0; i<actarry1.count; i++) {
                    _e++;
                    self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                    if (_sactarry1.count !=0 && _sactarry2.count != 0 && _sactarry3.count !=0) {
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_sactarry1.count*50+_sactarry2.count*50+_sactarry3.count*50+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                    }else if(_sactarry1.count !=0 && _sactarry2.count != 0 && _sactarry3.count ==0){
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_sactarry1.count*50+_sactarry2.count*50+50+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                    }else if(_sactarry1.count !=0 && _sactarry2.count == 0 && _sactarry3.count ==0){
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_sactarry1.count*50+100+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                    }else if(_sactarry1.count !=0 && _sactarry2.count == 0 && _sactarry3.count !=0){
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_sactarry1.count*50+50+_sactarry3.count*50+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                    }else if(_sactarry1.count ==0 && _sactarry2.count == 0 && _sactarry3.count ==0){
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+150+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                    }else if(_sactarry1.count ==0 && _sactarry2.count != 0 && _sactarry3.count !=0){
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+50+_sactarry2.count*50+_sactarry3.count*50+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                    }else if(_sactarry1.count ==0 && _sactarry2.count != 0 && _sactarry3.count ==0){
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_sactarry2.count*50+100+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                    }else if(_sactarry1.count ==0 && _sactarry2.count == 0 && _sactarry3.count !=0){
                        self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+100+_sactarry3.count*50+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                    }
                    
                    NSDictionary *actors1 = [actarry1 objectAtIndex:i];
                    NSString *yijianStr = [actors1 objectForKey:@"commentContent"];
                    CGSize titleSize = [yijianStr sizeWithFont:[UIFont fontWithName:@"Arial" size:11.0] constrainedToSize:CGSizeMake(self.jianchengView1.yijianLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    _ztextHeight += titleSize.height;
                    _textHeight = titleSize.height;
                    [self.jianchengView1 testPlusHeight:_textHeight];
                    
                    NSDictionary *dateDic = [actors1 objectForKey:@"commentDate"];
                    
                    long time = [[dateDic objectForKey:@"time"] longLongValue]/1000;
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
                    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
                    [outputFormatter setTimeZone:timeZone];
                    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSString *str = [outputFormatter stringFromDate:date];
                    self.jianchengView1.dateLabel.text = str;
                    
                    self.jianchengView1.yijianLabel.text = yijianStr;
                    
                    self.danweiStr = [[actors1 objectForKey:@"commentDeptName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSString *name = [[actors1 objectForKey:@"commentPerson"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSString *zhiwuStr = [[actors1 objectForKey:@"personJob"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    if (![self.danweiStr isEqual:@""]) {
                        if ([zhiwuStr isEqual:[NSNull class]] || [zhiwuStr isEqual:@""]) {
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",name,self.danweiStr];
                        }else{
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@,%@)",name,self.danweiStr,zhiwuStr];
                        }
                    }else{
                        if ([zhiwuStr isEqual:[NSNull class]] || [zhiwuStr isEqual:@""]) {
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@",name];
                        }else{
                            self.jianchengView1.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",name,zhiwuStr];
                        }
                    }
                    

                    [self.courseScroll addSubview:self.jianchengView1.view];
                }
            }}else{
                if (_sactarry1.count !=0 && _sactarry2.count != 0 && _sactarry3.count !=0) {
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_sactarry1.count*50+_sactarry2.count*50+_sactarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"5";
                    self.yuanView1.leixLabel.text = @"办理结果";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+_sactarry1.count*50+_sactarry2.count*50+_sactarry3.count*50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_sactarry1.count !=0 && _sactarry2.count != 0 && _sactarry3.count ==0){
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_sactarry1.count*50+_sactarry2.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"5";
                    self.yuanView1.leixLabel.text = @"办理结果";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+_sactarry1.count*50+_sactarry2.count*50+50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_sactarry1.count !=0 && _sactarry2.count == 0 && _sactarry3.count ==0){
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_sactarry1.count*50+100, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"5";
                    self.yuanView1.leixLabel.text = @"办理结果";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+_sactarry1.count*50+100, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_sactarry1.count !=0 && _sactarry2.count == 0 && _sactarry3.count !=0){
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_sactarry1.count*50+_sactarry3.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"5";
                    self.yuanView1.leixLabel.text = @"办理结果";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+_sactarry1.count*50+_sactarry3.count*50+50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_sactarry1.count ==0 && _sactarry2.count == 0 && _sactarry3.count ==0){
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+150, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"5";
                    self.yuanView1.leixLabel.text = @"办理结果";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+150, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_sactarry1.count ==0 && _sactarry2.count != 0 && _sactarry3.count !=0){
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_sactarry3.count*50+_sactarry2.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"5";
                    self.yuanView1.leixLabel.text = @"办理结果";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+_sactarry3.count*50+_sactarry2.count*50+50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_sactarry1.count ==0 && _sactarry2.count != 0 && _sactarry3.count ==0){
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_sactarry2.count*50+100, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"5";
                    self.yuanView1.leixLabel.text = @"办理结果";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+_sactarry2.count*50+100, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_sactarry1.count ==0 && _sactarry2.count == 0 && _sactarry3.count !=0){
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_sactarry3.count*50+100, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"5";
                    self.yuanView1.leixLabel.text = @"办理结果";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+_sactarry3.count*50+100, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
            }
    }
    [self.courseScroll setContentSize:CGSizeMake(self.courseScroll.bounds.size.width, (_sactarry1.count+_sactarry2.count+_sactarry3.count+_sactarry4.count)*50+400+_ztextHeight)];
}



@end
