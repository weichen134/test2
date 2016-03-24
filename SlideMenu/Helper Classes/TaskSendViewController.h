//
//  TaskSendViewController.h
//  SlideMenu
//
//  Created by GPL on 15/12/14.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskSendViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak) IBOutlet UITableView *tableView;
@property(nonatomic,weak) IBOutlet UINavigationBar *bar;
@property(nonatomic,weak) IBOutlet UITextField *bwsmField;

@property(nonatomic,strong) NSString *loginName;
@property(nonatomic,strong) NSString *instanceID;
@property(nonatomic,strong) NSMutableArray *models;
@property(nonatomic,strong) NSString *actionGUID;
@property(nonatomic,strong) NSString *recipientsGUIDString;
@property(nonatomic,strong) NSString *taskName;


@end
