//
//  fujianModel.h
//  SlideMenu
//
//  Created by main on 15/9/17.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface fujianModel : NSObject
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *instance;
@property(nonatomic,strong) NSString *fjType;//3:附件 1:相关材料 4:反馈文件
@property(nonatomic,strong) NSString *filePath;

-(instancetype)initWithDictionary:(NSDictionary *)userInfo;

@end

