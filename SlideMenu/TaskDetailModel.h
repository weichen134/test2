//
//  TaskDetailModel.h
//  SlideMenu
//
//  Created by GPL on 15/12/14.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskDetailModel : NSObject

@property(nonatomic,strong) NSString *userGUID;
@property(nonatomic,strong) NSString *userName;
@property(nonatomic,strong) NSString *department;
@property(nonatomic,assign) BOOL isChoose;//set NO as default

-(id)initWithDictionary:(NSDictionary *)dic;

@end
