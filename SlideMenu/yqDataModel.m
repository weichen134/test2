//
//  yqDataModel.m
//  SlideMenu
//
//  Created by main on 15/11/5.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "yqDataModel.h"

@implementation yqDataModel
-(instancetype)initWithDictionary:(NSDictionary *)userInfo
{
    self.biaotiStr= [userInfo objectForKey:@"title"];
    self.wenhaoStr = [userInfo objectForKey:@"qishu"];
    self.filePath = [userInfo objectForKey:@"id"];
    return self;
}
@end
