//
//  SolverHUDNetStatus.m
//  SolverHUD
//
//  Created by JD on 16/9/2.
//  Copyright © 2016年 com.Vacn. All rights reserved.
//

#import "SolverHUDNetStatus.h"

@implementation SolverHUDNetStatus
+(SolverHUD *)solverHUD
{
    SolverHUDNetStatus *sf = [SolverHUDNetStatus new];
    sf.frame = CGRectMake(0, 0, 100, 100);
    sf.backgroundColor = [UIColor blueColor];
    return sf;
}
@end
