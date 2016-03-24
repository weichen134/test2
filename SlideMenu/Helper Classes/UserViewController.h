//
//  UserViewController.h
//  SlideMenu
//
//  Created by main on 15/10/15.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (nonatomic,strong)NSString *userName;
@property (nonatomic,strong)NSString *imgeStr;
@property (nonatomic,strong)NSString *sexStr;
@property (nonatomic,strong)NSString *telePhoneStr;
@property (nonatomic,strong)NSString *emailStr;
@property (nonatomic,strong)NSString *countryStr;
@property (nonatomic,strong)NSString *cityStr;
@property (nonatomic,strong)NSString *mobile;
@end
