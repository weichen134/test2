//
//  TaskListViewController.h
//  SlideMenu
//
//  Created by GPL on 15/12/14.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak) IBOutlet UITableView *tableView;
@property(nonatomic,weak) IBOutlet UINavigationBar *bar;

@property(nonatomic,strong) NSString *loginName;
@property(nonatomic,strong) NSString *instanceID;
@property(nonatomic,strong) NSMutableArray *models;
@property (nonatomic,strong)NSString *taskName;
@property (strong,nonatomic)NSString *subAppname;
@property (nonatomic,strong)NSDictionary *taskExpireDate;
@property (nonatomic,strong) NSString *biaotititle;

@end
