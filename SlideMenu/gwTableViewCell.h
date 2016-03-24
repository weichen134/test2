//
//  gwTableViewCell.h
//  SlideMenu
//
//  Created by main on 15/9/24.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class gwDataModel;
@interface gwTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *biaotiLabel;
@property (weak, nonatomic) IBOutlet UILabel *wenhaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *chushiLabel;

-(void)setStatusModel:(gwDataModel *)status;

@end
