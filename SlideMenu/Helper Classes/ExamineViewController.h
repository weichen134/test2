//
//  ExamineViewController.h
//  Water
//
//  Created by Admin on 15/8/18.
//  Copyright (c) 2015年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamineViewController : UIViewController<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *submitBT;
@property (weak, nonatomic) IBOutlet UIButton *submitBT1;
@property (weak, nonatomic) IBOutlet UILabel *examineLabel;
@property (weak, nonatomic) IBOutlet UITextView *examineTextview;

@property (weak, nonatomic) IBOutlet UIView *zhiwuView;
@property (weak, nonatomic) IBOutlet UILabel *zhiwuLabel;
@property (weak, nonatomic) IBOutlet UIButton *zhiwuBt;
@property (weak, nonatomic) IBOutlet UITableView *zhiwuTableView;
@property (weak, nonatomic) NSString *loginName;
@end
