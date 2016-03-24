//
//  gwDataModel.m
//  SlideMenu
//
//  Created by main on 15/9/24.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "gwDataModel.h"

@implementation gwDataModel
-(instancetype)initWithDictionary:(NSDictionary *)userInfo
{
    self.title= [userInfo objectForKey:@"title"];
    self.wenhaoStr = [userInfo objectForKey:@"hao"];
    self.chushiStr= [userInfo objectForKey:@"dept"];
//    NSDictionary *sendDate = [userInfo objectForKey:@"sendDate"];
//    long time = [[sendDate objectForKey:@"time"] longValue]/1000;
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
//    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//    [outputFormatter setLocale:[NSLocale currentLocale]];
//    [outputFormatter setDateFormat:@"yyy-MM-dd"];
//    self.dateStr = [outputFormatter stringFromDate:date];
    
    self.filePath = [userInfo objectForKey:@"filePath"];
    return self;
}
@end
