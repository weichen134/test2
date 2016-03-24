//
//  HomeViewController.h
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "detailsController.h"

#import "daibanCell.h"
#import "daibanModel.h"
#import "User.h"
#import "loginViewController.h"


@interface HomeViewController : UIViewController <SlideNavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *homeTableview;
@property (strong,nonatomic)NSString *loginName;
@property (strong,nonatomic)NSMutableArray *statusesArray;

@property (strong,nonatomic)daibanCell *daibanCell;
@property (strong,nonatomic)daibanModel *dModel;
@property (strong,nonatomic)UILabel *titleLabel;

@property (nonatomic) int spageNum;
@property (nonatomic)int cellNum;
@property (nonatomic)BOOL needLoading;
@property(nonatomic)int type;

@property(nonatomic,strong)NSString *jiezhiDate;
@end
