//
//  SolverHUDWorkFlow.m
//  SolverHUD
//
//  Created by JD on 16/9/2.
//  Copyright © 2016年 com.Vacn. All rights reserved.
//

#import "SolverHUDWorkFlow.h"

@implementation SolverHUDWorkFlow


+(id)ScheduledShowWorkFlow:(BOOL)workflowsuccess inView:(UIView *)view position:(SolverHUDPosition)position catchUserInteraction:(BOOL)tryCatchUserInteraction showWithanimate:(BOOL)animate during:(NSTimeInterval)during;
{
    return [super ScheduledShowInView:view position:position catchUserInteraction:tryCatchUserInteraction showWithanimate:animate during:during];
}

+(id)ShowWorkFlow:(BOOL)workflowsuccess inView:(UIView *)view position:(SolverHUDPosition)position catchUserInteraction:(BOOL)tryCatchUserInteraction showWithanimate:(BOOL)animate during:(NSTimeInterval)during;
{
    return [super ShowInView:view position:position catchUserInteraction:tryCatchUserInteraction showWithanimate:animate during:during];
}

@end
