//
//  loginViewController.m
//  SlideMenu
//
//  Created by main on 15/9/25.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "loginViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "NSString+MD5.h"
#import "NSString+DateTool.h"


#import "LeftMenuViewController.h"
#import "HomeViewController.h"
#import "ShareViewController.h"
#import "ProfileViewController.h"
#import "GPHeader.h"
#import "updateViewController.h"
#import "loginByPhoneNumViewController.h"
#import "GDataXMLNode.h"
#import "WebServices.h"
#import "checkingViewController.h"
#import "LogUserInfo.h"
@interface loginViewController ()<UITextFieldDelegate,NSXMLParserDelegate,NSURLConnectionDataDelegate>
@property (nonatomic,strong)NSString *userName;
@property (nonatomic,strong)NSString *imgeStr;
@property (nonatomic,strong)NSString *sexStr;
@property (nonatomic,strong)NSString *telePhoneStr;
@property (nonatomic,strong)NSString *emailStr;
@property (nonatomic,strong)NSString *countryStr;
@property (nonatomic,strong)NSString *cityStr;
@property (nonatomic,strong)NSString *mobile;
@property (nonatomic,strong)NSString *userposition;
@property (nonatomic)BOOL needloading;
@property(nonatomic,strong)NSUserDefaults *user;
@property(nonatomic,strong)NSString *loginNameStr;
@property(nonatomic,strong)NSString *passwordStr;

@property(nonatomic,strong)NSMutableData *versionData;
@property(nonatomic,strong)NSURLConnection *theConncetion;

@property(nonatomic,strong)NSString *isLogin;

//@property (nonatomic,strong)NSArray *zhiwuArray;
@end

@implementation loginViewController
@synthesize needloading;
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadInputViews];
    if (needloading ==YES) {
        self.password.text = nil;
    } else {
        needloading = YES;
    }
    
    self.user = [NSUserDefaults standardUserDefaults];
    self.loginNameStr = [self.user objectForKey:@"zhanghao"];
    self.passwordStr = [self.user objectForKey:@"password"];

    self.personID.text = self.loginNameStr;
    self.password.text = self.passwordStr;
    
    [self judgeNeedUpdate];

    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"GUID"])
    {
        
        loginByPhoneNumViewController *VC = [[loginByPhoneNumViewController alloc]init];
        [self.navigationController pushViewController:VC animated:NO];
       
    }
    else
    {

        [self UserAuth];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(judgeIsLogin:) name:@"judgeIsLogin" object:nil];
        if ([self.user objectForKey:@"zhanghao"] && [self.user objectForKey:@"password"])
        {
            if (![self.isLogin isEqualToString:@"No"])
            {
                [self Login];
            }

            
        }
    }
    
}

-(void)judgeIsLogin:(NSNotification*)text
{
    self.isLogin = text.userInfo[@"777"];
    NSLog(@"%@",self.isLogin);
}

-(void)UserAuth
{
    NSString *guid = [self.user objectForKey:@"GUID"];
    
    
    NSString *baseURL = @"http://m.zjwater.gov.cn/datacenterauth/authservice.asmx/";
    NSString *methodNmCount = @"UserAuth";
    NSString *paramCount = [NSString stringWithFormat:@"%@|%@|%@|%@|%@",guid,SYSTEMID,FNAME,VersionNowID,FOPERATIONNUMBER];
    NSURL *urlCount = [WebServices getRestUrl:baseURL Function:methodNmCount Parameter:paramCount];
    //NSString *nsurl2 = [[NSString alloc] initWithFormat:@"%@/UserAuthWithGUID?&guid=%@&systemId=%@&deviceType=%@&version=%@",FMAINSERVER,guid,SYSTEMID,FMODEL,VersionNowID];
    //nsurl2 = [nsurl2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSURL *nsurl = [[NSURL alloc]initWithString:nsurl2];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlCount];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                         returningResponse:&response
                                                     error:&error];
    //解析
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    //获取根节点（Users）
    GDataXMLElement *rootElement = [doc rootElement];
    NSArray *items  = [rootElement nodesForXPath:@"//Table" error:nil];
    GDataXMLElement *ele = [items objectAtIndex:0];
    LogUserInfo *val = [[LogUserInfo alloc] init];
    //ifval
    GDataXMLElement *nameElement1 = [[ele elementsForName:@"ifval"] objectAtIndex:0];
    NSString *retIfVal = [nameElement1 stringValue];
    if ([retIfVal isEqualToString:@"1"] == YES)
    {
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        NSString *name = @"GUID";
        [defaults setObject:guid forKey:name];
        
        GDataXMLElement *nameElement2 = [[ele elementsForName:@"username"] objectAtIndex:0];
        val.username = [nameElement2 stringValue];
        //state
        GDataXMLElement *nameElement3 = [[ele elementsForName:@"state"] objectAtIndex:0];
        val.state = [nameElement3 stringValue];
        //template_id
        GDataXMLElement *nameElement4 = [[ele elementsForName:@"template_id"] objectAtIndex:0];
        val.mtemplateid = [nameElement4 stringValue];
        //template_name
        GDataXMLElement *nameElement5 = [[ele elementsForName:@"template_name"] objectAtIndex:0];
        val.mtemplatename = [nameElement5 stringValue];
        //template_area
        GDataXMLElement *nameElement6 = [[ele elementsForName:@"template_area"] objectAtIndex:0];
        val.mtemplatearea = [nameElement6 stringValue];
        //template_alias
        GDataXMLElement *nameElement7 = [[ele elementsForName:@"template_alias"] objectAtIndex:0];
        val.mtemplatealias = [nameElement7 stringValue];
        //areacode
        GDataXMLElement *nameElement8 = [[ele elementsForName:@"areacode"] objectAtIndex:0];
        val.areacode = [nameElement8 stringValue];
        //versioncount
        GDataXMLElement *nameElement9 = [[ele elementsForName:@"versioncount"] objectAtIndex:0];
        val.versioncount = [nameElement9 stringValue];
        //iscompel
        GDataXMLElement *nameElement10 = [[ele elementsForName:@"iscompel"] objectAtIndex:0];
        val.iscompel = [nameElement10 stringValue];

        
        [defaults setObject:val.iscompel forKey:@"iscompel"];
        [defaults setObject:val.versioncount forKey:@"versioncount"];
        [defaults setObject:val.areacode forKey:@"areacode"];
        [defaults setObject:val.mtemplatealias forKey:@"mtemplatealias"];
        [defaults setObject:val.mtemplatearea forKey:@"mtemplatearea"];
        [defaults setObject:val.mtemplatename forKey:@"mtemplatename"];
        [defaults setObject:val.mtemplateid forKey:@"mtemplateid"];
        [defaults setObject:val.state forKey:@"state"];
        [defaults setObject:val.username forKey:@"username"];
        
        NSLog(@"versionCount === %@",val.versioncount);
        
    }
    else
    {

        checkingViewController *VC = [checkingViewController new];
        [self.navigationController pushViewController:VC animated:NO];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.user = [NSUserDefaults standardUserDefaults];

    
    needloading = NO;
    
    
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                             bundle: nil];
    
    LeftMenuViewController *leftMenu = (LeftMenuViewController*)[mainStoryboard
                                                                 instantiateViewControllerWithIdentifier: @"LeftMenuViewController"];
    
    
    
    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
    [SlideNavigationController sharedInstance].menuRevealAnimationDuration = 0.18;
    
    // Creating a custom bar button for right menu
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setImage:[UIImage imageNamed:@"gear"] forState:UIControlStateNormal];
    [button addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [SlideNavigationController sharedInstance].rightBarButtonItem = rightBarButtonItem;
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidClose object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Closed %@", menu);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidOpen object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Opened %@", menu);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidReveal object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Revealed %@", menu);
    }];
    
    self.tabBarController.tabBar.hidden = YES;
    
    self.LoginBt.layer.masksToBounds =YES;
    self.LoginBt.layer.cornerRadius = 4;
    
    self.personID.delegate = self;
    self.password.delegate = self;
    [_password setSecureTextEntry:YES];
    
//    [self.LoginBt addTarget:self action:@selector(LoginPush) forControlEvents:UIControlEventTouchDown];
    
    
    [self.LoginBt addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchDown];

    
}



//判断是否需要强制更新
-(void)judgeNeedUpdate
{
    self.user = [NSUserDefaults standardUserDefaults];
    NSString *versionCount = [self.user objectForKey:@"versioncount"];

    //需要更新
    if ([versionCount intValue] > NOW_VERSION_CODE )
    {
        //需要更新
        
        [self showAlert:@"发现新版本，正在进入下载页面。"];
    }
//
//    NSString *url3 = @"https://dl.bizmsg.net/appupload/release/bin/zjslt/version_update/iphoneVersion.json";
//    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url3]
//                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                            timeoutInterval:60.0];
//    self.versionData = [[NSMutableData alloc] init];
//    self.theConncetion=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
//    [self.theConncetion start];
}


//
//#pragma mark - NSURLConnectionDataDelegate
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
//{
//    [self.versionData appendData:data];
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
//{
//    //声明一个gbk编码类型
//    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSString *result = [[NSString alloc] initWithData:self.versionData  encoding:gbkEncoding];
//    NSData *mdata = [result dataUsingEncoding:NSUTF8StringEncoding];
//
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:mdata options:NSJSONReadingMutableContainers error:nil];
//
//    NSString *versionCode = [dic objectForKey:@"versionCode"];
//
//    if (versionCode != nil)
//    {
//
//        //需要更新
//        if ([versionCode intValue] > NOW_VERSION_CODE )
//        {
//            //需要更新
//
//            [self showAlert:@"发现新版本，正在进入下载页面。"];
//        }
//
//    } else {
//        //失败
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未能连接到服务器" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//    }
//}

-(void)transationToUpdateView
{
   updateViewController *vc = [[updateViewController alloc] initWithNibName:@"updateViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
    //跳转到下载页面
    [self transationToUpdateView];
}


- (void)showAlert:(NSString *) _message{//时间
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:3.0f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:NO];
    [promptAlert show];
    
}
-(void) showAlertView:(NSString *) meg{
    UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:nil message:meg delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alterView show];
}

-(void)Login
{

    
    
    if ([self.personID.text isEqualToString:@""] || [self.password.text isEqualToString:@""])
    {
        [self showAlertView:@"用户名或密码不能为空"];
    }
    else
    {
        //调用登录方法
        [self validateUser:_personID.text password:_password.text];
        self.user = [NSUserDefaults standardUserDefaults];
        [self.user setValue:self.password.text forKey:@"password"];
        

    }
    
    
}

//用户登录成功后，获取令牌
-(void)validateUser:(NSString *)user password:(NSString *)psw
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSString *serverCode = @"oaapp";
    NSString *serverPSW = @"oaapp";
    NSString *time = [NSString getYYYYMMDDHHmmssString];
    //(servicecode+servicepwd+time)
    NSString *signUnCry = [NSString stringWithFormat:@"%@%@%@",serverCode,serverPSW,time];
    NSString *signCry = [signUnCry md5HexDigest];
    [dic setValue:serverCode forKey:@"servicecode"];
    [dic setValue:time forKey:@"time"];
    [dic setValue:signCry forKey:@"sign"];
    [dic setValue:_personID.text forKey:@"loginname"];
    [dic setValue:@"" forKey:@"orgcoding"];
    //明文加密类型1
    [dic setValue:@"1" forKey:@"encryptiontype"];
    [dic setValue:_password.text forKey:@"password"];
    [dic setValue:@"json" forKey:@"datatype"];
    
    AFHTTPRequestOperationManager *willManager = [AFHTTPRequestOperationManager manager];
    //    willManager.requestSerializer.HTTPRequestHeaders =
    NSString *url = @"http://sfrz.zjwater.gov.cn/sso/servlet/simpleauth?method=idValidation";
    [willManager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {

        //需要加入判断 result
        
        int res = [[responseObject objectForKey:@"result"] intValue];
        if (res == 0)
        {
            
            
            NSString *tok = [responseObject objectForKey:@"token"];
            //获取用户详情
            [self getUserInfo:tok];
            NSString *loginName = [responseObject objectForKey:@"loginname"];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
            // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
            HomeViewController *homeControll = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
            [self.user setObject:loginName forKey:@"loginname"];
            [self.navigationController pushViewController:homeControll animated:YES];
        } else {
            //业务请求失败
            [self shujuyichang];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //失败处理
        [self shujuyichang];
    }];
}

-(void)getUserInfo:(NSString *)token
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSString *serverCode = @"oaapp";
    NSString *serverPSW = @"oaapp";
    NSString *time = [NSString getYYYYMMDDHHmmssString];
    //(servicecode+servicepwd+time)
    NSString *signUnCry = [NSString stringWithFormat:@"%@%@%@",serverCode,serverPSW,time];
    NSString *signCry = [signUnCry md5HexDigest];
    [dic setValue:serverCode forKey:@"servicecode"];
    [dic setValue:time forKey:@"time"];
    [dic setValue:signCry forKey:@"sign"];
    [dic setValue:token forKey:@"token"];
    [dic setValue:@"json" forKey:@"datatype"];
    
    AFHTTPRequestOperationManager *willManager = [AFHTTPRequestOperationManager manager];

    NSString *url = @"http://sfrz.zjwater.gov.cn/sso/servlet/simpleauth?method=getUserInfo";
    [willManager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        //得到JSON
        NSLog(@"%@",responseObject);
        
        //需要加入判断 result
        int res = [[responseObject objectForKey:@"result"] intValue];
        if (res == 0) {
            
            self.imgeStr = [responseObject objectForKey:@"headpicture"];
            self.sexStr = [responseObject objectForKey:@"sex"];
            self.telePhoneStr = [responseObject objectForKey:@"telephone"];
            self.countryStr = [responseObject objectForKey:@"country"];
            self.cityStr = [responseObject objectForKey:@"city"];
            self.emailStr = [responseObject objectForKey:@"email"];
            self.mobile = [responseObject objectForKey:@"mobile"];
            self.loginStr = [responseObject objectForKey:@"loginname"];

            self.userName = [responseObject objectForKey:@"username"];
            
            [self.user setObject:self.imgeStr forKey:@"userImge"];
            [self.user setObject:self.sexStr forKey:@"userSex"];
            [self.user setObject:self.telePhoneStr forKey:@"userPhone"];
            [self.user setObject:self.countryStr forKey:@"userCountry"];
            [self.user setObject:self.cityStr forKey:@"userCity"];
            [self.user setObject:self.emailStr forKey:@"userEmail"];
            [self.user setObject:self.mobile forKey:@"usermobile"];

            [self.user setObject:self.userName forKey:@"userName"];
            [self.user setObject:self.loginStr forKey:@"zhanghao"];

            [[NSNotificationCenter defaultCenter]postNotificationName:@"123" object:nil];
        }
//        else {
//            //业务请求失败
//            
//        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"我失败了");
        //失败处理
        [self fuwuyichang];
    }];
}
//数据请求失败
- (void)shujuyichang
{
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"用户名或密码错误" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f
                                     target:self
                                   selector:@selector(timerFireMethod1:)
                                   userInfo:promptAlert
                                    repeats:NO];
    [promptAlert show];
}

- (void)timerFireMethod1:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}
//服务器异常
- (void)fuwuyichang
{
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"" message:@"服务器异常" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    [alertview show];
    
}


//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
    [self.personID resignFirstResponder];
    [self.password resignFirstResponder];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

@end
