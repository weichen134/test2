//
//  ViewController.h
//  SKSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fujianModel.h"
@protocol fViewControllerDelegate <NSObject>
-(void)pushToNextViewController:(fujianModel *)model;
@end

@interface fViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property(assign) id <fViewControllerDelegate> delegate;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSString *loginName;
@property (nonatomic,strong)NSString *instanceID;
@property (nonatomic,strong)NSString *subAppname;
@property (nonatomic,strong)UIView *ViewT;
@property (nonatomic,strong)UILabel *LabelT;
@property (nonatomic,strong)UIButton *ButtonT;

@property (nonatomic, strong) NSDictionary *content;
@property (nonatomic, strong) NSMutableArray *attachment;

@end
