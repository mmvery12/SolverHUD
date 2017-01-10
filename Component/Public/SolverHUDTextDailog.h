//
//  SolverHUDNetStatus.h
//  SolverHUD
//
//  Created by JD on 16/9/2.
//  Copyright © 2016年 com.Vacn. All rights reserved.
//

#import "SolverHUDView.h"

@interface SolverHUDTextDailog : SolverHUDView
+(id)ScheduledShowInView:(UIView *)view withText:(NSString *)text;

+(id)ShowInView:(UIView *)view  withText:(NSString *)text;

+(id)ScheduledShowInWindowWithText:(NSString *)text;

+(id)ShowInWindowWithText:(NSString *)text;

/* */
@end
