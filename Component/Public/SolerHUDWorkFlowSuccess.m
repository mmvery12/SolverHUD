//
//  SolerHUDWorkFlowSuccess.m
//  SolverHUD
//
//  Created by JD on 16/9/5.
//  Copyright © 2016年 com.Vacn. All rights reserved.
//

#import "SolerHUDWorkFlowSuccess.h"

@implementation SolerHUDWorkFlowSuccess
+(SolverHUD *)solverHUD
{
    SolerHUDWorkFlowSuccess *sf = [SolerHUDWorkFlowSuccess new];
    sf.frame = CGRectMake(0, 0, 100, 100);
    sf.backgroundColor = [UIColor redColor];
    return sf;
}
@end
