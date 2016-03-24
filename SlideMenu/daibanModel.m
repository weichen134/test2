//
//  daibanModel.m
//  IPhoneWater
//
//  Created by main on 15/9/11.
//  Copyright (c) 2015年 main. All rights reserved.
//

#import "daibanModel.h"

@implementation daibanModel

-(instancetype)initWithDictionary:(NSDictionary *)userInfo
{    
    self.taskName = [[userInfo objectForKey:@"currenttask_name"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.title = [[userInfo objectForKey:@"title"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.taskExpireDate = [userInfo objectForKey:@"taskExpireDate"];
    self.subAppName = [[userInfo objectForKey:@"subAppName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    self.instance = [userInfo objectForKey:@"instanceID"];
    return self;
}

@end
