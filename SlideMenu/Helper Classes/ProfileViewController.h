//
//  ProfileViewController.h
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

#import "zDetailsViewController.h"
#import "zaibanCell.h"
#import "zaibanModel.h"
#import "User.h"
#import "loginViewController.h"
@interface ProfileViewController : UIViewController <SlideNavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *zaibanTableview;
@property (strong,nonatomic)NSString *loginName;
@property (strong,nonatomic)NSMutableArray *statusesArray;
@property (strong,nonatomic)zaibanCell *zaibanCell;
@property (strong,nonatomic)zaibanModel *zModel;
@property (strong,nonatomic)UILabel *titleLabel;
@property (nonatomic) int spageNum;
@property (nonatomic)int cellNum;
@property (nonatomic)BOOL needLoading;
@property(nonatomic)int type;

@property(nonatomic,strong)NSString *jiezhiDate;
@end
