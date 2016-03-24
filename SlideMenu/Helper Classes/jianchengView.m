//
//  jianchengView.m
//  SlideMenu
//
//  Created by main on 15/9/17.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "jianchengView.h"

@interface jianchengView ()

@end

@implementation jianchengView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView *buleView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 25, 4, 4)];
    buleView.layer.masksToBounds = YES;
    buleView.layer.cornerRadius = 2;
    buleView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:buleView];
    self.yijianLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.yijianLabel.numberOfLines =0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//测试高度增加
-(void)testPlusHeight:(float)h
{
    CGRect r0 = self.view.frame;
    CGRect r1 = self.yijianLabel.frame;
    CGRect r2 = self.nameLabel.frame;
    CGRect r3 = self.dateLabel.frame;
    
    r0.size.height += h;
    r1.size.height += h;
    r2.origin.y += h;
    r3.origin.y += h;
    
    self.view.frame = r0;
    self.yijianLabel.frame = r1;
    self.nameLabel.frame = r2;
    self.dateLabel.frame = r3;
}

@end
