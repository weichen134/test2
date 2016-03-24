//
//  daibanCell.m
//  IPhoneWater
//
//  Created by main on 15/9/11.
//  Copyright (c) 2015年 main. All rights reserved.
//

#import "daibanCell.h"
#import "daibanModel.h"
@implementation daibanCell
- (void)awakeFromNib {
    // Initialization code
 
}

-(void)setStatusModel:(daibanModel *)status
{
    self.title.text = status.title;


    self.taskName.text =status.taskName;
    
    long time = [[status.taskExpireDate objectForKey:@"time"] longLongValue]/1000;
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [outputFormatter setTimeZone:timeZone];
    [outputFormatter setDateFormat:@"MM月dd日"];
    NSString *str = [outputFormatter stringFromDate:date1];
    
    self.jiezhiDate.text = [NSString stringWithFormat:@"%@止",str];
    if ([date1 isEqualToDate:[[NSDate date] earlierDate:date1]])
    {
        self.jiezhiDate.textColor = [UIColor redColor];
    }
    else
    {
        self.jiezhiDate.textColor = [UIColor blackColor];
    }
    
    if ([status.subAppName rangeOfString:@"发文"].location != NSNotFound || [status.subAppName rangeOfString:@"会签"].location != NSNotFound) {
        self.leixingImage.image = [UIImage imageNamed:@"fawen_table_cell"];
    }else if ([status.subAppName rangeOfString:@"加班"].location != NSNotFound)
    {
        self.leixingImage.image = [UIImage imageNamed:@"jiaban_table_cell"];
    }
    else if ([status.subAppName rangeOfString:@"出差"].location != NSNotFound)
    {
        self.leixingImage.image = [UIImage imageNamed:@"chuchai_table_cell"];
    }else if ([status.subAppName rangeOfString:@"请假"].location != NSNotFound)
    {
        self.leixingImage.image = [UIImage imageNamed:@"qingjia_table_cell"];
    }else if([status.subAppName rangeOfString:@"收文"].location != NSNotFound)
    {
        self.leixingImage.image = [UIImage imageNamed:@"shouwen_table_cell"];
    }
}

@end
