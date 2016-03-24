//
//  loginViewController.h
//  SlideMenu
//
//  Created by main on 15/9/25.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
//@protocol LoginDelegate
//- (void)leftMenuString:(NSString *)loginName;//1.1定义协议与方法
//@end

@interface loginViewController : UIViewController
//@property (retain,nonatomic) id <LoginDelegate> trendDelegate;
@property (weak, nonatomic) IBOutlet UIButton *LoginBt;
@property (weak, nonatomic) IBOutlet UITextField *personID;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (nonatomic,strong)NSString *loginStr;

@end
