//
//  zCourseViewController.h
//  SlideMenu
//
//  Created by main on 15/9/17.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zCourseViewController : UIViewController
@property (nonatomic,strong)NSString *biaotititle;
@property (weak, nonatomic) IBOutlet UIScrollView *courseScroll;
@property (strong,nonatomic)NSString *loginName;

@property (strong,nonatomic)NSString *subAppname;
@property (strong,nonatomic)NSString *instanceID;
@property (nonatomic,strong)NSString *taskName;
@property (nonatomic,strong)NSString *danweiStr;
@property (nonatomic,strong)NSString *taskNameStr;
@end
