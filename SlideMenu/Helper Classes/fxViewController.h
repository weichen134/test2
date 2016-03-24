//
//  fxViewController.h
//  SlideMenu
//
//  Created by main on 15/9/24.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface fxViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *fxWebView;
@property (nonatomic,strong)NSString *fiPath;
@property (nonatomic,strong)NSString *titleStr;
@property (nonatomic) int Value;
@property (nonatomic,strong)UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic,strong)UIView *viewA;
@end
