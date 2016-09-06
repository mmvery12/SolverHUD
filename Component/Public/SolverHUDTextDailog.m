//
//  SolverHUDNetStatus.m
//  SolverHUD
//
//  Created by JD on 16/9/2.
//  Copyright © 2016年 com.Vacn. All rights reserved.
//

#import "SolverHUDTextDailog.h"

@implementation SolverHUDTextDailog
+(SolverHUD *)solverHUD:(NSString *)text
{
    SolverHUDTextDailog *sf = [SolverHUDTextDailog new];
    sf.frame = CGRectMake(0, 0, 100, 100);
    sf.backgroundColor = [UIColor blueColor];
    return sf;
}

+(id)ScheduledShowInView:(UIView *)view withText:(NSString *)text;
{
    return [super ScheduledShowInView:view params:text];
}

+(id)ShowInView:(UIView *)view  withText:(NSString *)text;
{
    return [super ShowInView:view params:text];
}

+(id)ScheduledShowInWindowWithText:(NSString *)text;
{
    return [super ScheduledShowInWindowWithParams:text];
}

+(id)ShowInWindowWithText:(NSString *)text;
{
    return [super ShowInWindowWithParams:text];
}

@end
