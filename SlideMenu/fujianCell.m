//
//  fujianCell.m
//  SlideMenu
//
//  Created by main on 15/9/17.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "fujianCell.h"
#import "fujianModel.h"

@implementation fujianCell

- (void)awakeFromNib {
    // Initialization code
    
    self.numLabel.layer.masksToBounds = YES;
    self.numLabel.layer.cornerRadius = 12;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setStatusModel:(fujianModel *)status
{
    self.title.text = status.title;
    self.instance = status.instance;
}
@end
