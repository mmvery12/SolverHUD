//
//  SolverHUDGIF.h
//  SolverHUD
//
//  Created by JD on 16/9/2.
//  Copyright © 2016年 com.Vacn. All rights reserved.
//

#import "SolverHUD.h"

@interface SolverHUDGIF : SolverHUD
+(id)ScheduledShowInView:(UIView *)view withImages:(NSArray *)imgs;

+(id)ShowInView:(UIView *)view  withImages:(NSArray *)imgs;

+(id)ScheduledShowInWindowWithImages:(NSArray *)imgs;

+(id)ShowInWindowWithImages:(NSArray *)imgs;

@end
