//
//  FujianTableViewCell.h
//  SlideMenu
//
//  Created by GPL on 15/12/22.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class fujianModel;
@interface FujianTableViewCell : UITableViewCell

@property(nonatomic,assign) IBOutlet UIImageView *typeIV;
@property(nonatomic,assign) IBOutlet UILabel *titleLabel;

-(void)setContent:(fujianModel *)fModel;

@end
