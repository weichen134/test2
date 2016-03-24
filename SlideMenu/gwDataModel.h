//
//  gwDataModel.h
//  SlideMenu
//
//  Created by main on 15/9/24.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface gwDataModel : NSObject
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *wenhaoStr;
@property (nonatomic,strong)NSString *chushiStr;
@property (nonatomic,strong)NSString *filePath;
-(instancetype)initWithDictionary:(NSDictionary *)userInfo;
@end
