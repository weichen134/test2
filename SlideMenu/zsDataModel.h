//
//  zsDataModel.h
//  SlideMenu
//
//  Created by main on 15/11/5.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zsDataModel : NSObject
@property (nonatomic,strong)NSString *biaotiStr;
@property (nonatomic,strong)NSString *wenhaoStr;

@property (nonatomic,strong)NSString *filePath;
-(instancetype)initWithDictionary:(NSDictionary *)userInfo;
@end
