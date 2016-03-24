//
//  zaibanCell.m
//  IPhoneWater
//
//  Created by main on 15/9/11.
//  Copyright (c) 2015年 main. All rights reserved.
//

#import "zaibanCell.h"
#import "zaibanModel.h"
@implementation zaibanCell
-(void)setStatusModel:(zaibanModel *)status
{
    self.title.text = status.title;
    self.taskName.text =status.taskName;
//    
//    CGSize size = [self textWithString:self.title.text maxSize:CGSizeMake(self.frame.size.width, MAXFLOAT) font:[UIFont systemFontOfSize:13.f]];
//    self.title.numberOfLines = 2;
//    self.title.frame = CGRectMake(0, 0, 200, size.height + 1);
    
    long time = [[status.taskExpireDate objectForKey:@"time"] longLongValue]/1000;
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [inputFormatter setTimeZone:timeZone];
    [inputFormatter setDateFormat:@"MM月dd日"];
    NSString* str = [inputFormatter stringFromDate:date1];
    self.taskDate.text = [NSString stringWithFormat:@"%@止",str];
    if ([date1 isEqualToDate:[[NSDate date] earlierDate:date1]])
    {
        self.taskDate.textColor = [UIColor redColor];
    }
    else
    {
        self.taskDate.textColor = [UIColor blackColor];
    }
    

    
    if ([status.subAppName rangeOfString:@"发文"].location != NSNotFound || [status.subAppName rangeOfString:@"会签"].location != NSNotFound) {
        self.bimage.image = [UIImage imageNamed:@"fawen_table_cell"];
    }else if ([status.subAppName rangeOfString:@"加班"].location != NSNotFound)
    {
        self.bimage.image = [UIImage imageNamed:@"jiaban_table_cell"];
    }
    else if ([status.subAppName rangeOfString:@"出差"].location != NSNotFound)
    {
        self.bimage.image = [UIImage imageNamed:@"chuchai_table_cell"];
    }else if ([status.subAppName rangeOfString:@"请假"].location != NSNotFound)
    {
        self.bimage.image = [UIImage imageNamed:@"qingjia_table_cell"];
    }else if([status.subAppName rangeOfString:@"收文"].location != NSNotFound)
    {
        self.bimage.image = [UIImage imageNamed:@"shouwen_table_cell"];
    }
}
//-(CGSize)textWithString:(NSString *)str maxSize:(CGSize)maxSize font:(UIFont *)font{
//    NSDictionary *dict = @{NSFontAttributeName:font};
//    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
//    return size;
//}
@end
