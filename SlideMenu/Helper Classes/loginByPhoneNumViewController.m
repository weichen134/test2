//
//  loginByPhoneNumViewController.m
//  SlideMenu
//
//  Created by 不贱不粘 on 16/2/24.
//  Copyright © 2016年 Aryan Ghassemi. All rights reserved.
//

#import "loginByPhoneNumViewController.h"
#import "UIButton+Extension.h"
#import "HomeViewController.h"
#import "WebServices.h"
#import "GDataXMLNode.h"
#import "GPHeader.h"
#import "checkingViewController.h"
#import "LogUserInfo.h"
@interface loginByPhoneNumViewController ()
@property(assign,nonatomic)int secondes;
@property(strong,nonatomic)UIButton *getCheckNumBtn;
@property(strong,nonatomic)UITextField *numTF;
@property(strong,nonatomic)UITextField *checkNumTF;
@property(nonatomic,strong)NSString *guid;
@property(nonatomic,strong)NSString *asd;
@end

@implementation loginByPhoneNumViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.secondes = 300;
    UIImageView *backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background_login.png"]];
    backgroundView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:backgroundView];
    
    //底部view
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 40)];
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 241, self.view.frame.size.width, 40)];
    view1.backgroundColor = [UIColor whiteColor];
    view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view2];
    [self.view addSubview:view1];
    
    NSString *secondStr = [NSString stringWithFormat:@"重新获取(%d)",self.secondes];
    self.numTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 200, self.view.frame.size.width-40 , 40)];
    
    self.numTF.placeholder = @"请输入手机号";

    self.numTF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.numTF];
    
    self.checkNumTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 241, self.view.frame.size.width - 140, 40)];
    self.checkNumTF.placeholder = @"请输入验证码";

    self.checkNumTF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.checkNumTF];
    

    
    self.getCheckNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.getCheckNumBtn.frame = CGRectMake(self.view.frame.size.width - 120, 241, 120, 40);
    [self.getCheckNumBtn setBackgroundColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.getCheckNumBtn setBackgroundColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.getCheckNumBtn setBackgroundColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self.view addSubview:self.getCheckNumBtn];
    [self.getCheckNumBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getCheckNumBtn setTitle:secondStr forState:UIControlStateHighlighted];
    [self.getCheckNumBtn setTitle:secondStr forState:UIControlStateDisabled];
    [self.getCheckNumBtn addTarget:self action:@selector(getCheckNum) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(0, 0, 200, 40);
    [loginBtn setBackgroundColor:[UIColor blueColor]];
    loginBtn.alpha = 0.5;
    loginBtn.center = CGPointMake(self.view.center.x, 350);
    [loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 10.0;
    [loginBtn addTarget:self action:@selector(clickToRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
     self.navigationItem.hidesBackButton = YES;
}



-(void)clickToRegister
{
    [self.checkNumTF becomeFirstResponder];
    [self userRegister];
 
}

//注册GUID
-(void)regsisterGUID
{
    NSString* date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    date = [formatter stringFromDate:[NSDate date]];
    self.guid = [[NSString alloc] initWithFormat:@"%@", date];
    NSString *baseURL = @"http://m.zjwater.gov.cn/datacenterauth/authservice.asmx/";
    NSString *methodNmCount = @"GuidRegister";
    NSString *paramCount = [NSString stringWithFormat:@"%@|%@|%@|%@|%@",self.guid,SYSTEMID,VersionNowID,FVERSION,FNAME];
    NSURL *urlCount = [WebServices getNNRestUrl:baseURL Function:methodNmCount Parameter:paramCount withMobile:self.numTF.text];
    //NSString *nsurl2 = [[NSString alloc] initWithFormat:@"%@/GuidRegister?mobile=%@&guid=%@&systemId=%@&devicdType=%@",FMAINSERVER,self.login_mobile_field.text,guid,SYSTEMID,FMODEL];
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
    NSString *ret = rootElement.stringValue;
    /*
     1，成功；
     -1000：服务异常；
     -1001:，用户名或用户名已存在；
     -1002，注册失败；
     -1003,用户名不能为空；
     -1004，用户名错误
     -1007
     */
    if ([ret isEqualToString:@"1"] || [ret isEqualToString:@"-1001"])
    {

        //注册成功(将串号写入本地作为保存后，开始登录UserAuthWithGUID)
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        NSString *name = @"GUID";
        [defaults setObject:self.guid forKey:name];
        //mobile
        [defaults setObject:self.numTF.text forKey:@"MOBILE"];
        
        [self UserAuth];
    } else
    {
        //error
        if ([ret isEqualToString:@"-1000"])
        {
            //服务异常
            [self showAlertView:@"服务异常,-200"];
        } else if ([ret isEqualToString:@"-1002"])
        {
            //注册失败
            [self showAlertView:@"注册失败,-202"];
        } else if ([ret isEqualToString:@"-1003"])
        {
            //用户名不能为空
             [self showAlertView:@"用户名不能为空"];
        } else if ([ret isEqualToString:@"-1004"])
        {
            //用户名错误
            [self showAlertView:@"用户名错误,-203"];
        } else if ([ret isEqualToString:@"-1007"])
        {
            //注册数量超过限制
            [self showAlertView:@"注册超限,-207"];
        } else {
            //未知错误
            [self showAlertView:@"未知错误,-204"];
        }
    }
}

//用户注册
-(void)userRegister
{
    NSString *methodNmCount = @"UserRegister";
    NSString *paramCount = [NSString stringWithFormat:@"%@|%@",self.checkNumTF.text,SYSTEMID];
    NSString *baseURL = @"http://m.zjwater.gov.cn/datacenterauth/authservice.asmx/";
    NSURL *urlCount = [WebServices getNNRestUrl:baseURL Function:methodNmCount Parameter:paramCount withMobile:self.numTF.text];

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
    NSString *ret = rootElement.stringValue;
    
    
    /*
     1，成功；
     2，成功,待审核；
     -1000：服务异常；
     -1001:，用户名或用户名已存在；
     -1002，注册失败；
     -1005,验证码失效
     */
    if ([ret isEqualToString:@"1"] || [ret isEqualToString:@"-1001"])
    {
        //注册成功（下一步，生成随机码注册）
        [self regsisterGUID];

        
    }
    else
    {
        if ([ret isEqualToString:@"-1005"])
        {
            //验证码错误(提醒)
            
            [self showAlertView: @"验证码错误,-105"];
        } else if ([ret isEqualToString:@"-1000"])
        {
            //服务异常(提醒)
            
            [self showAlertView: @"服务异常,-100"];
        } else if ([ret isEqualToString:@"-1002"])
        {
            //注册失败(提醒)
            
            [self showAlertView: @"注册失败,-102"];
        } else
        {
            //未知错误(提醒)
            [self showAlertView: @"未知错误,-104"];
        }
        
    }
}

//用户认证
-(void)UserAuth
{

    
    
    NSString *baseURL = @"http://m.zjwater.gov.cn/datacenterauth/authservice.asmx/";
    NSString *methodNmCount = @"UserAuth";
    NSString *paramCount = [NSString stringWithFormat:@"%@|%@|%@|%@|%@",self.guid,SYSTEMID,FNAME,VersionNowID,FOPERATIONNUMBER];
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
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];

        [defaults setObject:self.guid forKey:@"GUID"];
        
        [defaults setObject:val.iscompel forKey:@"iscompel"];
        [defaults setObject:val.versioncount forKey:@"versioncount"];
        [defaults setObject:val.areacode forKey:@"areacode"];
        [defaults setObject:val.mtemplatealias forKey:@"mtemplatealias"];
        [defaults setObject:val.mtemplatearea forKey:@"mtemplatearea"];
        [defaults setObject:val.mtemplatename forKey:@"mtemplatename"];
        [defaults setObject:val.mtemplateid forKey:@"mtemplateid"];
        [defaults setObject:val.state forKey:@"state"];
        [defaults setObject:val.username forKey:@"username"];
        
        
        
        [self showAlertView:@"注册成功，欢迎登陆"];
        
    }
    else
    {
//        if([retIfVal isEqualToString:@"-311"]== YES)
//        {
//            [self showAlertView:@"登陆异常,-311"];
//        } else if([retIfVal isEqualToString:@"-312"]== YES)
//        {
//            [self showAlertView:@"登陆异常,-312"];
//        } else if([retIfVal isEqualToString:@"-313"]== YES)
//        {
//            [self showAlertView:@"登陆异常,-313"];
//        } else if([retIfVal isEqualToString:@"-314"]== YES)
//        {
//            [self showAlertView:@"登陆异常,-314"];
//        } else if([retIfVal isEqualToString:@"-315"]== YES)
//        {
//            [self showAlertView:@"登陆异常,-315"];
//        } else if([retIfVal isEqualToString:@"-316"]== YES)
//        {
//            [self showAlertView:@"登陆异常,-316"];
//        } else if([retIfVal isEqualToString:@"-300"]== YES)
//        {
//            [self showAlertView:@"登陆异常,-300"];
//        } else
//        {
//            [self showAlertView:@"登陆异常,-310"];
//        }
        checkingViewController *VC = [checkingViewController new];
        [self.navigationController pushViewController:VC animated:NO];
    }
    
    
}


-(void)getCheckNum
{
    [self.checkNumTF becomeFirstResponder];
    if (self.numTF.text.length < 11)
    {
        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"" message:@"输入格式错误" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertview show];
    }
    else
    {
        
        
        NSString *mnum = self.numTF.text;
        
        NSString *baseURL = @"http://m.zjwater.gov.cn/datacenterauth/authservice.asmx/";
        NSString *methodNmCount = @"GetVerificationCode";
        NSURL *urlCount = [WebServices getNNRestUrl:baseURL Function:methodNmCount Parameter:@"" withMobile:mnum];

        //NSString *nsurl2 = [[NSString alloc] initWithFormat:@"%@/GetVerificationCode?mobile=%@",FMAINSERVER,mnum];
        //NSURL *nsurl = [[NSURL alloc]initWithString:nsurl2];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlCount];
        NSURLResponse *response = nil;
        NSError *error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                             returningResponse:&response
                                                         error:&error];
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
        //获取根节点（Users）
        GDataXMLElement *rootElement = [doc rootElement];
        NSString *ret = rootElement.stringValue;
        /*
         1，成功；
         -1000：服务异常；
         -1001:，用户名或用户名已存在；
         -1002，注册失败；
         -1003,用户名不能为空；
         -1004，用户名错误
         */
        if ([ret isEqualToString:@"1"] || [ret isEqualToString:@"-1001"])
        {
            //短信发送成功(改变获取按钮信息，倒计时和重新获取)
            self.secondes = 300;
            [self.getCheckNumBtn setEnabled:NO];
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeSecond:) userInfo:nil repeats:YES];
        } else if ([ret isEqualToString:@"-1000"]){
            //服务异常
            [self showAlertView: @"服务异常"];
        } else if ([ret isEqualToString:@"-1002"]){
            //注册失败
            [self showAlertView: @"注册失败"];
        } else if ([ret isEqualToString:@"-1003"]){
            //用户名不能为空
            [self showAlertView: @"用户名不能为空"];
        } else if ([ret isEqualToString:@"-1004"]){
            //用户名错误
            [self showAlertView: @"用户名错误"];
        } else {
            //未知错误
            [self showAlertView: @"未知错误"];
        }
    }


}

-(void) showAlertView:(NSString *) meg{
    UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:nil message:meg delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alterView show];
}

-(void)changeSecond:(NSTimer*)timer
{
    self.secondes -= 1;
    NSString *secondStr = [NSString stringWithFormat:@"重新获取(%d)",self.secondes];
    [self.getCheckNumBtn setTitle:secondStr forState:UIControlStateDisabled];
    if (self.secondes < 0)
    {
        [timer invalidate];
        [self.getCheckNumBtn setEnabled:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.numTF resignFirstResponder];
    [self.checkNumTF resignFirstResponder];
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
