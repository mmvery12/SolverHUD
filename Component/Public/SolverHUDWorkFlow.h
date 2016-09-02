//
//  SolverHUDWorkFlow.h
//  SolverHUD
//
//  Created by JD on 16/9/2.
//  Copyright © 2016年 com.Vacn. All rights reserved.
//

#import "SolverHUD.h"

@interface SolverHUDWorkFlow : SolverHUD
+(id)ScheduledShowWorkFlow:(BOOL)workflowsuccess inView:(UIView *)view position:(SolverHUDPosition)position catchUserInteraction:(BOOL)tryCatchUserInteraction showWithanimate:(BOOL)animate during:(NSTimeInterval)during;

+(id)ShowWorkFlow:(BOOL)workflowsuccess inView:(UIView *)view position:(SolverHUDPosition)position catchUserInteraction:(BOOL)tryCatchUserInteraction showWithanimate:(BOOL)animate during:(NSTimeInterval)during;
@end
