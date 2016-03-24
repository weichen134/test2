//
//  yqTableViewCell.h
//  SlideMenu
//
//  Created by main on 15/11/5.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class yqDataModel;
@interface yqTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *biaotiLabel;
@property (weak, nonatomic) IBOutlet UILabel *wenhaoLabel;

-(void)setStatusModel:(yqDataModel *)status;
@end
