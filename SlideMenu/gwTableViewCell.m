//
//  gwTableViewCell.m
//  SlideMenu
//
//  Created by main on 15/9/24.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "gwTableViewCell.h"
#import "gwDataModel.h"
@implementation gwTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
   
    // Configure the view for the selected state
}
-(void)setStatusModel:(gwDataModel *)status
{
        if (status.title.length >= 25)
        {
            NSString *str = [status.title substringToIndex:25];
            NSString *str1 = [str stringByAppendingFormat:@"..."];
            self.biaotiLabel.text = str1;
    
        }
        else
        {
            self.biaotiLabel.text = status.title;
        }
    
    self.wenhaoLabel.text = status.wenhaoStr;
    self.chushiLabel.text = status.chushiStr;
}

@end
