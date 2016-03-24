/*
 *  Const.h
 *  navag
 *
 *  Created by DY LOU on 10-4-21.
 *  Copyright 2010 Zhejiang Dayu Information Technology Co.,Ltd. All rights reserved.
 *
 */

/*
 About the use of the UIView's tag
 WaterController1:9999
 WaterController3:9998
 NewTyphoonController's webview tag:1
 */
#import "UIDeviceHardWare.h"

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

#define VersionNowID @"6.0.3"
#define PubDate @"2015-04-27"
#define VERSIONCOUNT @"2"