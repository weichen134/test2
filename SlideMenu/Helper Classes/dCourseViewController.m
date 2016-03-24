//
//  dCourseViewController.m
//  SlideMenu
//
//  Created by main on 15/9/17.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "dCourseViewController.h"
#import "HomeViewController.h"
#import "SlideNavigationController.h"
#import "yuanView.h"
#import "jianchengView.h"

#import "AFHTTPRequestOperationManager.h"
#import "ExamineViewController.h"
#import "User.h"
@interface dCourseViewController ()
@property (nonatomic,strong)yuanView *yuanView1;
@property (nonatomic,strong)ExamineViewController *otherView;

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
//@property (nonatomic,strong)NSArray *sactarry1;
//@property (nonatomic,strong)NSArray *sactarry2;
//@property (nonatomic,strong)NSArray *sactarry3;
//@property (nonatomic,strong)NSArray *sactarry4;
@property (nonatomic,strong)NSArray *arrayCScomment;
@property (nonatomic,strong)NSArray *arrayCScontent;

@property (nonatomic)float textHeight;
@property (nonatomic)float ztextHeight;

@property (nonatomic,strong)NSString *userposition;
@property (nonatomic,strong)NSString *Cstr;
@end

@implementation dCourseViewController
@synthesize bwsmStr;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.yijianView1 = [[yijianView alloc]initWithNibName:@"yijianView" bundle:nil];
    self.yijianView2 = [[yijianViewZ alloc]initWithNibName:@"yijianViewZ" bundle:nil];
    
    self.imageView1 = [[UIImageView alloc]init];
    self.imageView2 = [[UIImageView alloc]init];
    self.imageView3 = [[UIImageView alloc]init];
    self.imageView4 = [[UIImageView alloc]init];
    
    self.courseScroll.delegate = self;
    self.courseScroll.userInteractionEnabled = YES;
    self.courseScroll.scrollEnabled =YES;
    self.courseScroll.directionalLockEnabled = NO;
    self.courseScroll.canCancelContentTouches = NO;
    self.courseScroll.showsHorizontalScrollIndicator = NO;
    self.courseScroll.showsVerticalScrollIndicator = NO;
    self.courseScroll.bounces = NO;
    //    UITapGestureRecognizer *tapGestureTel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(courseScrollTouch)];
    //    self.courseScroll.userInteractionEnabled = YES;
    //    [self.courseScroll addGestureRecognizer:tapGestureTel];
    
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
////ScrollView点击事件
//-(void)courseScrollTouch
//{
//    [self.yijianView1.shuomingTextView resignFirstResponder];
//    [self.yijianView1.yijianTextView resignFirstResponder];
//}

- (void)touchPop
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//详情数据
- (void)xiangqingData
{
    NSDictionary *dic = @{@"loginname":self.loginName};
    NSString *url = [NSString stringWithFormat:@"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=getWorkflowContent&instanceGUID=%@",self.instanceID];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *Manager = [AFHTTPRequestOperationManager manager];
    [Manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] isEqual:@1]||[[responseObject objectForKey:@"success"] isEqual:@"ture"]) {
            self.CommentType = [responseObject objectForKey:@"CommentType"];
            self.arrayCScomment = [responseObject objectForKey:@"comment"];
            self.taskNameStr = [[responseObject objectForKey:@"task_name"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            //        self.CourseContentDic = [responseObject objectForKey:@"content"];
            for (int a = 0; a<self.arrayCScomment.count; a++) {
                //收文
                //发文
                //第三个
                if ([self.subAppname rangeOfString:@"发文"].location != NSNotFound || [self.subAppname rangeOfString:@"会签"].location != NSNotFound) {
                    if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"核稿"].location != NSNotFound){
                        //                NSDictionary *contentDic1 = [[NSDictionary alloc]init];
                        //                contentDic1 = [self.arrayCScomment objectAtIndex:a];
                        //FIX2
                        NSDictionary *contentDic1  = [self.arrayCScomment objectAtIndex:a];
                        _actarry1 = [[NSArray alloc]init];
                        _actarry1 = [contentDic1 objectForKey:@"content"];
                    }
                    if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"会签"].location != NSNotFound){
                        NSDictionary *contentDic1 = [self.arrayCScomment objectAtIndex:a];
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
                    if ([self.CommentType isEqual:[self.arrayCScomment[a] objectForKey:@"commentGUID"]]) {
                        if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"核稿"].location != NSNotFound) {
                            self.taskStr = @"核稿";
                        }
                        else if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"会签"].location != NSNotFound) {
                            self.taskStr = @"会签";
                        }
                        else if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"核签"].location != NSNotFound) {
                            self.taskStr = @"核签";
                        }
                        else if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"签发"].location != NSNotFound) {
                            self.taskStr = @"签发";
                        }
                    }
                }
                else if([self.subAppname rangeOfString:@"收文"].location != NSNotFound)
                {
                    if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"拟办意见"].location != NSNotFound){
                        NSDictionary *contentDic1  = [self.arrayCScomment objectAtIndex:a];
                        _actarry1 = [[NSArray alloc]init];
                        _actarry1 = [contentDic1 objectForKey:@"content"];
                    }
                    if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"领导批示"].location != NSNotFound){
                        NSDictionary *contentDic1  = [self.arrayCScomment objectAtIndex:a];
                        _actarry2 = [[NSArray alloc]init];
                        _actarry2 = [contentDic1 objectForKey:@"content"];
                    }
                    if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"部门意见"].location != NSNotFound){
                        NSDictionary *contentDic1  = [self.arrayCScomment objectAtIndex:a];
                        _actarry3 = [[NSArray alloc]init];
                        _actarry3 = [contentDic1 objectForKey:@"content"];
                    }
                    if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"办理结果"].location != NSNotFound){
                        NSDictionary *contentDic1  = [self.arrayCScomment objectAtIndex:a];
                        _actarry4 = [[NSArray alloc]init];
                        _actarry4 = [contentDic1 objectForKey:@"content"];
                    }
                    if ([self.CommentType isEqual:[self.arrayCScomment[a] objectForKey:@"commentGUID"]]) {
                        if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"拟办意见"].location != NSNotFound) {
                            self.taskStr = @"拟办意见";
                        }
                        else if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"领导批示"].location != NSNotFound) {
                            self.taskStr = @"领导批示";
                        }
                        else if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"部门意见"].location != NSNotFound) {
                            self.taskStr = @"部门意见";
                        }
                        else if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"办理结果"].location != NSNotFound) {
                            self.taskStr = @"办理结果";
                        }
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
                if (self.zhiwuArray.count == 2) {
                    [self.yijianView2.zhiWuBt1 setTitle:[self.zhiwuArray[0] objectForKey:@"name"] forState:UIControlStateNormal];
                    [self.yijianView2.zhiWuBt2 setTitle:[self.zhiwuArray[1] objectForKey:@"name"] forState:UIControlStateNormal];
                    [self.yijianView2.zhiWuBt1 addTarget:self action:@selector(zhiWuBt1) forControlEvents:UIControlEventTouchDown];
                    [self.yijianView2.zhiWuBt2 addTarget:self action:@selector(zhiWuBt2) forControlEvents:UIControlEventTouchDown];
                }
            }else if([self.subAppname rangeOfString:@"收文"].location != NSNotFound)
            {
                [self shouwenView];
                if (self.zhiwuArray.count == 2) {
                    [self.yijianView2.zhiWuBt1 setTitle:[self.zhiwuArray[0] objectForKey:@"name"] forState:UIControlStateNormal];
                    [self.yijianView2.zhiWuBt2 setTitle:[self.zhiwuArray[1] objectForKey:@"name"] forState:UIControlStateNormal];
                    [self.yijianView2.zhiWuBt1 addTarget:self action:@selector(zhiWuBt1) forControlEvents:UIControlEventTouchDown];
                    [self.yijianView2.zhiWuBt2 addTarget:self action:@selector(zhiWuBt2) forControlEvents:UIControlEventTouchDown];
                }
            }else if ([self.subAppname rangeOfString:@"加班"].location != NSNotFound)
            {
                [self otherViewControll];
            }
            else if ([self.subAppname rangeOfString:@"出差"].location != NSNotFound)
            {
                [self otherViewControll];
            }else if ([self.subAppname rangeOfString:@"请假"].location != NSNotFound)
            {
                [self otherViewControll];
            }
            
            //            UILabel *taskLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-30, self.view.bounds.size.width, 30)];
            //            taskLabel.backgroundColor = [UIColor colorWithRed:253/255.0 green:126/255.0 blue:6/255.0 alpha:1.0];
            //            taskLabel.textAlignment = NSTextAlignmentCenter;
            //            taskLabel.font = [UIFont boldSystemFontOfSize:15];
            //            taskLabel.textColor = [UIColor whiteColor];
            //            taskLabel.text = self.taskNameStr;
            //            [self.view addSubview:taskLabel];
        }else{
            [self shujuyichang];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self fuwuyichang];
    }];
}

- (void)zhiWuBt1
{
    [self.yijianView2.zhiWuBt1 setImage:[UIImage imageNamed:@"RadioButton-Selected"] forState:UIControlStateNormal];
    self.userposition = [self.zhiwuArray[0] objectForKey:@"name"];
    [self.yijianView2.zhiWuBt2 setImage:[UIImage imageNamed:@"RadioButton-Unselected"] forState:UIControlStateNormal];
}
- (void)zhiWuBt2
{
    [self.yijianView2.zhiWuBt2 setImage:[UIImage imageNamed:@"RadioButton-Selected"] forState:UIControlStateNormal];
    self.userposition = [self.zhiwuArray[1] objectForKey:@"name"];
    [self.yijianView2.zhiWuBt1 setImage:[UIImage imageNamed:@"RadioButton-Unselected"] forState:UIControlStateNormal];
}

//职务数据请求
- (void)zhiwuData
{
    NSDictionary *dic = @{@"loginname":self.loginName,
                          };
    NSString *url = [NSString stringWithFormat:@"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=position"];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *Manager = [AFHTTPRequestOperationManager manager];
    [Manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"success"] isEqual:@1]||[[responseObject objectForKey:@"success"] isEqual:@"ture"]) {
            if (![[responseObject objectForKey:@"content"] isEqual:@""]) {
                self.zhiwuArray = [responseObject objectForKey:@"content"];
                if (self.zhiwuArray.count !=0) {
                    self.userposition = [self.zhiwuArray[0] objectForKey:@"name"];
                }
            }else{
                self.userposition = @"";
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
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
            [outputFormatter setLocale:[NSLocale currentLocale]];
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
            if (![self.danweiStr isEqual:@""]){
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
                    self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+ 122+50*(_b-1), self.jianchengView1.view.frame.size.width, 50);
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
                    [outputFormatter setLocale:[NSLocale currentLocale]];
                    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSString *str = [outputFormatter stringFromDate:date];
                    self.jianchengView1.dateLabel.text = str;
                    self.jianchengView1.yijianLabel.text = [[actors1 objectForKey:@"commentContent"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    
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
                    //横条颜色变化
                    if([self.taskStr isEqual:@"核稿"])
                    {
                        if (self.zhiwuArray.count == 2) {
                            self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+122+50*_actarry1.count, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                            [self.courseScroll addSubview:self.yijianView2.view];
                        }else{
                            
                            self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+122+50*_actarry1.count, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                            [self.courseScroll addSubview:self.yijianView1.view];
                            CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                            [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                        }
                        [self yijianText];
                    }
                    
                    [self.courseScroll addSubview:self.jianchengView1.view];
                }
            }}else{
                if ([self.taskStr isEqual:@"核稿"]) {
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, 122, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, 122, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                        
                    }
                    
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, 96, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"2";
                    self.yuanView1.leixLabel.text = @"核稿";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    [self yijianText];
                } else {
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, 96, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"2";
                    self.yuanView1.leixLabel.text = @"核稿";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 122, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
            }
        
    }
    //会签
    for (int a= 0; a<self.arrayCScomment.count;a++) {
        if (_actarry2.count != 0) {
            if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"会签"].location != NSNotFound) {
                if (_actarry1.count != 0) {
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    
                    if ([self.taskStr isEqual:@"核稿"]){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+122+_actarry1.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    else{
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+122+_actarry1.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    self.yuanView1.nLabel.text = @"3";
                    self.yuanView1.nLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:117/255.0 blue:255/255.0 alpha:1.0];
                    self.yuanView1.leixLabel.text = @"会签";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    NSDictionary *contentDic1 = [[NSDictionary alloc]init];
                    contentDic1 = [self.arrayCScomment objectAtIndex:a];
                    NSArray *actarry1 = [[NSArray alloc]init];
                    actarry1 = [contentDic1 objectForKey:@"content"];
                    if ([self.taskStr isEqual:@"核稿"]) {
                        for (long i = 0; i<actarry1.count; i++) {
                            _c++;
                            self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+148+_actarry1.count*50+50*(_c-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            NSDictionary *actors1 = [actarry1 objectAtIndex:i];
                            NSString *yijianStr = [actors1 objectForKey:@"commentContent"];
                            CGSize titleSize = [yijianStr sizeWithFont:[UIFont fontWithName:@"Arial" size:11.0] constrainedToSize:CGSizeMake(self.jianchengView1.yijianLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                            _ztextHeight += titleSize.height;
                            _textHeight = titleSize.height;
                            [self.jianchengView1 testPlusHeight:_textHeight];
                            self.jianchengView1.yijianLabel.text = yijianStr;
                            
                            NSDictionary *dateDic = [actors1 objectForKey:@"commentDate"];
                            long time = [[dateDic objectForKey:@"time"] longLongValue]/1000;
                            NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
                            NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                            NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
                            [outputFormatter setTimeZone:timeZone];
                            [outputFormatter setLocale:[NSLocale currentLocale]];
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
                    }
                    else{
                        for (long i = 0; i<actarry1.count; i++) {
                            _c++;
                            self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+148+_actarry1.count*50+50*(_c-1), self.jianchengView1.view.frame.size.width, 50);
                            NSDictionary *actors1 = [actarry1 objectAtIndex:i];
                            NSString *yijianStr = [actors1 objectForKey:@"commentContent"];
                            CGSize titleSize = [yijianStr sizeWithFont:[UIFont fontWithName:@"Arial" size:11.0] constrainedToSize:CGSizeMake(self.jianchengView1.yijianLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                            _ztextHeight += titleSize.height;
                            _textHeight = titleSize.height;
                            [self.jianchengView1 testPlusHeight:_textHeight];
                            self.jianchengView1.yijianLabel.text = yijianStr;
                            
                            NSDictionary *dateDic = [actors1 objectForKey:@"commentDate"];
                            long time = [[dateDic objectForKey:@"time"] longLongValue]/1000;
                            NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
                            NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                            NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
                            [outputFormatter setTimeZone:timeZone];
                            [outputFormatter setLocale:[NSLocale currentLocale]];
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
                            //                self.QCoureH.labelt.text = strd1;
                            if ([self.taskStr isEqual:@"会签"]){
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+148+50*_actarry1.count+_actarry2.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+148+50*_actarry1.count+_actarry2.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                
                                [self yijianText];
                            }
                            [self.courseScroll addSubview:self.jianchengView1.view];
                        }
                    }
                    
                }
                else{
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    if ([self.taskStr isEqual:@"核稿"]) {
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+122+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    else{
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
                    if ([self.taskStr isEqual:@"核稿"]) {
                        for (long i = 0; i<actarry1.count; i++) {
                            _c++;
                            self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+148+50+50*(_c-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            
                            NSDictionary *actors1 = [actarry1 objectAtIndex:i];
                            NSString *yijianStr = [actors1 objectForKey:@"commentContent"];
                            CGSize titleSize = [yijianStr sizeWithFont:[UIFont fontWithName:@"Arial" size:11.0] constrainedToSize:CGSizeMake(self.jianchengView1.yijianLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                            _ztextHeight += titleSize.height;
                            _textHeight = titleSize.height;
                            [self.jianchengView1 testPlusHeight:_textHeight];
                            self.jianchengView1.yijianLabel.text = yijianStr;
                            
                            NSDictionary *dateDic = [actors1 objectForKey:@"commentDate"];
                            long time = [[dateDic objectForKey:@"time"] longLongValue]/1000;
                            NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
                            NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                            NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
                            [outputFormatter setTimeZone:timeZone];
                            [outputFormatter setLocale:[NSLocale currentLocale]];
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
                    }
                    else{
                        for (long i = 0; i<actarry1.count; i++) {
                            _c++;
                            self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+148+50+50*(_c-1), self.jianchengView1.view.frame.size.width, 50);
                            
                            NSDictionary *actors1 = [actarry1 objectAtIndex:i];
                            NSString *yijianStr = [actors1 objectForKey:@"commentContent"];
                            CGSize titleSize = [yijianStr sizeWithFont:[UIFont fontWithName:@"Arial" size:11.0] constrainedToSize:CGSizeMake(self.jianchengView1.yijianLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                            _ztextHeight += titleSize.height;
                            _textHeight = titleSize.height;
                            [self.jianchengView1 testPlusHeight:_textHeight];
                            self.jianchengView1.yijianLabel.text = yijianStr;
                            
                            NSDictionary *dateDic = [actors1 objectForKey:@"commentDate"];
                            long time = [[dateDic objectForKey:@"time"] longLongValue]/1000;
                            NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
                            NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                            NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
                            [outputFormatter setTimeZone:timeZone];
                            [outputFormatter setLocale:[NSLocale currentLocale]];
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
                            if([self.taskStr isEqual:@"会签"])
                            {
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+148+50+_actarry2.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+148+50+_actarry2.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                [self yijianText];
                            }
                            [self.courseScroll addSubview:self.jianchengView1.view];
                        }
                    }
                    
                }
            }}else{
                if (_actarry1.count !=0) {
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    if ([self.taskStr isEqual:@"核稿"]) {
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+122+50*_actarry1.count+204, self.yuanView1.ViewY.frame.size.width, 26);
                    }else{
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+122+50*_actarry1.count, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    
                    self.yuanView1.nLabel.text = @"3";
                    self.yuanView1.leixLabel.text = @"会签";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    if ([self.taskStr isEqual:@"会签"]) {
                        if (self.zhiwuArray.count == 2) {
                            self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+148+50*_actarry1.count, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                            [self.courseScroll addSubview:self.yijianView2.view];
                        }else{
                            self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+148+50*_actarry1.count, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                            [self.courseScroll addSubview:self.yijianView1.view];
                            CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                            [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                        }
                        
                        [self yijianText];
                    }else if ([self.taskStr isEqual:@"核稿"]){
                        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+148+50*_actarry1.count+204, 2, 50)];
                        imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                        [self.courseScroll addSubview:imageView];
                    }else{
                        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+148+50*_actarry1.count, 2, 50)];
                        imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                        [self.courseScroll addSubview:imageView];
                    }
                }else{
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    if ([self.taskStr isEqual:@"核稿"]) {
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+122+204, self.yuanView1.ViewY.frame.size.width, 26);
                    }else{
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+122+50, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    self.yuanView1.nLabel.text = @"3";
                    self.yuanView1.leixLabel.text = @"会签";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    if ([self.taskStr isEqual:@"会签"]) {
                        if (self.zhiwuArray.count == 2) {
                            self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+148+50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                            [self.courseScroll addSubview:self.yijianView2.view];
                        }else{
                            self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+148+50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                            [self.courseScroll addSubview:self.yijianView1.view];
                            CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                            [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                        }
                        
                        [self yijianText];
                    }else if ([self.taskStr isEqual:@"核稿"]) {
                        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+148+204,2, 50)];
                        imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                        [self.courseScroll addSubview:imageView];
                    }else{
                        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+148+50,2, 50)];
                        imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                        [self.courseScroll addSubview:imageView];
                    }
                }
            }
        
    }
    //核签
    for (int a= 0; a<self.arrayCScomment.count;a++) {
        if (_actarry3.count != 0) {
            if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"核签"].location != NSNotFound) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if ([self.taskStr isEqual:@"核稿"]||[self.taskStr isEqual:@"会签"]) {
                    if (_actarry1.count != 0 && _actarry2.count != 0 ) {
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    else if(_actarry1.count != 0 && _actarry2.count ==0){
                        if ([self.taskStr isEqual:@"会签"]) {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        } else {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        }
                        
                    }
                    else if(_actarry1.count == 0 && _actarry2.count !=0){
                        if ([self.taskStr isEqual:@"核稿"]) {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        } else {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry2.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        }
                        
                    }
                    else if(_actarry1.count == 0 && _actarry2.count ==0){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                }
                else {
                    if (_actarry1.count != 0 && _actarry2.count != 0 ) {
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+_actarry2.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    }else if(_actarry1.count != 0 && _actarry2.count ==0){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    }else if(_actarry1.count == 0 && _actarry2.count !=0){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry2.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    }else if(_actarry1.count == 0 && _actarry2.count ==0){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+100, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                }
                
                self.yuanView1.nLabel.text = @"4";
                self.yuanView1.nLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:117/255.0 blue:255/255.0 alpha:1.0];
                self.yuanView1.leixLabel.text = @"核签";
                [self.courseScroll addSubview:self.yuanView1.view];
                NSDictionary *contentDic1 = [[NSDictionary alloc]init];
                contentDic1 = [self.arrayCScomment objectAtIndex:a];
                NSArray *actarry1 = [[NSArray alloc]init];
                actarry1 = [contentDic1 objectForKey:@"content"];
                
                if ([self.taskStr isEqual:@"核稿"]||[self.taskStr isEqual:@"会签"]) {
                    for (long i = 0; i<actarry1.count; i++) {
                        _d++;
                        self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                        if (_actarry1.count != 0 && _actarry2.count != 0 ) {
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+50*(_d-1)+204, self.jianchengView1.view.frame.size.width, 50);
                        }
                        else if(_actarry1.count != 0 && _actarry2.count ==0){
                            if ([self.taskStr isEqual:@"会签"]) {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+_actarry1.count*50+50*(_d-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            } else {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+_actarry1.count*50+50+50*(_d-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            }
                            
                        }
                        else if(_actarry1.count == 0 && _actarry2.count !=0){
                            if ([self.taskStr isEqual:@"核稿"]) {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+_actarry2.count*50+50*(_d-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            } else {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+50+_actarry2.count*50+50*(_d-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            }
                            
                        }else if(_actarry1.count == 0 && _actarry2.count ==0){
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+50+50*(_d-1)+204, self.jianchengView1.view.frame.size.width, 50);
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
                        [outputFormatter setLocale:[NSLocale currentLocale]];
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
                }
                else{
                    for (long i = 0; i<actarry1.count; i++) {
                        _d++;
                        self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                        if (_actarry1.count != 0 && _actarry2.count != 0 ) {
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+50*(_d-1), self.jianchengView1.view.frame.size.width, 50);
                        }else if(_actarry1.count != 0 && _actarry2.count ==0){
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+_actarry1.count*50+50+50*(_d-1), self.jianchengView1.view.frame.size.width, 50);
                        }else if(_actarry1.count == 0 && _actarry2.count !=0){
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+50+_actarry2.count*50+50*(_d-1), self.jianchengView1.view.frame.size.width, 50);
                        }else if(_actarry1.count == 0 && _actarry2.count ==0){
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
                        [outputFormatter setLocale:[NSLocale currentLocale]];
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
                        
                        if([self.taskStr isEqual:@"核签"])
                        {
                            if (_actarry1.count != 0 && _actarry2.count != 0 ) {
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                
                            }else if(_actarry1.count != 0 && _actarry2.count ==0){
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50+_actarry3.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50+_actarry3.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                
                            }else if(_actarry1.count == 0 && _actarry2.count !=0){
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+174+50+50*_actarry2.count+_actarry3.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+174+50+50*_actarry2.count+_actarry3.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                
                            }else if(_actarry1.count == 0 && _actarry2.count ==0){
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+174+100+_actarry3.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView2.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+174+100+_actarry3.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                
                            }
                            [self yijianText];
                        }
                        [self.courseScroll addSubview:self.jianchengView1.view];
                    }
                    
                }
            }
        }
        else{
            if ([self.taskStr isEqual:@"核签"]) {
                if (_actarry1.count != 0 && _actarry2.count != 0 ) {
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                    
                }else if(_actarry1.count != 0 && _actarry2.count ==0){
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50+_actarry3.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView2.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50+_actarry3.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                    
                }else if(_actarry1.count == 0 && _actarry2.count !=0){
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+174+50+50*_actarry2.count+_actarry3.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView2.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+174+50+50*_actarry2.count+_actarry3.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                    
                }else if(_actarry1.count == 0 && _actarry2.count ==0){
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+174+100+_actarry3.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView2.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+174+100+_actarry3.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                    
                }
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_actarry1.count != 0 && _actarry2.count != 0 ) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+_actarry2.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                }else if(_actarry1.count != 0 && _actarry2.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                }else if(_actarry1.count == 0 && _actarry2.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry2.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                }else if(_actarry1.count == 0 && _actarry2.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+100, self.yuanView1.ViewY.frame.size.width, 26);
                }
                self.yuanView1.nLabel.text = @"4";
                self.yuanView1.leixLabel.text = @"核签";
                [self.courseScroll addSubview:self.yuanView1.view];
                
                
                [self yijianText];
            }
            else if ([self.taskStr isEqual:@"核稿"]) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_actarry1.count != 0 && _actarry2.count != 0 ) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50*_actarry2.count+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count != 0 && _actarry2.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count == 0 && _actarry2.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50*_actarry2.count+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count == 0 && _actarry2.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                self.yuanView1.nLabel.text = @"4";
                self.yuanView1.leixLabel.text = @"核签";
                [self.courseScroll addSubview:self.yuanView1.view];
            }
            else if ([self.taskStr isEqual:@"会签"]) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_actarry1.count != 0 && _actarry2.count != 0 ) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50*_actarry2.count+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count != 0 && _actarry2.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50*_actarry1.count+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count == 0 && _actarry2.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+50+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50+50*_actarry2.count+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count == 0 && _actarry2.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                self.yuanView1.nLabel.text = @"4";
                self.yuanView1.leixLabel.text = @"核签";
                [self.courseScroll addSubview:self.yuanView1.view];
            }
            else{
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_actarry1.count != 0 && _actarry2.count != 0 ) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+_actarry2.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50*_actarry2.count, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count != 0 && _actarry2.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count == 0 && _actarry2.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry2.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50*_actarry2.count+50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count == 0 && _actarry2.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+100, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+100, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                self.yuanView1.nLabel.text = @"4";
                self.yuanView1.leixLabel.text = @"核签";
                [self.courseScroll addSubview:self.yuanView1.view];
            }
        }
    }
    //签发
    for (int a= 0; a<self.arrayCScomment.count;a++) {
        if (_actarry4.count != 0) {
            if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"签发"].location != NSNotFound) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if ([self.taskStr isEqual:@"核稿"]||[self.taskStr isEqual:@"会签"]||[self.taskStr isEqual:@"核签"]) {
                    if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count !=0) {
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    else if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count ==0){
                        if ([self.taskStr isEqual:@"核签"]) {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        }else{
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        }
                    }
                    else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count ==0){
                        if ([self.taskStr isEqual:@"会签"]||[self.taskStr isEqual:@"核签"]) {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        }else{
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+100+204, self.yuanView1.ViewY.frame.size.width, 26);
                        }
                    }
                    else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count !=0){
                        if ([self.taskStr isEqual:@"会签"]) {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        }else{
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry3.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        }
                    }
                    else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count ==0){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+204, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count !=0){
                        if ([self.taskStr isEqual:@"核稿"]) {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry2.count*50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        } else {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry2.count*50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        }
                    }
                    else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count ==0){
                        if ([self.taskStr isEqual:@"核稿"]|| [self.taskStr isEqual:@"核签"]) {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        } else {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        }
                        
                    }else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count !=0)
                    {
                        if ([self.taskStr isEqual:@"核稿"]|| [self.taskStr isEqual:@"会签"]) {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        } else {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        }
                        
                    }
                }
                else {
                    if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count !=0) {
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    else if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count ==0){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count ==0){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+100, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count !=0){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry3.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count ==0){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+150, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count !=0){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry2.count*50+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count ==0){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+_actarry2.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    }else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count !=0)
                    {
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                }
                
                self.yuanView1.nLabel.text = @"5";
                self.yuanView1.nLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:117/255.0 blue:255/255.0 alpha:1.0];
                self.yuanView1.leixLabel.text = @"签发";
                [self.courseScroll addSubview:self.yuanView1.view];
                NSDictionary *contentDic1 = [[NSDictionary alloc]init];
                contentDic1 = [self.arrayCScomment objectAtIndex:a];
                NSArray *actarry1 = [[NSArray alloc]init];
                actarry1 = [contentDic1 objectForKey:@"content"];
                
                if ([self.taskStr isEqual:@"核稿"]||[self.taskStr isEqual:@"会签"]||[self.taskStr isEqual:@"核签"]) {
                    for (long i = 0; i<actarry1.count; i++) {
                        _e++;
                        self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                        
                        if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count !=0) {
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+_actarry2.count*50+_actarry3.count*50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                        }
                        else if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count ==0){
                            if ([self.taskStr isEqual:@"核签"]) {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+_actarry2.count*50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            } else {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+_actarry2.count*50+50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            }
                        }
                        else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count ==0){
                            if ([self.taskStr isEqual:@"会签"]||[self.taskStr isEqual:@"核签"]) {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            }else{
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+100+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            }
                        }
                        else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count !=0){
                            if ([self.taskStr isEqual:@"会签"]) {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+_actarry3.count*50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            }else{
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+50+_actarry3.count*50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            }
                        }
                        else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count ==0){
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+100+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                        }
                        else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count !=0){
                            if ([self.taskStr isEqual:@"核稿"]) {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry2.count*50+_actarry3.count*50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            } else {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+50+_actarry2.count*50+_actarry3.count*50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            }
                            
                        }
                        else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count ==0){
                            if ([self.taskStr isEqual:@"核稿"]||[self.taskStr isEqual:@"核签"]) {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+50+_actarry2.count*50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            } else {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+100+_actarry2.count*50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            }
                        }
                        else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count !=0)
                        {
                            if ([self.taskStr isEqual:@"核稿"]||[self.taskStr isEqual:@"会签"]) {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+50+_actarry3.count*50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            } else {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+100+_actarry3.count*50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            }
                            
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
                        [outputFormatter setLocale:[NSLocale currentLocale]];
                        [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                        NSString *str = [outputFormatter stringFromDate:date];
                        self.jianchengView1.dateLabel.text = str;
                        
                        self.jianchengView1.yijianLabel.text = [[actors1 objectForKey:@"commentContent"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
                }
                else{
                    for (long i = 0; i<actarry1.count; i++) {
                        _e++;
                        self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                        
                        if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count !=0) {
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+_actarry2.count*50+_actarry3.count*50+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                        }
                        else if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count ==0){
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+_actarry2.count*50+50+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                        }
                        else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count ==0){
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+100+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                        }
                        else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count !=0){
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+50+_actarry3.count*50+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                        }
                        else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count ==0){
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+150+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                        }
                        else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count !=0){
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+50+_actarry2.count*50+_actarry3.count*50+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                        }
                        else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count ==0){
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+100+_actarry2.count*50+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                        }else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count !=0)
                        {
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
                        [outputFormatter setLocale:[NSLocale currentLocale]];
                        [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                        NSString *str = [outputFormatter stringFromDate:date];
                        self.jianchengView1.dateLabel.text = str;
                        
                        self.jianchengView1.yijianLabel.text = [[actors1 objectForKey:@"commentContent"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
                        
                        if([self.taskStr isEqual:@"签发"])
                        {
                            if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count !=0) {
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView2.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                
                            }
                            else if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count ==0){
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView2.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                
                            }
                            else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count ==0){
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+100+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView2.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+100+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                            }
                            else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count !=0){
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50+_actarry3.count*50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView2.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50+_actarry3.count*50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                
                            }
                            else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count ==0){
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+150+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView2.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+150+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                            }
                            else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count !=0){
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+50+50*_actarry2.count+_actarry3.count*50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+50+50*_actarry2.count+_actarry3.count*50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                
                            }
                            else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count ==0){
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+100+_actarry2.count*50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+100+_actarry2.count*50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                
                            }else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count !=0)
                            {
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+100+_actarry3.count*50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+100+_actarry3.count*50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                
                            }
                            [self yijianText];
                        }
                        
                        [self.courseScroll addSubview:self.jianchengView1.view];
                    }
                }
            }}
        else{
            if ([self.taskStr isEqual:@"签发"]) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count !=0) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                }
                else if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+100, self.yuanView1.ViewY.frame.size.width, 26);
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry3.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                }
                else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+150, self.yuanView1.ViewY.frame.size.width, 26);
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry2.count*50+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+_actarry2.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                }else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count !=0)
                {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                }
                self.yuanView1.nLabel.text = @"5";
                self.yuanView1.nLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:117/255.0 blue:255/255.0 alpha:1.0];
                self.yuanView1.leixLabel.text = @"签发";
                [self.courseScroll addSubview:self.yuanView1.view];
                if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count !=0) {
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                    
                }
                else if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                    
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+100+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                    
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count !=0){
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50+_actarry3.count*50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50+_actarry3.count*50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                    
                }
                else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+150+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+150+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                    
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count !=0){
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+50+50*_actarry2.count+_actarry3.count*50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+50+50*_actarry2.count+_actarry3.count*50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                    
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+100+_actarry2.count*50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+100+_actarry2.count*50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                    
                }else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count !=0)
                {
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+100+_actarry3.count*50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+100+_actarry3.count*50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                }
                [self yijianText];
            }
            else if ([self.taskStr isEqual:@"核稿"]) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count !=0) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+100+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+100+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry3.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50+_actarry3.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+100+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+204+_actarry2.count*50+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+204+50*_actarry2.count+_actarry3.count*50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50+_actarry2.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count !=0)
                {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50+_actarry3.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                self.yuanView1.nLabel.text = @"5";
                self.yuanView1.leixLabel.text = @"签发";
                [self.courseScroll addSubview:self.yuanView1.view];
            }
            else if ([self.taskStr isEqual:@"会签"]) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count !=0) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+204+_actarry3.count*50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+100+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry2.count*50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50+50*_actarry2.count+_actarry3.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+100+_actarry2.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count !=0)
                {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50+_actarry3.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                self.yuanView1.nLabel.text = @"5";
                self.yuanView1.leixLabel.text = @"签发";
                [self.courseScroll addSubview:self.yuanView1.view];
                
            }
            else if ([self.taskStr isEqual:@"核签"]) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count !=0) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry3.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50+_actarry3.count*50+204+50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+100+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry2.count*50+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50+50*_actarry2.count+_actarry3.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50+_actarry2.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count !=0)
                {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+100+_actarry3.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                self.yuanView1.nLabel.text = @"5";
                self.yuanView1.leixLabel.text = @"签发";
                [self.courseScroll addSubview:self.yuanView1.view];
            }
            else{
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count !=0) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+100, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+100, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry3.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50+_actarry3.count*50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+150, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+150, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry2.count*50+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50+50*_actarry2.count+_actarry3.count*50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+_actarry2.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+100+_actarry2.count*50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count !=0)
                {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+100+_actarry3.count*50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                self.yuanView1.nLabel.text = @"5";
                self.yuanView1.leixLabel.text = @"签发";
                [self.courseScroll addSubview:self.yuanView1.view];
            }
        }
        
    }
    
    [self.courseScroll setContentSize:CGSizeMake(self.courseScroll.bounds.size.width, (_actarry1.count+_actarry2.count+_actarry3.count+_actarry4.count)*50+600+_ztextHeight+216)];
}
//收文视图
- (void)shouwenView
{
    UIImageView *viewSt= [[UIImageView alloc]initWithFrame:CGRectMake(40, 0, 2, 20)];
    viewSt.backgroundColor = [UIColor colorWithRed:0 green:117/255.0 blue:255/255.0 alpha:1.0];
    [self.courseScroll addSubview:viewSt];
    
    //收文登记
    for (int a = 0; a<self.arrayCScontent.count; a++) {
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
            [outputFormatter setLocale:[NSLocale currentLocale]];
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
        if (_actarry1.count != 0) {
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
                    self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+ 122+50*(_b-1), self.jianchengView1.view.frame.size.width, 50);
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
                    [outputFormatter setLocale:[NSLocale currentLocale]];
                    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSString *str = [outputFormatter stringFromDate:date];
                    self.jianchengView1.dateLabel.text = str;
                    self.jianchengView1.yijianLabel.text = [[actors1 objectForKey:@"commentContent"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    
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
                    //横条颜色变化
                    if([self.taskStr isEqual:@"拟办意见"])
                    {
                        if (self.zhiwuArray.count == 2) {
                            self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+122+50*_actarry1.count, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                            [self.courseScroll addSubview:self.yijianView2.view];
                        }else{
                            self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+122+50*_actarry1.count, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                            [self.courseScroll addSubview:self.yijianView1.view];
                            CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                            [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                        }
                        [self yijianText];
                    }
                    
                    [self.courseScroll addSubview:self.jianchengView1.view];
                }
            }}else{
                if ([self.taskStr isEqual:@"拟办意见"]) {
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, 122, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, 122, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                    
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, 96, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"2";
                    self.yuanView1.leixLabel.text = @"拟办意见";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    [self yijianText];
                } else {
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    self.yuanView1.view.frame = CGRectMake(28, 96, self.yuanView1.ViewY.frame.size.width, 26);
                    self.yuanView1.nLabel.text = @"2";
                    self.yuanView1.leixLabel.text = @"拟办意见";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 122, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
            }
        
    }
    //领导批示
    for (int a= 0; a<self.arrayCScomment.count;a++) {
        if (_actarry2.count != 0) {
            if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"领导批示"].location != NSNotFound) {
                if (_actarry1.count != 0) {
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    
                    if ([self.taskStr isEqual:@"拟办意见"]){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+122+_actarry1.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    else{
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+122+_actarry1.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    self.yuanView1.nLabel.text = @"3";
                    self.yuanView1.nLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:117/255.0 blue:255/255.0 alpha:1.0];
                    self.yuanView1.leixLabel.text = @"领导批示";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    NSDictionary *contentDic1 = [[NSDictionary alloc]init];
                    contentDic1 = [self.arrayCScomment objectAtIndex:a];
                    NSArray *actarry1 = [[NSArray alloc]init];
                    actarry1 = [contentDic1 objectForKey:@"content"];
                    if ([self.taskStr isEqual:@"拟办意见"]) {
                        for (long i = 0; i<actarry1.count; i++) {
                            _c++;
                            self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+148+_actarry1.count*50+50*(_c-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            NSDictionary *actors1 = [actarry1 objectAtIndex:i];
                            NSString *yijianStr = [actors1 objectForKey:@"commentContent"];
                            CGSize titleSize = [yijianStr sizeWithFont:[UIFont fontWithName:@"Arial" size:11.0] constrainedToSize:CGSizeMake(self.jianchengView1.yijianLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                            _ztextHeight += titleSize.height;
                            _textHeight = titleSize.height;
                            [self.jianchengView1 testPlusHeight:_textHeight];
                            self.jianchengView1.yijianLabel.text = yijianStr;
                            
                            NSDictionary *dateDic = [actors1 objectForKey:@"commentDate"];
                            long time = [[dateDic objectForKey:@"time"] longLongValue]/1000;
                            NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
                            NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                            NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
                            [outputFormatter setTimeZone:timeZone];
                            [outputFormatter setLocale:[NSLocale currentLocale]];
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
                    }
                    else{
                        for (long i = 0; i<actarry1.count; i++) {
                            _c++;
                            self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+148+_actarry1.count*50+50*(_c-1), self.jianchengView1.view.frame.size.width, 50);
                            NSDictionary *actors1 = [actarry1 objectAtIndex:i];
                            NSString *yijianStr = [actors1 objectForKey:@"commentContent"];
                            CGSize titleSize = [yijianStr sizeWithFont:[UIFont fontWithName:@"Arial" size:11.0] constrainedToSize:CGSizeMake(self.jianchengView1.yijianLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                            _ztextHeight += titleSize.height;
                            _textHeight = titleSize.height;
                            [self.jianchengView1 testPlusHeight:_textHeight];
                            self.jianchengView1.yijianLabel.text = yijianStr;
                            
                            NSDictionary *dateDic = [actors1 objectForKey:@"commentDate"];
                            long time = [[dateDic objectForKey:@"time"] longLongValue]/1000;
                            NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
                            NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                            NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
                            [outputFormatter setTimeZone:timeZone];
                            [outputFormatter setLocale:[NSLocale currentLocale]];
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
                            //                self.QCoureH.labelt.text = strd1;
                            if ([self.taskStr isEqual:@"领导批示"]){
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+148+50*_actarry1.count+_actarry2.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+148+50*_actarry1.count+_actarry2.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                
                                [self yijianText];
                            }
                            [self.courseScroll addSubview:self.jianchengView1.view];
                        }
                    }
                    
                }
                else{
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    if ([self.taskStr isEqual:@"拟办意见"]) {
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+122+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    else{
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
                    if ([self.taskStr isEqual:@"拟办意见"]) {
                        for (long i = 0; i<actarry1.count; i++) {
                            _c++;
                            self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+148+50+50*(_c-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            
                            NSDictionary *actors1 = [actarry1 objectAtIndex:i];
                            NSString *yijianStr = [actors1 objectForKey:@"commentContent"];
                            CGSize titleSize = [yijianStr sizeWithFont:[UIFont fontWithName:@"Arial" size:11.0] constrainedToSize:CGSizeMake(self.jianchengView1.yijianLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                            _ztextHeight += titleSize.height;
                            _textHeight = titleSize.height;
                            [self.jianchengView1 testPlusHeight:_textHeight];
                            self.jianchengView1.yijianLabel.text = yijianStr;
                            
                            NSDictionary *dateDic = [actors1 objectForKey:@"commentDate"];
                            long time = [[dateDic objectForKey:@"time"] longLongValue]/1000;
                            NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
                            NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                            NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
                            [outputFormatter setTimeZone:timeZone];
                            [outputFormatter setLocale:[NSLocale currentLocale]];
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
                    }
                    else{
                        for (long i = 0; i<actarry1.count; i++) {
                            _c++;
                            self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+148+50+50*(_c-1), self.jianchengView1.view.frame.size.width, 50);
                            
                            NSDictionary *actors1 = [actarry1 objectAtIndex:i];
                            NSString *yijianStr = [actors1 objectForKey:@"commentContent"];
                            CGSize titleSize = [yijianStr sizeWithFont:[UIFont fontWithName:@"Arial" size:11.0] constrainedToSize:CGSizeMake(self.jianchengView1.yijianLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                            _ztextHeight += titleSize.height;
                            _textHeight = titleSize.height;
                            [self.jianchengView1 testPlusHeight:_textHeight];
                            self.jianchengView1.yijianLabel.text = yijianStr;
                            
                            NSDictionary *dateDic = [actors1 objectForKey:@"commentDate"];
                            long time = [[dateDic objectForKey:@"time"] longLongValue]/1000;
                            NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
                            NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                            NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
                            [outputFormatter setTimeZone:timeZone];
                            [outputFormatter setLocale:[NSLocale currentLocale]];
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
                            if([self.taskStr isEqual:@"领导批示"])
                            {
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+148+50+_actarry2.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+148+50+_actarry2.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                [self yijianText];
                            }
                            [self.courseScroll addSubview:self.jianchengView1.view];
                        }
                    }
                    
                }
            }}else{
                if (_actarry1.count !=0) {
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    if ([self.taskStr isEqual:@"拟办意见"]) {
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+122+50*_actarry1.count+204, self.yuanView1.ViewY.frame.size.width, 26);
                    }else{
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+122+50*_actarry1.count, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    
                    self.yuanView1.nLabel.text = @"3";
                    self.yuanView1.leixLabel.text = @"领导批示";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    if ([self.taskStr isEqual:@"领导批示"]) {
                        if (self.zhiwuArray.count == 2) {
                            self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+148+50*_actarry1.count, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                            [self.courseScroll addSubview:self.yijianView2.view];
                        }else{
                            self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+148+50*_actarry1.count, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                            [self.courseScroll addSubview:self.yijianView1.view];
                            CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                            [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                        }
                        
                        [self yijianText];
                    }else if ([self.taskStr isEqual:@"拟办意见"]){
                        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+148+50*_actarry1.count+204, 2, 50)];
                        imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                        [self.courseScroll addSubview:imageView];
                    }else{
                        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+148+50*_actarry1.count, 2, 50)];
                        imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                        [self.courseScroll addSubview:imageView];
                    }
                }else{
                    self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                    if ([self.taskStr isEqual:@"拟办意见"]) {
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+122+204, self.yuanView1.ViewY.frame.size.width, 26);
                    }else{
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+122+50, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    self.yuanView1.nLabel.text = @"3";
                    self.yuanView1.leixLabel.text = @"领导批示";
                    [self.courseScroll addSubview:self.yuanView1.view];
                    if ([self.taskStr isEqual:@"领导批示"]) {
                        if (self.zhiwuArray.count == 2) {
                            self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+148+50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                            [self.courseScroll addSubview:self.yijianView2.view];
                        }else{
                            self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+148+50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                            [self.courseScroll addSubview:self.yijianView1.view];
                            CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                            [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                        }
                        
                        [self yijianText];
                    }else if ([self.taskStr isEqual:@"拟办意见"]) {
                        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+148+204,2, 50)];
                        imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                        [self.courseScroll addSubview:imageView];
                    }else{
                        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+148+50,2, 50)];
                        imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                        [self.courseScroll addSubview:imageView];
                    }
                }
            }
        
    }
    //部门意见
    for (int a= 0; a<self.arrayCScomment.count;a++) {
        if (_actarry3.count != 0) {
            if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"部门意见"].location != NSNotFound) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if ([self.taskStr isEqual:@"拟办意见"]||[self.taskStr isEqual:@"领导批示"]) {
                    if (_actarry1.count != 0 && _actarry2.count != 0 ) {
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    else if(_actarry1.count != 0 && _actarry2.count ==0){
                        if ([self.taskStr isEqual:@"领导批示"]) {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        } else {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        }
                        
                    }
                    else if(_actarry1.count == 0 && _actarry2.count !=0){
                        if ([self.taskStr isEqual:@"拟办意见"]) {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        } else {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry2.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        }
                        
                    }
                    else if(_actarry1.count == 0 && _actarry2.count ==0){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                }
                else {
                    if (_actarry1.count != 0 && _actarry2.count != 0 ) {
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+_actarry2.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    }else if(_actarry1.count != 0 && _actarry2.count ==0){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    }else if(_actarry1.count == 0 && _actarry2.count !=0){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry2.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    }else if(_actarry1.count == 0 && _actarry2.count ==0){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+100, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                }
                
                self.yuanView1.nLabel.text = @"4";
                self.yuanView1.nLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:117/255.0 blue:255/255.0 alpha:1.0];
                self.yuanView1.leixLabel.text = @"部门意见";
                [self.courseScroll addSubview:self.yuanView1.view];
                NSDictionary *contentDic1 = [[NSDictionary alloc]init];
                contentDic1 = [self.arrayCScomment objectAtIndex:a];
                NSArray *actarry1 = [[NSArray alloc]init];
                actarry1 = [contentDic1 objectForKey:@"content"];
                
                if ([self.taskStr isEqual:@"拟办意见"]||[self.taskStr isEqual:@"领导批示"]) {
                    for (long i = 0; i<actarry1.count; i++) {
                        _d++;
                        self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                        if (_actarry1.count != 0 && _actarry2.count != 0 ) {
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+50*(_d-1)+204, self.jianchengView1.view.frame.size.width, 50);
                        }
                        else if(_actarry1.count != 0 && _actarry2.count ==0){
                            if ([self.taskStr isEqual:@"领导批示"]) {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+_actarry1.count*50+50*(_d-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            } else {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+_actarry1.count*50+50+50*(_d-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            }
                            
                        }
                        else if(_actarry1.count == 0 && _actarry2.count !=0){
                            if ([self.taskStr isEqual:@"拟办意见"]) {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+_actarry2.count*50+50*(_d-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            } else {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+50+_actarry2.count*50+50*(_d-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            }
                            
                        }else if(_actarry1.count == 0 && _actarry2.count ==0){
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+50+50*(_d-1)+204, self.jianchengView1.view.frame.size.width, 50);
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
                        [outputFormatter setLocale:[NSLocale currentLocale]];
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
                }
                else{
                    for (long i = 0; i<actarry1.count; i++) {
                        _d++;
                        self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                        if (_actarry1.count != 0 && _actarry2.count != 0 ) {
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+50*(_d-1), self.jianchengView1.view.frame.size.width, 50);
                        }else if(_actarry1.count != 0 && _actarry2.count ==0){
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+_actarry1.count*50+50+50*(_d-1), self.jianchengView1.view.frame.size.width, 50);
                        }else if(_actarry1.count == 0 && _actarry2.count !=0){
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+174+50+_actarry2.count*50+50*(_d-1), self.jianchengView1.view.frame.size.width, 50);
                        }else if(_actarry1.count == 0 && _actarry2.count ==0){
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
                        [outputFormatter setLocale:[NSLocale currentLocale]];
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
                        
                        if([self.taskStr isEqual:@"部门意见"])
                        {
                            if (_actarry1.count != 0 && _actarry2.count != 0 ) {
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                
                            }else if(_actarry1.count != 0 && _actarry2.count ==0){
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50+_actarry3.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50+_actarry3.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                
                            }else if(_actarry1.count == 0 && _actarry2.count !=0){
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+174+50+50*_actarry2.count+_actarry3.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+174+50+50*_actarry2.count+_actarry3.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                
                            }else if(_actarry1.count == 0 && _actarry2.count ==0){
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+174+100+_actarry3.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+174+100+_actarry3.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                
                            }
                            [self yijianText];
                        }
                        [self.courseScroll addSubview:self.jianchengView1.view];
                    }
                    
                }
            }
        }
        else{
            if ([self.taskStr isEqual:@"部门意见"]) {
                if (_actarry1.count != 0 && _actarry2.count != 0 ) {
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                    
                }else if(_actarry1.count != 0 && _actarry2.count ==0){
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50+_actarry3.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50+_actarry3.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                    
                }else if(_actarry1.count == 0 && _actarry2.count !=0){
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+174+50+50*_actarry2.count+_actarry3.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+174+50+50*_actarry2.count+_actarry3.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                    
                }else if(_actarry1.count == 0 && _actarry2.count ==0){
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+174+100+_actarry3.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+174+100+_actarry3.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                    
                }
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_actarry1.count != 0 && _actarry2.count != 0 ) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+_actarry2.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                }else if(_actarry1.count != 0 && _actarry2.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                }else if(_actarry1.count == 0 && _actarry2.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry2.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                }else if(_actarry1.count == 0 && _actarry2.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+100, self.yuanView1.ViewY.frame.size.width, 26);
                }
                self.yuanView1.nLabel.text = @"4";
                self.yuanView1.leixLabel.text = @"部门意见";
                [self.courseScroll addSubview:self.yuanView1.view];
                
                
                [self yijianText];
            }
            else if ([self.taskStr isEqual:@"拟办意见"]) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_actarry1.count != 0 && _actarry2.count != 0 ) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50*_actarry2.count+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count != 0 && _actarry2.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count == 0 && _actarry2.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50*_actarry2.count+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count == 0 && _actarry2.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                self.yuanView1.nLabel.text = @"4";
                self.yuanView1.leixLabel.text = @"部门意见";
                [self.courseScroll addSubview:self.yuanView1.view];
            }
            else if ([self.taskStr isEqual:@"领导批示"]) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_actarry1.count != 0 && _actarry2.count != 0 ) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50*_actarry2.count+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count != 0 && _actarry2.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50*_actarry1.count+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count == 0 && _actarry2.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+50+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50+50*_actarry2.count+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count == 0 && _actarry2.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                self.yuanView1.nLabel.text = @"4";
                self.yuanView1.leixLabel.text = @"部门意见";
                [self.courseScroll addSubview:self.yuanView1.view];
            }
            else{
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_actarry1.count != 0 && _actarry2.count != 0 ) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+_actarry2.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50*_actarry2.count, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count != 0 && _actarry2.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry1.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50*_actarry1.count+50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count == 0 && _actarry2.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+_actarry2.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+50*_actarry2.count+50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if(_actarry1.count == 0 && _actarry2.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+148+100, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+100, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                self.yuanView1.nLabel.text = @"4";
                self.yuanView1.leixLabel.text = @"部门意见";
                [self.courseScroll addSubview:self.yuanView1.view];
            }
        }
    }
    //办理结果
    for (int a= 0; a<self.arrayCScomment.count;a++) {
        //有问题(xiuzheng)
        if (_actarry4.count != 0) {
            if ([[[self.arrayCScomment[a] objectForKey:@"commentName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"办理结果"].location != NSNotFound) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if ([self.taskStr isEqual:@"拟办意见"]||[self.taskStr isEqual:@"领导批示"]||[self.taskStr isEqual:@"部门意见"]) {
                    if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count !=0) {
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    else if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count ==0){
                        if ([self.taskStr isEqual:@"部门意见"]) {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        }else{
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        }
                    }
                    else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count ==0){
                        if ([self.taskStr isEqual:@"领导批示"]||[self.taskStr isEqual:@"部门意见"]) {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        }else{
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+100+204, self.yuanView1.ViewY.frame.size.width, 26);
                        }
                    }
                    else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count !=0){
                        if ([self.taskStr isEqual:@"领导批示"]) {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        }else{
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry3.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        }
                    }
                    else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count ==0){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+204, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count !=0){
                        if ([self.taskStr isEqual:@"拟办意见"]) {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry2.count*50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        } else {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry2.count*50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        }
                    }
                    else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count ==0){
                        if ([self.taskStr isEqual:@"拟办意见"]|| [self.taskStr isEqual:@"部门意见"]) {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        } else {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        }
                        
                    }else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count !=0)
                    {
                        if ([self.taskStr isEqual:@"拟办意见"]|| [self.taskStr isEqual:@"领导批示"]) {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        } else {
                            self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                        }
                    }
                }
                else {
                    if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count !=0) {
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    else if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count ==0){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count ==0){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+100, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count !=0){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry3.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count ==0){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+150, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count !=0){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry2.count*50+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                    else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count ==0){
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+_actarry2.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    }else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count !=0)
                    {
                        self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    }
                }
                
                self.yuanView1.nLabel.text = @"5";
                self.yuanView1.nLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:117/255.0 blue:255/255.0 alpha:1.0];
                self.yuanView1.leixLabel.text = @"办理结果";
                [self.courseScroll addSubview:self.yuanView1.view];
                NSDictionary *contentDic1 = [[NSDictionary alloc]init];
                contentDic1 = [self.arrayCScomment objectAtIndex:a];
                NSArray *actarry1 = [[NSArray alloc]init];
                actarry1 = [contentDic1 objectForKey:@"content"];
                
                if ([self.taskStr isEqual:@"拟办意见"]||[self.taskStr isEqual:@"领导批示"]||[self.taskStr isEqual:@"部门意见"]) {
                    for (long i = 0; i<actarry1.count; i++) {
                        _e++;
                        self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                        
                        if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count !=0) {
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+_actarry2.count*50+_actarry3.count*50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                        }
                        else if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count ==0){
                            if ([self.taskStr isEqual:@"部门意见"]) {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+_actarry2.count*50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            } else {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+_actarry2.count*50+50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            }
                        }
                        else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count ==0){
                            if ([self.taskStr isEqual:@"领导批示"]||[self.taskStr isEqual:@"部门意见"]) {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            }else{
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+100+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            }
                        }
                        else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count !=0){
                            if ([self.taskStr isEqual:@"领导批示"]) {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+_actarry3.count*50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            }else{
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+50+_actarry3.count*50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            }
                        }
                        else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count ==0){
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+100+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                        }
                        else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count !=0){
                            if ([self.taskStr isEqual:@"拟办意见"]) {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry2.count*50+_actarry3.count*50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            } else {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+50+_actarry2.count*50+_actarry3.count*50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            }
                            
                        }
                        else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count ==0){
                            if ([self.taskStr isEqual:@"拟办意见"]||[self.taskStr isEqual:@"部门意见"]) {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+50+_actarry2.count*50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            } else {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+100+_actarry2.count*50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            }
                        }
                        else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count !=0)
                        {
                            if ([self.taskStr isEqual:@"拟办意见"]||[self.taskStr isEqual:@"领导批示"]) {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+50+_actarry3.count*50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            } else {
                                self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+100+_actarry3.count*50+50*(_e-1)+204, self.jianchengView1.view.frame.size.width, 50);
                            }
                            
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
                        [outputFormatter setLocale:[NSLocale currentLocale]];
                        [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                        NSString *str = [outputFormatter stringFromDate:date];
                        self.jianchengView1.dateLabel.text = str;
                        
                        self.jianchengView1.yijianLabel.text = [[actors1 objectForKey:@"commentContent"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
                }
                else{
                    for (long i = 0; i<actarry1.count; i++) {
                        _e++;
                        self.jianchengView1 = [[jianchengView alloc]initWithNibName:@"jianchengView" bundle:nil];
                        
                        if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count !=0) {
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+_actarry2.count*50+_actarry3.count*50+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                        }
                        else if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count ==0){
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+_actarry2.count*50+50+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                        }
                        else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count ==0){
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+100+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                        }
                        else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count !=0){
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+_actarry1.count*50+50+_actarry3.count*50+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                        }
                        else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count ==0){
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+150+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                        }
                        else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count !=0){
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+50+_actarry2.count*50+_actarry3.count*50+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                        }
                        else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count ==0){
                            self.jianchengView1.view.frame = CGRectMake(39, _ztextHeight+200+100+_actarry2.count*50+50*(_e-1), self.jianchengView1.view.frame.size.width, 50);
                        }else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count !=0)
                        {
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
                        [outputFormatter setLocale:[NSLocale currentLocale]];
                        [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                        NSString *str = [outputFormatter stringFromDate:date];
                        self.jianchengView1.dateLabel.text = str;
                        
                        self.jianchengView1.yijianLabel.text = [[actors1 objectForKey:@"commentContent"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
                        
                        if([self.taskStr isEqual:@"办理结果"])
                        {
                            if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count !=0) {
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                
                            }
                            else if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count ==0){
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                
                            }
                            else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count ==0){
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+100+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+100+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                            }
                            else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count !=0){
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50+_actarry3.count*50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50+_actarry3.count*50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                
                            }
                            else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count ==0){
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+150+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+150+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                            }
                            else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count !=0){
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+50+50*_actarry2.count+_actarry3.count*50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+50+50*_actarry2.count+_actarry3.count*50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                
                            }
                            else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count ==0){
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+100+_actarry2.count*50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+100+_actarry2.count*50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                
                            }else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count !=0)
                            {
                                if (self.zhiwuArray.count == 2) {
                                    self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+100+_actarry3.count*50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView2.view];
                                }else{
                                    self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+100+_actarry3.count*50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                                    [self.courseScroll addSubview:self.yijianView1.view];
                                    CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                                    [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                                }
                                
                            }
                            [self yijianText];
                        }
                        
                        [self.courseScroll addSubview:self.jianchengView1.view];
                    }
                }
            }}
        else{
            //有问题(xiuzheng)
            if ([self.taskStr isEqual:@"办理结果"]) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count !=0) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                }
                else if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+100, self.yuanView1.ViewY.frame.size.width, 26);
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry3.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                }
                else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+150, self.yuanView1.ViewY.frame.size.width, 26);
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry2.count*50+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+_actarry2.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                }else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count !=0)
                {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                }
                self.yuanView1.nLabel.text = @"5";
                self.yuanView1.nLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:117/255.0 blue:255/255.0 alpha:1.0];
                self.yuanView1.leixLabel.text = @"办理结果";
                [self.courseScroll addSubview:self.yuanView1.view];
                if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count !=0) {
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                    
                }
                else if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                    
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+100+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                    
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count !=0){
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50+_actarry3.count*50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50+_actarry3.count*50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                    
                }
                else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+150+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+150+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                    
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count !=0){
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+50+50*_actarry2.count+_actarry3.count*50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+50+50*_actarry2.count+_actarry3.count*50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+100+_actarry2.count*50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+100+_actarry2.count*50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                    
                }else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count !=0)
                {
                    if (self.zhiwuArray.count == 2) {
                        self.yijianView2.view.frame = CGRectMake(40, _ztextHeight+200+100+_actarry3.count*50+_actarry4.count*50, self.yijianView2.view.frame.size.width, self.yijianView2.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView2.view];
                    }else{
                        self.yijianView1.view.frame = CGRectMake(40, _ztextHeight+200+100+_actarry3.count*50+_actarry4.count*50, self.yijianView1.view.frame.size.width, self.yijianView1.view.frame.size.height);
                        [self.courseScroll addSubview:self.yijianView1.view];
                        CGFloat yijianView1Y = CGRectGetMinY(self.yijianView1.view.frame);
                        [self.courseScroll setContentOffset:CGPointMake(0, yijianView1Y-150) animated:NO];
                    }
                }
                [self yijianText];
            }
            else if ([self.taskStr isEqual:@"拟办意见"]) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count !=0) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+100+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+100+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry3.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50+_actarry3.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+100+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+204+_actarry2.count*50+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+204+50*_actarry2.count+_actarry3.count*50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50+_actarry2.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count !=0)
                {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50+_actarry3.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                self.yuanView1.nLabel.text = @"5";
                self.yuanView1.leixLabel.text = @"办理结果";
                [self.courseScroll addSubview:self.yuanView1.view];
            }
            else if ([self.taskStr isEqual:@"领导批示"]) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count !=0) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+204+_actarry3.count*50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+100+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry2.count*50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50+50*_actarry2.count+_actarry3.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+100+_actarry2.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count !=0)
                {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50+_actarry3.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                self.yuanView1.nLabel.text = @"5";
                self.yuanView1.leixLabel.text = @"办理结果";
                [self.courseScroll addSubview:self.yuanView1.view];
                
            }
            else if ([self.taskStr isEqual:@"部门意见"]) {
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count !=0) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry3.count*50+50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50+_actarry3.count*50+204+50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+100+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry2.count*50+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50+50*_actarry2.count+_actarry3.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry2.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50+_actarry2.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count !=0)
                {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+_actarry3.count*50+204, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+100+_actarry3.count*50+204, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                self.yuanView1.nLabel.text = @"5";
                self.yuanView1.leixLabel.text = @"办理结果";
                [self.courseScroll addSubview:self.yuanView1.view];
            }
            else{
                self.yuanView1 = [[yuanView alloc]initWithNibName:@"yuanView" bundle:nil];
                if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count !=0) {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+_actarry3.count*50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry2.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50*_actarry2.count+50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+100, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+100, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count != 0 && _actarry2.count == 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+_actarry1.count*50+_actarry3.count*50+50, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50*_actarry1.count+50+_actarry3.count*50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+150, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+174+150, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count !=0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+50+_actarry2.count*50+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+50+50*_actarry2.count+_actarry3.count*50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                else if (_actarry1.count == 0 && _actarry2.count != 0 && _actarry3.count ==0){
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+_actarry2.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+100+_actarry2.count*50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }else if (_actarry1.count == 0 && _actarry2.count == 0 && _actarry3.count !=0)
                {
                    self.yuanView1.view.frame = CGRectMake(28, _ztextHeight+174+100+_actarry3.count*50, self.yuanView1.ViewY.frame.size.width, 26);
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _ztextHeight+200+100+_actarry3.count*50, 2, 50)];
                    imageView.backgroundColor = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:193/255.0 alpha:1.0];
                    [self.courseScroll addSubview:imageView];
                }
                self.yuanView1.nLabel.text = @"5";
                self.yuanView1.leixLabel.text = @"办理结果";
                [self.courseScroll addSubview:self.yuanView1.view];
            }
        }
        
    }
    [self.courseScroll setContentSize:CGSizeMake(self.courseScroll.bounds.size.width, (_actarry1.count+_actarry2.count+_actarry3.count+_actarry4.count)*50+600+_ztextHeight+216)];
    
}

- (void)yijianText
{
    long time = [[self.taskExpireDate objectForKey:@"time"] longLongValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSTimeInterval late=[date timeIntervalSince1970]*1;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSTimeInterval cha=late-now;
    
    int daycha = cha/86400;
    int daymod = fmod(cha,86400);
    int hoursecha = daymod/3600;
    self.yijianView1.shuyuTimeLabel.text = [NSString stringWithFormat:@"%d天%d时",daycha,hoursecha];
    self.yijianView2.shuyuTimeLabel.text = [NSString stringWithFormat:@"%d天%d时",daycha,hoursecha];
    [self.yijianView1.tijiaoBt addTarget:self action:@selector(touchUpData) forControlEvents:UIControlEventTouchDown];
    [self.yijianView2.tijiaoBt addTarget:self action:@selector(touchUpData) forControlEvents:UIControlEventTouchDown];
    [self.otherView.submitBT addTarget:self action:@selector(touchUpData) forControlEvents:UIControlEventTouchDown];
    [self.otherView.submitBT1 addTarget:self action:@selector(touchUpData) forControlEvents:UIControlEventTouchDown];
}
//意见填写
- (void)touchUpData
{
    //时间值
    
    //    NSString *ideaText = self.yijianView1.yijianTextView.text;
    //    NSString *stateText = self.yijianView1.shuomingTextView.text;
    NSString *otherText = self.otherView.examineTextview.text;
    NSDate *today = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];//格式化
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * s1 = [df stringFromDate:today];
    
    if ([self.subAppname rangeOfString:@"发文"].location != NSNotFound || [self.subAppname rangeOfString:@"会签"].location != NSNotFound || [self.subAppname rangeOfString:@"收文"].location != NSNotFound) {
        if (self.zhiwuArray.count == 2) {
            self.testStr = [self.yijianView2.yijianTextView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            self.bwsmStr = [self.yijianView2.shuomingTextView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }else{
            self.testStr = [self.yijianView1.yijianTextView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            self.bwsmStr = [self.yijianView1.shuomingTextView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        
        NSString *zhiwu0 = self.userposition;
        NSString *zhiwu = nil;
        if (zhiwu0 != nil) {
            zhiwu = [zhiwu0 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        _Cstr = [NSString stringWithFormat:@"[{commentContent :'%@',commentDate :'%@',commentGUID :'%@',commentType : 0,userposition:'%@',personDate :'%@',sendexplanation:'%@'}]",self.testStr,s1,_CommentType,zhiwu,s1,self.bwsmStr];
    }else{
        //一事一表
        self.testStr = [otherText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *zhiwu0 = self.otherView.zhiwuLabel.text;
        NSString *zhiwu = nil;
        if (zhiwu0 != nil) {
            zhiwu = [zhiwu0 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        _Cstr = [NSString stringWithFormat:@"[{commentContent :'%@',commentDate :'%@',commentGUID :'%@',commentType : 0,userposition:'%@',personDate :'%@',sendexplanation:'%@'}]",self.testStr,s1,_CommentType,zhiwu,s1,self.bwsmStr];
    }
    
    NSDictionary *dic = @{@"instanceGUID":self.instanceID,
                          @"comment":_Cstr,
                          @"commentGUID":@"",
                          @"loginname":self.loginName
                          };
    NSString *urlUpdata = [NSString stringWithFormat:@"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=signComment"];
    
    AFHTTPRequestOperationManager *Manager = [AFHTTPRequestOperationManager manager];
    Manager.responseSerializer = [AFJSONResponseSerializer serializer]; // if response JSON format
    [Manager GET:urlUpdata parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //发送意见
        //{"success":true,"serviceStatus":"成功","information":"成功签署意见","directsend":true}
        if ([[responseObject objectForKey:@"success"] isEqual:@1]||[[responseObject objectForKey:@"success"] isEqual:@"ture"]) {
            [self senderPop];
        } else {
            UIAlertView *al =[[UIAlertView alloc] initWithTitle:@"错误" message:@"意见发送失败" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
            [al show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *al =[[UIAlertView alloc] initWithTitle:@"错误" message:@"意见发送失败" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [al show];
    }];
}

//意见发送
- (void)senderPop
{
    NSDictionary *dic = @{@"loginname":self.loginName};
    NSString *url = [NSString stringWithFormat:@"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=send&instanceGUID=%@",self.instanceID];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *ManagerUp = [AFHTTPRequestOperationManager manager];
    [ManagerUp GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"成功");
        [self touchPopRoot];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
    }];
}

//返回主视图
- (void)touchPopRoot
{
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    if (viewcontrollers.count >3 ) {
        UIViewController *v3 = [viewcontrollers objectAtIndex:1];
        [self.navigationController popToViewController:v3 animated:YES];
    }
}

//一事一表显示
- (void)otherViewControll
{
    self.otherView = [[ExamineViewController alloc]initWithNibName:@"ExamineViewController" bundle:nil];
    self.otherView.view.frame = CGRectMake(0, 0, self.otherView.view.frame.size.width, self.otherView.view.frame.size.height);
    if (self.zhiwuArray.count == 2) {
        self.otherView.zhiwuView.hidden = NO;
        self.otherView.submitBT.hidden = NO;
        self.otherView.submitBT1.hidden = YES;
        self.otherView.zhiwuLabel.text = self.userposition;
        self.otherView.zhiwuTableView.delegate = self;
        self.otherView.zhiwuTableView.dataSource = self;
    }else{
        self.otherView.zhiwuView.hidden = YES;
        self.otherView.submitBT.hidden = YES;
        self.otherView.submitBT1.hidden = NO;
    }
    [self.view addSubview:self.otherView.view];
    [self yijianText];
}

//职务TableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.font = [UIFont systemFontOfSize:10.0];
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = [self.zhiwuArray[0] objectForKey:@"name"];
            break;
        case 1:
            cell.textLabel.text = [self.zhiwuArray[1] objectForKey:@"name"];
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.otherView.zhiwuTableView) {
        switch (indexPath.row)
        {
            case 0:
                self.otherView.zhiwuLabel.text = [self.zhiwuArray[0] objectForKey:@"name"];
                break;
            case 1:
                self.otherView.zhiwuLabel.text = [self.zhiwuArray[1] objectForKey:@"name"];
                break;
        }
        self.otherView.zhiwuTableView.hidden = YES;
        [self.otherView.zhiwuBt setImage:[UIImage imageNamed:@"login_textfield_more@2x.png"] forState:UIControlStateNormal];
        [self.otherView.zhiwuTableView deselectRowAtIndexPath:[self.otherView.zhiwuTableView indexPathForSelectedRow] animated:YES];
    }
    
}



//键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self zhiwuData];
}
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];

    NSLog(@"%f",self.yijianView1.view.frame.origin.y);
    self.f = self.view.frame;
    _f.origin.y = -216;
    self.view.frame = _f;
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    //    NSDictionary *info = [aNotification userInfo];
    //    NSValue *value = [info objectForKey:UIKeyboardDidShowNotification];
    //    CGSize keyboardSize = [value CGRectValue].size;
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    _f.origin.y = 0;
    self.view.frame = _f;
    [UIView commitAnimations];
}
@end
