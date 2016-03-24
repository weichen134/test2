//
//  dCourseViewController.h
//  SlideMenu
//
//  Created by main on 15/9/17.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "yijianView.h"
#import "yijianViewZ.h"
@interface dCourseViewController : UIViewController<UIScrollViewDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *courseScroll;
@property (strong,nonatomic)NSString *loginName;
@property (nonatomic,strong)NSString *biaotititle;

@property (strong,nonatomic)NSDictionary *taskExpireDate;
@property (strong,nonatomic)NSString *CommentType;
@property (strong,nonatomic)NSString *subAppname;
@property (strong,nonatomic)NSString *instanceID;
@property (nonatomic,strong)NSString *taskName;
@property (nonatomic,strong)NSString *taskStr;
@property (nonatomic,strong)NSString *testStr;
@property (nonatomic,strong)NSString *danweiStr;
@property (nonatomic,strong)NSString *bwsmStr;
@property (nonatomic,strong)NSString *taskNameStr;


@property (nonatomic,strong)NSArray *zhiwuArray;
@property (nonatomic,strong)yijianView *yijianView1;
@property (nonatomic,strong)yijianViewZ *yijianView2;

@property (nonatomic)CGRect f;
@end
