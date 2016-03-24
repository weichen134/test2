//
//  zaibanCell.h
//  IPhoneWater
//
//  Created by main on 15/9/11.
//  Copyright (c) 2015年 main. All rights reserved.
//

#import <UIKit/UIKit.h>
@class zaibanModel;
@interface zaibanCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bimage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *taskName;
@property (weak, nonatomic) IBOutlet UILabel *taskDate;

-(void)setStatusModel:(zaibanModel *)status;
@end
