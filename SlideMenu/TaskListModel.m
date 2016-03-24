//
//  TaskListModel.m
//  SlideMenu
//
//  Created by GPL on 15/12/14.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "TaskListModel.h"

@implementation TaskListModel

@synthesize actionGUID;
@synthesize actionName;

-(id)initWithDictionary:(NSDictionary *)dic;
{
    self = [super init];
    if (nil != self) {
        actionGUID = [dic objectForKey:@"actionGUID"];
        actionName = [dic objectForKey:@"actionName"];
    }
    return self;
}

@end
