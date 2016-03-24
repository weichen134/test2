//
//  tool.m
//  SlideMenu
//
//  Created by 陈炜 on 16/3/21.
//  Copyright © 2016年 Aryan Ghassemi. All rights reserved.
//

#import "tool.h"

@implementation tool

-(void)viewDisappear:(UIView*)viewA
{
    [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(delay:) userInfo:nil repeats:YES];
}

-(void)delay:(NSTimer*)timer :(UIView*)viewA
{
    viewA.alpha -= 0.3333333;
    
    if (viewA.alpha < 0)
    {
        [timer setFireDate:[NSDate distantFuture]];
    }
}

@end
