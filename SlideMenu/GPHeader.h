//
//  GPHeader.h
//  SlideMenu
//
//  Created by GPL on 16/1/11.
//  Copyright (c) 2016年 Aryan Ghassemi. All rights reserved.
//
#import "UIDeviceHardWare.h"

#define NOW_VERSION_CODE 0 //2016年3月10日发布
#define NOW_VERSION_COUNT 1.1.0
/*
//2016年1月14日更新-1
 //2016年1月14日更新-2
 //2016年1月14日更新-3
 //2016年1月18日更新-4
 //2016年2月23日更新-5
//2016年2月26日更新-6
//2016年2月26日更新-7
//2016年2月29日更新-8
//2016年3月3日更新-12
 
 */



#define NUMPAGE 9
#define WORK_NUMPAGE 7

#define ServerMain @"pda.zjwater.gov.cn"
#define ServerBackup @"pda.zjfx.gov.cn"
#define MainServerURLPath @"DataCenterAuth/AuthService.asmx"
#define SYSTEMID @"S1414"

#define SYSTEMNM @"浙江省防汛掌上通"
#define FMAINSERVER @"http://pdafx1.zjwater.gov.cn/DataCenterAuth/AuthService.asmx"
#define FNAME [[UIDevice currentDevice] name]
#define FMODEL [UIDeviceHardware platformString]
#define FVERSION [UIDeviceHardware platformString]

#define FOPERATIONNUMBER [[UIDevice currentDevice] systemVersion]

#define VersionNowID @"1.1.0"
#define PubDate @"2016-03-10"
#define VERSIONCOUNT @"0"