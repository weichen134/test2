//
//  TaskListModel.h
//  SlideMenu
//
//  Created by GPL on 15/12/14.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskListModel : NSObject

@property(nonatomic,strong) NSString *actionGUID;
@property(nonatomic,strong) NSString *actionName;

-(id)initWithDictionary:(NSDictionary *)dic;

@end
