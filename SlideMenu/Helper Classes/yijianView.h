//
//  yijianView.h
//  SlideMenu
//
//  Created by main on 15/9/17.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface yijianView : UIViewController<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *ViewD;
@property (weak, nonatomic) IBOutlet UITextView *yijianTextView;
@property (weak, nonatomic) IBOutlet UITextView *shuomingTextView;
@property (weak, nonatomic) IBOutlet UILabel *shuyuTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *tijiaoBt;
@property (weak, nonatomic) IBOutlet UIButton *tuihuiBt;

@end
