//
//  zDetailsViewController.h
//  SlideMenu
//
//  Created by main on 15/9/16.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fujianModel.h"
#import "fViewController.h"
@interface zDetailsViewController : UIViewController<UIWebViewDelegate,fViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *zaibanWebview;
@property (weak, nonatomic) IBOutlet UIWebView *bwsmWebview;
@property(nonatomic,weak) IBOutlet NSLayoutConstraint *height;

@property (strong,nonatomic)NSString *bwsmString;
@property (strong,nonatomic)NSString *loginName;
@property (strong,nonatomic) UIView *fujianView;
@property (strong,nonatomic) UITableView *fujianTableview;
@property (strong,nonatomic)NSString *subAppname;
@property (nonatomic,strong) NSString *instanceID;
@property (nonatomic,strong) NSString *biaotititle;
@property (strong,nonatomic)NSString *document_url;

@property (nonatomic)long fujianNum;
@property (nonatomic,strong)NSArray *statusesArray;
@property (strong,nonatomic)fujianModel *fModel;
@property (nonatomic,strong)NSString *taskName;

@property (nonatomic,strong)UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) NSDictionary *content;

@property(nonatomic,strong)NSString *jiezhiDate;

@property(nonatomic,strong)UIView *viewA;
@property(nonatomic,assign)int beishu;
@end
