//
//  TaskListViewController.m
//  SlideMenu
//
//  Created by GPL on 15/12/14.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "TaskListViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "TaskListModel.h"
#import "TaskSendViewController.h"
#import "TaskListTableViewCell.h"
#import "dCourseViewController.h"
#import "zCourseViewController.h"

@interface TaskListViewController ()

@end

@implementation TaskListViewController
@synthesize tableView,bar;
@synthesize instanceID,models,loginName;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    UIButton *courseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    courseButton.frame = CGRectMake(0, 0, 20, 20);
    [courseButton setImage:[UIImage imageNamed:@"licheng_white.png"] forState:UIControlStateNormal];
    [courseButton addTarget:self action:@selector(course) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *courseNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:courseButton];
    self.navigationItem.rightBarButtonItem = courseNavigationItem;
    
    [self dealWithUI];
    [self initializeAllModelsIfNeeded];
    [self dealWithNetworkRequest];
}

-(void)course
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
    zCourseViewController *zCourse = [storyboard instantiateViewControllerWithIdentifier:@"zCourseViewController"];
    zCourse.loginName =self.loginName;
    zCourse.biaotititle = self.biaotititle;
    zCourse.subAppname = self.subAppname;
    zCourse.instanceID = self.instanceID;
    zCourse.taskName = self.taskName;
    [self.navigationController pushViewController:zCourse animated:YES];
}

#pragma mark CUSTOM METHOD
//UI处理
-(void)dealWithUI;
{
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToLastController) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backNavigationItem;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"选择任务";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.frame = CGRectMake(0, 0, self.navigationItem.titleView.bounds.size.width, 20);
    self.navigationItem.titleView = titleLabel;
    
    self.automaticallyAdjustsScrollViewInsets = NO;

}

//数据初始化
-(void)initializeAllModelsIfNeeded
{
    self.models = [[NSMutableArray alloc] init];
}

//网络请求
-(void)dealWithNetworkRequest;
{
    /*
     http://123.157.159.136:8888/services/workflowService.jsp?method=getWorkflowTask&instanceGUID=&=mzm
     */
    NSDictionary *dic = @{
                          @"loginname":loginName,
                          @"instanceGUID":self.instanceID
                          };
    AFHTTPRequestOperationManager *WillManager = [AFHTTPRequestOperationManager manager];
    NSString *url = @"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=getWorkflowTask";
    [WillManager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"success"] isEqual:@1]||[[responseObject objectForKey:@"success"] isEqual:@"ture"]) {
            NSArray *statuses = [responseObject objectForKey:@"content"];
            for (NSDictionary *statusInfo in statuses) {
                TaskListModel *m = [[TaskListModel alloc] initWithDictionary:statusInfo];
                [self.models addObject:m];
            }
            
            [self.tableView reloadData];
            
//            //            self.statusesArray = statusModels;
//            cellNum = (int)self.statusesArray.count;
//            self.titleLabel.text = [NSString stringWithFormat:@"待办事项(%ld)",(unsigned long)self.statusesArray.count];
//            [self.homeTableview reloadData];
        }else{
//            self.titleLabel.text = @"待办事项(0)";
//            [self shujuyichang];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        self.titleLabel.text = @"待办事项(0)";
//        [self fuwuyichang];
    }];
}

//返回操作
- (void)backToLastController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
#pragma UITableViewDataSource And UITableViewDelegate
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [models count];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    TaskListModel *m = [self.models objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"TaskCellIdentifier";
    TaskListTableViewCell *cell= [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        [self.tableView registerNib:[UINib nibWithNibName:@"TaskListTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
        cell=[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.titleLabel.text = m.actionName;
    

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    TaskListModel *m = [self.models objectAtIndex:indexPath.row];

    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    TaskSendViewController *vc = [[TaskSendViewController alloc] initWithNibName:@"TaskSendViewController" bundle:nil];
    
    vc.actionGUID = m.actionGUID;
    vc.instanceID = instanceID;
    vc.loginName = loginName;
    vc.taskName = m.actionName;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
