//
//  fujianViewController.h
//  SlideMenu
//
//  Created by main on 15/9/18.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface fujianViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *fujianWebview;
@property (strong, nonatomic)NSString *idstance;
@property (strong, nonatomic)NSString *titleL;
@property (strong, nonatomic)NSString *fjType;
@property (strong, nonatomic)NSString *filePath;
@property (strong, nonatomic)NSString *subAppName;

@property (nonatomic,strong)UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic,strong)UIView *viewA;
@property(nonatomic,assign)int beishu;
@end
