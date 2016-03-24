//
//  NSString+DateTool.m
//  SlideMenu
//
//  Created by GPL on 15/10/14.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "NSString+DateTool.h"

@implementation NSString(DateTool)

+(NSString *)getYYYYMMDDHHmmssString;
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    return [formatter stringFromDate:[NSDate date]];
}

@end
