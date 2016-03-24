//
//  TaskSendViewCell.h
//  SlideMenu
//
//  Created by GPL on 15/12/22.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskSendViewCell : UITableViewCell

@property(nonatomic,assign) IBOutlet UIImageView *checkIV;
@property(nonatomic,assign) IBOutlet UILabel *titleLabel;

-(void)actionCheck:(BOOL)isChecked;

@end
