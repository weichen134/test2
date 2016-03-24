//
//  ysybTableViewCell.m
//  SlideMenu
//
//  Created by main on 15/11/7.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "ysybTableViewCell.h"
#import "gwDataModel.h"
@implementation ysybTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setStatusModel:(gwDataModel *)status
{
    self.biaotiLabel.text = status.title;
    self.chushiLabel.text = status.chushiStr;
}
@end
