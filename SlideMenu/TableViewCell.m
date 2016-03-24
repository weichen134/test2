//
//  TableViewCell.m
//  IPhoneWater
//
//  Created by main on 15/9/11.
//  Copyright (c) 2015年 main. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.NumLabel.layer.masksToBounds = YES;
    self.NumLabel.layer.cornerRadius = 5;
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
