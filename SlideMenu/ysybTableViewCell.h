//
//  ysybTableViewCell.h
//  SlideMenu
//
//  Created by main on 15/11/7.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class gwDataModel;
@interface ysybTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *biaotiLabel;
@property (weak, nonatomic) IBOutlet UILabel *chushiLabel;
-(void)setStatusModel:(gwDataModel *)status;
@end
