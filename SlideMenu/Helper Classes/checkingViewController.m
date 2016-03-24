//
//  checkingViewController.m
//  SlideMenu
//
//  Created by 不贱不粘 on 16/2/25.
//  Copyright © 2016年 Aryan Ghassemi. All rights reserved.
//

#import "checkingViewController.h"

@interface checkingViewController ()

@end

@implementation checkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"checking.jpg"]];
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:imageView];
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 0, 0);
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"13777859713";
    label.frame = CGRectMake(170, 370, 150, 30);
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];

    UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backNavigationItem;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
