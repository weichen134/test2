//
//  searchTableViewCell.h
//  SlideMenu
//
//  Created by main on 15/10/18.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class gwDataModel;
@interface searchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *biaotiLabel;
@property (weak, nonatomic) IBOutlet UILabel *wenhaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *chushiLabel;

-(void)setStatusModel:(gwDataModel *)status;
@end
