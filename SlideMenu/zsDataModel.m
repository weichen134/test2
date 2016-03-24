//
//  zsDataModel.m
//  SlideMenu
//
//  Created by main on 15/11/5.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "zsDataModel.h"

@implementation zsDataModel
-(instancetype)initWithDictionary:(NSDictionary *)userInfo
{
    self.biaotiStr= [userInfo objectForKey:@"title"];
    self.wenhaoStr = [userInfo objectForKey:@"qishu"];
    self.filePath = [userInfo objectForKey:@"id"];
    return self;
}
@end
