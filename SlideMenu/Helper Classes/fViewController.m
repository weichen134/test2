//
//  ViewController.m
//  SKSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import "fViewController.h"

#import "AFHTTPRequestOperationManager.h"
#import "fujianCell.h"
#import "fujianViewController.h"
#import "detailsController.h"
#import "zDetailsViewController.h"
#import "FujianTableViewCell.h"

@interface fViewController ()

@property(nonatomic,strong) fujianModel *fModel;

@end

@implementation fViewController
@synthesize delegate;
@synthesize attachment,content;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//附件调用
- (void)fujianData
{
    NSArray *attachment = [self.content objectForKey:@"attachment"];
    NSArray *editattachment = [self.content objectForKey:@"editattachment"];
    NSArray *fkfj = [self.content objectForKey:@"fkfj"];
    
    for (NSDictionary *statusInfo in editattachment) {
        fujianModel *statusModel = [[fujianModel alloc]initWithDictionary:statusInfo];
        statusModel.fjType = @"3";//附件
        [self.attachment addObject:statusModel];
    }
    for (NSDictionary *statusInfo in attachment) {
        fujianModel *statusModel = [[fujianModel alloc]initWithDictionary:statusInfo];
        statusModel.fjType = @"1";//相关材料
        [self.attachment addObject:statusModel];
    }
    for (NSDictionary *statusInfo in fkfj) {
        fujianModel *statusModel = [[fujianModel alloc]initWithDictionary:statusInfo];
        statusModel.fjType = @"4"; //反馈文件
        [self.attachment addObject:statusModel];
    }
    [self.tableView reloadData];
}
//数据异常处理
- (void)shujuyichang
{
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"" message:@"服务器请求:获取失败" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    [alertview show];
}
//服务器异常处理
- (void)fuwuyichang
{
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"" message:@"服务器异常" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    [alertview show];
}

- (void)viewDidLoad
{
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToLastController) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backNavigationItem;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"附件列表";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.frame = CGRectMake(0, 0, self.navigationItem.titleView.bounds.size.width, 20);
    self.navigationItem.titleView = titleLabel;
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = NO;
    
    self.attachment = [[NSMutableArray alloc]init];
    [self fujianData];
    
}

//返回操作
- (void)backToLastController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.attachment count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    fujianModel *m = [self.attachment objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"FujianCellSIdentifier";
    FujianTableViewCell *cell= [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        [self.tableView registerNib:[UINib nibWithNibName:@"FujianTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
        cell=[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    [cell setContent:m];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"%ld",(long)indexPath.row);
    _fModel = [self.attachment objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
    fujianViewController *fujian = [storyboard instantiateViewControllerWithIdentifier:@"fujianViewController"];
    fujian.idstance = _fModel.instance;
    fujian.titleL = _fModel.title;
    fujian.fjType = _fModel.fjType;
    fujian.filePath = _fModel.filePath;
    fujian.subAppName = self.subAppname;
    [self.navigationController pushViewController:fujian animated:YES];
}

@end







