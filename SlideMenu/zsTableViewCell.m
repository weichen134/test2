//
//  zsTableViewCell.m
//  SlideMenu
//
//  Created by main on 15/11/5.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "zsTableViewCell.h"
#import "zsDataModel.h"
@implementation zsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setStatusModel:(zsDataModel *)status
{
    self.biaotiLabel.text = status.biaotiStr;
    self.wenhaoLabel.text = status.wenhaoStr;
    
    if (status.biaotiStr.length >= 35)
    {
        NSString *str = [status.biaotiStr substringToIndex:35];
        NSString *str1 = [str stringByAppendingFormat:@"..."];
        self.biaotiLabel.text = str1;
        
    }
    else
    {
        self.biaotiLabel.text = status.biaotiStr;
    }
}
@end
