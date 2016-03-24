//
//  TaskSendViewController.m
//  SlideMenu
//
//  Created by GPL on 15/12/14.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "TaskSendViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "TaskDetailModel.h"
#import "TaskSendViewCell.h"

@interface TaskSendViewController ()
//最后一个按钮
@property(nonatomic,strong) NSIndexPath *lastIndexPath;

@end

@implementation TaskSendViewController
@synthesize tableView,bar,bwsmField;
@synthesize actionGUID,instanceID,models,recipientsGUIDString,loginName;
@synthesize taskName,lastIndexPath;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self dealWithUI];
    [self initializeAllModelsIfNeeded];
    [self dealWithNetworkRequest];
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
    
    UIButton * courseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    courseButton.frame = CGRectMake(0, 0, 20, 20);
    [courseButton setImage:[UIImage imageNamed:@"fasong_white.png"] forState:UIControlStateNormal];
    [courseButton addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *courseNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:courseButton];
    self.navigationItem.rightBarButtonItem = courseNavigationItem;
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"选择人员";
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
    NSDictionary *dic = @{
                          @"loginname":loginName,
                          @"instanceGUID":self.instanceID,
                          @"actionGUID":self.actionGUID
                          };
    AFHTTPRequestOperationManager *willManager = [AFHTTPRequestOperationManager manager];
    NSString *url = @"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=getWorkflowInstanceActors";
    [willManager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"success"] isEqual:@1]||[[responseObject objectForKey:@"success"] isEqual:@"ture"]) {
            NSArray *statuses = [responseObject objectForKey:@"content"];
            for (NSDictionary *statusInfo in statuses) {
                TaskDetailModel *m = [[TaskDetailModel alloc] initWithDictionary:statusInfo];
                [self.models addObject:m];
            }
            [self.tableView reloadData];
        }else{
            //异常
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //异常
        
    }];
}

//发送操作
-(void)sendAction
{
    //得到组合的recipientsGUIDString
    NSMutableString *temGUIDString = [[NSMutableString alloc] initWithString:@""];
    for (int i=0; i< models.count;i++) {
        TaskDetailModel *mm = [models objectAtIndex:i];
        if (mm.isChoose) {
            if (i==(models.count -1)) {
                [temGUIDString appendFormat:@"%@",mm.userGUID];
            } else {
                [temGUIDString appendFormat:@"%@,",mm.userGUID];
            }
        }
    }
    
    self.recipientsGUIDString = temGUIDString;
    
    //recipientsGUIDString 空的话 警告
    if (self.recipientsGUIDString.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请选择人员进行发送"
                                                        message:nil
                                                       delegate:nil cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        
        return;
    } else {
        NSString *bwsms = self.bwsmField.text;
        bwsms = [bwsms stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        NSDictionary *dic = @{
                              @"loginname":self.loginName,
                              @"instanceGUID":self.instanceID,
                              @"actionGUID":self.actionGUID,
                              @"recipientsGUIDs":self.recipientsGUIDString,
                              @"sendexplanation":bwsms
                              };
        AFHTTPRequestOperationManager *willManager = [AFHTTPRequestOperationManager manager];
        NSString *url = @"http://gwjh.zjwater.gov.cn/ydapi/workflowService.jsp?method=sendInstance";
        [willManager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([[responseObject objectForKey:@"success"] isEqual:@1]||[[responseObject objectForKey:@"success"] isEqual:@"ture"]) {
                if ([[responseObject objectForKey:@"serviceStatus"] isEqualToString:@"成功"]) {
                    //发送成功并返回
                    //返回主视图
                    NSArray *viewcontrollers = self.navigationController.viewControllers;
                    if (viewcontrollers.count >3 ) {
                        UIViewController *v3 = [viewcontrollers objectAtIndex:1];
                        [self.navigationController popToViewController:v3 animated:YES];
                    }
                } else {
                    //异常
                }
            }else{
                //异常
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //异常
        }];
    }

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
    TaskDetailModel *m = [self.models objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"TaskCellSIdentifier";
    TaskSendViewCell *cell= [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        [self.tableView registerNib:[UINib nibWithNibName:@"TaskSendViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
        cell=[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    if ([m.department isEqualToString:@""])
    {
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",m.userName];
    }
    else
    {
        cell.titleLabel.text = [NSString stringWithFormat:@"%@-%@",m.userName,m.department];
    }

    [cell actionCheck:m.isChoose];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    /*
     1、处室领导签发
     2、厅领导核签
     3、办公室主任核稿
     4、办公室主任签发
     5、综合科核稿
     6、厅领导核签
     */
    TaskDetailModel *m = [self.models objectAtIndex:indexPath.row];
    if ([taskName isEqualToString:@"处室领导签发"] ||[taskName isEqualToString:@"厅领导核签"] ||[taskName isEqualToString:@"办公室主任核稿"] ||[taskName isEqualToString:@"办公室主任签发"] ||[taskName isEqualToString:@"综合科核稿"] ||[taskName isEqualToString:@"厅领导签发"] )
    {
        long newRow = [indexPath row];
        long oldRow = [lastIndexPath row];
        if (lastIndexPath && newRow != oldRow) {
            //变两个：先关掉老的，
            m.isChoose = YES;
            [self.models replaceObjectAtIndex:indexPath.row withObject:m];
            //打开新的
            TaskDetailModel *mOld = [self.models objectAtIndex:lastIndexPath.row];
            mOld.isChoose = NO;
            [self.models replaceObjectAtIndex:lastIndexPath.row withObject:mOld];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath,lastIndexPath] withRowAnimation:UITableViewAutomaticDimension];
            lastIndexPath = indexPath;
        } else {
            //涉及一个对象
            m.isChoose = m.isChoose ? NO:YES;
            [self.models replaceObjectAtIndex:indexPath.row withObject:m];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewAutomaticDimension];
            lastIndexPath = indexPath;
        }
    } else {
        //非以上内容可以多选
        m.isChoose = m.isChoose ? NO:YES;
        [self.models replaceObjectAtIndex:indexPath.row withObject:m];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewAutomaticDimension];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
