//
//  daibanModel.h
//  IPhoneWater
//
//  Created by main on 15/9/11.
//  Copyright (c) 2015年 main. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface daibanModel : NSObject
@property (nonatomic,strong) NSString *taskName;
@property (nonatomic,strong) NSDictionary *taskExpireDate;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *subAppName;

@property (nonatomic,strong) NSString *instance;
-(instancetype)initWithDictionary:(NSDictionary *)userInfo;
@end
