//
//  zaibanModel.m
//  IPhoneWater
//
//  Created by main on 15/9/11.
//  Copyright (c) 2015年 main. All rights reserved.
//

#import "zaibanModel.h"

@implementation zaibanModel
-(instancetype)initWithDictionary:(NSDictionary *)userInfo
{
    self.taskName = [[userInfo objectForKey:@"task_name"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.title = [[userInfo objectForKey:@"title"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.taskExpireDate = [userInfo objectForKey:@"taskExpireDate"];
    self.subAppName = [[userInfo objectForKey:@"subAppName"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    self.instance = [userInfo objectForKey:@"workflowinstance_guid"];
    return self;
    
}
@end
