//
//  detailsController.h
//  iPhonewater1.3
//
//  Created by main on 15/9/14.
//  Copyright (c) 2015年 main. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fujianModel.h"
#import "fViewController.h"
@interface detailsController : UIViewController<UIWebViewDelegate,fViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *detailsWebview;
@property (weak, nonatomic) IBOutlet UIWebView *bwsmWebview;
@property(nonatomic,weak) IBOutlet NSLayoutConstraint *height;
@property (strong,nonatomic)NSString *loginName;
@property (strong,nonatomic)NSString *bwsmString;
@property (strong,nonatomic)NSString *document_url;

@property (strong,nonatomic) UIView *fujianView;
@property (strong,nonatomic) UITableView *fujianTableview;
@property (strong,nonatomic)NSString *subAppname;
@property (nonatomic,strong) NSString *instanceID;
@property (nonatomic,strong) NSString *biaotititle;

@property (nonatomic)long fujianNum;
@property (nonatomic,strong)NSArray *statusesArray;
@property (strong,nonatomic)fujianModel *fModel;
@property (nonatomic,strong)NSString *taskName;
@property (nonatomic,strong)NSDictionary *taskExpireDate;
@property (nonatomic,strong)UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) NSDictionary *content;

@property(nonatomic,strong)NSString *jiezhiDate;
@property(nonatomic,strong)UIView *viewA;
@property(nonatomic,assign)int beishu;
@end
