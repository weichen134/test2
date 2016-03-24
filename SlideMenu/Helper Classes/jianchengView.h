//
//  jianchengView.h
//  SlideMenu
//
//  Created by main on 15/9/17.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface jianchengView : UIViewController
@property (strong, nonatomic) IBOutlet UIView *ViewJ;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewC;
@property (weak, nonatomic) IBOutlet UILabel *yijianLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


//测试高度增加
-(void)testPlusHeight:(float)h;
@end
