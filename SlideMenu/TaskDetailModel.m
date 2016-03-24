//
//  TaskDetailModel.m
//  SlideMenu
//
//  Created by GPL on 15/12/14.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "TaskDetailModel.h"

@implementation TaskDetailModel
@synthesize userGUID,userName,department,isChoose;

-(id)initWithDictionary:(NSDictionary *)dic;
{
    self = [super init];
    if (nil != self) {
        userGUID = [dic objectForKey:@"userGUID"];
        userName = [dic objectForKey:@"userName"];
        department = [dic objectForKey:@"department"];
        isChoose = NO; //set NO as default
    }
    return self;
}

@end
