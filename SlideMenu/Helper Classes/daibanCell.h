//
//  daibanCell.h
//  IPhoneWater
//
//  Created by main on 15/9/11.
//  Copyright (c) 2015年 main. All rights reserved.
//

#import <UIKit/UIKit.h>
@class daibanModel;
@interface daibanCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *leixingImage;
@property (weak, nonatomic) IBOutlet UILabel *taskName;
@property (weak, nonatomic) IBOutlet UILabel *jiezhiDate;

-(void)setStatusModel:(daibanModel *)status;
@end
