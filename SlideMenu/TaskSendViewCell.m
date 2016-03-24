//
//  TaskSendViewCell.m
//  SlideMenu
//
//  Created by GPL on 15/12/22.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "TaskSendViewCell.h"

@implementation TaskSendViewCell
@synthesize checkIV;
@synthesize titleLabel;

- (void)awakeFromNib {
    // Initialization code
}

-(void)actionCheck:(BOOL)isChecked
{
    if (isChecked) {
        checkIV.image = [UIImage imageNamed:@"task_checked_checkbox"];
    } else {
        checkIV.image = [UIImage imageNamed:@"task_unchecked_checkbox"];
    }
}

@end
