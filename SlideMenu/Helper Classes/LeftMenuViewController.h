//
//  MenuViewController.h
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "HomeViewController.h"
@interface LeftMenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *touxiangView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (nonatomic, assign) BOOL slideOutAnimationEnabled;
@property (nonatomic,strong)NSString *loginNameStr;


@property (nonatomic) int daibanNum;
@property (nonatomic) int zaibanNum;
@property (nonatomic) int shareNum;

@property(nonatomic,strong)NSString *daibanTotal;
@property(nonatomic,strong)NSString *zaibanTotal;

@property (nonatomic,strong)NSArray *array1;
@property (nonatomic,strong)NSArray *array2;
@property (nonatomic,strong)NSArray *array3;



@property (nonatomic,strong)NSString *userName;
@property (nonatomic,strong)NSString *imgeStr;
@property (nonatomic,strong)NSString *sexStr;
@property (nonatomic,strong)NSString *telePhoneStr;
@property (nonatomic,strong)NSString *emailStr;
@property (nonatomic,strong)NSString *countryStr;
@property (nonatomic,strong)NSString *cityStr;
@property (nonatomic,strong)NSString *mobile;

@property(nonatomic,strong)UIButton *quitBtn;
@property(nonatomic,strong)UIButton *logoutBtn;


@end
