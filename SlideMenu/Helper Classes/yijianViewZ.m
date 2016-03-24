//
//  yijianViewZ.m
//  SlideMenu
//
//  Created by main on 15/10/29.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "yijianViewZ.h"

@interface yijianViewZ ()

@end

@implementation yijianViewZ

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.zhiWuBt1 setImage:[UIImage imageNamed:@"RadioButton-Selected"] forState:UIControlStateNormal];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
    [self.yijianTextView resignFirstResponder];
    [self.shuomingTextView resignFirstResponder];
}

@end
