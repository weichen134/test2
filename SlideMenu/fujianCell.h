//
//  fujianCell.h
//  SlideMenu
//
//  Created by main on 15/9/17.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class fujianModel;
@interface fujianCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (strong,nonatomic)NSString *instance;

-(void)setStatusModel:(fujianModel *)status;
@end
