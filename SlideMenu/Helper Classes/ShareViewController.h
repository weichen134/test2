//
//  ShareViewController.h
//  SlideMenu
//
//  Created by main on 15/9/17.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "loginViewController.h"
@interface ShareViewController : UIViewController<SlideNavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *shareView1;
@property (weak, nonatomic) IBOutlet UIView *shareView2;
@property (weak, nonatomic) IBOutlet UIView *shareView3;
@property (weak, nonatomic) IBOutlet UIView *shareView4;
@property (weak, nonatomic) IBOutlet UIView *shareView5;
@property (weak, nonatomic) IBOutlet UIView *shareView6;
@property (strong,nonatomic)NSString *loginName;
@end
