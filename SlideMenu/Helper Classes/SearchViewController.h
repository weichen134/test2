//
//  SearchViewController.h
//  SlideMenu
//
//  Created by main on 15/10/16.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController

@property (strong,nonatomic) NSString *loginName;
@property (weak, nonatomic) IBOutlet UISearchBar *searChBar;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (nonatomic,strong) NSString *appnameStr;
@property (nonatomic)int spageNum;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)NSString *title;
@property (nonatomic,strong)UIActivityIndicatorView *activityIndicatorView;
@end
