//
//  XQViewController.h
//  SlideMenu
//
//  Created by main on 15/11/5.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XQViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *XQTableView;
@property (strong,nonatomic)NSString *loginName;
@property(nonatomic)int cellNum;
@property(nonatomic)int type;
@property (nonatomic,strong)UIActivityIndicatorView *activityIndicatorView;
@end
