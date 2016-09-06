//
//  SolverHUDNetStatus.m
//  SolverHUD
//
//  Created by JD on 16/9/2.
//  Copyright © 2016年 com.Vacn. All rights reserved.
//

#import "SolverHUDTextDailog.h"

@implementation SolverHUDTextDailog
+(SolverHUD *)solverHUD
{
    SolverHUDTextDailog *sf = [SolverHUDTextDailog new];
    sf.frame = CGRectMake(0, 0, 100, 100);
    sf.backgroundColor = [UIColor blueColor];
    return sf;
}

-(void)hudStatusDidChange:(SolverHUDStatus)status;
{
    NSLog(@"status %ld",(long)status);
}

@end
