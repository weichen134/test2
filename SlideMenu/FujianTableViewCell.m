//
//  FujianTableViewCell.m
//  SlideMenu
//
//  Created by GPL on 15/12/22.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "FujianTableViewCell.h"
#import "fujianModel.h"

@implementation FujianTableViewCell
@synthesize titleLabel,typeIV;

-(void)setContent:(fujianModel *)fModel;
{
    if (fModel.title !=nil) {
        NSString *tem = fModel.title;
        NSString *replace4 = [tem stringByReplacingOccurrencesOfString:@".pdf" withString:@""];
        NSString *replace3 = [replace4 stringByReplacingOccurrencesOfString:@".doc" withString:@""];
        NSString *replace2 = [replace3 stringByReplacingOccurrencesOfString:@".docx" withString:@""];
        NSString *replace1 = [replace2 stringByReplacingOccurrencesOfString:@".xls" withString:@""];
        NSString *replace = [replace1 stringByReplacingOccurrencesOfString:@".xlsx" withString:@""];
        titleLabel.text = replace;
    } else {
        fModel.title = @"未命名";
    }
    if ([fModel.fjType isEqualToString:@"1"]) {
        typeIV.image = [UIImage imageNamed:@"fj_xiangguancailiao.png"];
    } else if ([fModel.fjType isEqualToString:@"4"]) {
        typeIV.image = [UIImage imageNamed:@"fj_fankuiwenjian.png"];
    } else {
        typeIV.image = [UIImage imageNamed:@"fj_fujian.png"];
    }
}

@end
