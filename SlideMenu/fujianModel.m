//
//  fujianModel.m
//  SlideMenu
//
//  Created by main on 15/9/17.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "fujianModel.h"

@implementation fujianModel
@synthesize fjType;

-(instancetype)initWithDictionary:(NSDictionary *)userInfo
{
    self.title = [[userInfo objectForKey:@"fileName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.filePath = [userInfo objectForKey:@"filePath"];
    self.instance = [userInfo objectForKey:@"id"];
    return self;
}
@end
