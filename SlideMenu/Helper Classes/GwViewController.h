//
//  GwViewController.h
//  SlideMenu
//
//  Created by main on 15/9/24.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GwViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *wenhLabel;

@property (weak, nonatomic) IBOutlet UITableView *gwTableview;
@property (strong,nonatomic)NSString *loginName;
@property (strong,nonatomic)NSString *appnameStr;
@property (nonatomic,strong)UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic)int type;
@property(nonatomic,strong)NSString *title;
@end
