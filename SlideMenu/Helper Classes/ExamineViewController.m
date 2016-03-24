//
//  ExamineViewController.m
//  Water
//
//  Created by Admin on 15/8/18.
//  Copyright (c) 2015年 Admin. All rights reserved.
//

#import "ExamineViewController.h"
#import "AFHTTPRequestOperationManager.h"


@interface ExamineViewController ()
@property (nonatomic,strong)NSArray *zhiwuArray;
@end

@implementation ExamineViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(zhiwuData:) name:@"123" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.layer.cornerRadius = 8;
    self.view.layer.masksToBounds = YES;
    self.view.layer.borderWidth = 1;
    self.view.layer.borderColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:0.8].CGColor;
    
    self.examineTextview.layer.cornerRadius = 5;
    self.examineTextview.layer.masksToBounds = YES;
    self.examineTextview.layer.borderWidth = 1;
    self.examineTextview.layer.borderColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:229/255.0 alpha:1.0].CGColor;
    
    self.submitBT.layer.cornerRadius = 5;
    self.submitBT.layer.masksToBounds = YES;
    self.submitBT1.layer.cornerRadius = 5;
    self.submitBT1.layer.masksToBounds = YES;

    self.examineTextview.delegate = self;
    self.examineTextview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    self.zhiwuView.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0].CGColor;
    self.zhiwuView.layer.borderWidth = 1;
    self.zhiwuTableView.hidden = YES;
    self.zhiwuTableView.scrollEnabled = NO;
    [self.zhiwuBt addTarget:self action:@selector(zhiwuTouch) forControlEvents:UIControlEventTouchDown];
    if ([self.zhiwuTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.zhiwuTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.zhiwuTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.zhiwuTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    UITapGestureRecognizer *tapGestureTel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zhiwuTouch)];
    self.zhiwuLabel.userInteractionEnabled = YES;
    [self.zhiwuLabel addGestureRecognizer:tapGestureTel];
}
- (void)zhiwuTouch
{
    [self.examineTextview resignFirstResponder];
    if (self.zhiwuTableView.hidden == YES) {
        self.zhiwuTableView.hidden = NO;
        [self.zhiwuBt setImage:[UIImage imageNamed:@"login_textfield_more_flip@2x.png"] forState:UIControlStateNormal];
    }
    else if (self.zhiwuTableView.hidden == NO){
        self.zhiwuTableView.hidden = YES;
        [self.zhiwuBt setImage:[UIImage imageNamed:@"login_textfield_more@2x.png"] forState:UIControlStateNormal];
    }
}
- (void)textViewDidChange:(UITextView *)textView{
    if ((textView = self.examineTextview)) {
        self.examineTextview.text =textView.text;
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

@end
