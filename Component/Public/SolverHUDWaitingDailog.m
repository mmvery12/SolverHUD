//
//  SolverHUDWaitingDalog.m
//  SolverHUD
//
//  Created by JD on 16/9/2.
//  Copyright © 2016年 com.Vacn. All rights reserved.
//

#import "SolverHUDWaitingDailog.h"

@implementation SolverHUDWaitingDailog
+(SolverHUDView *)solverHUD:(id)params;
{
    SolverHUDWaitingDailog *sf = [SolverHUDWaitingDailog new];
    sf.frame = CGRectMake(0, 0, 100, 100);
    sf.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];
    sf.layer.cornerRadius = 10;
    sf.layer.masksToBounds = YES;
    UIActivityIndicatorView *acti = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [sf addSubview:acti];
    acti.tag = 10086;
    [acti setHidesWhenStopped:YES];
    acti.center = CGPointMake(CGRectGetMidX(sf.bounds), CGRectGetMidY(sf.bounds));
    return sf;
}

-(void)hudStatusDidChange:(SolverHUDStatus)status;
{
    UIActivityIndicatorView *acti = (id)[self viewWithTag:10086];
    switch (status) {
        case SolverHUDInAnimateingStatus:
            [acti startAnimating];
            break;
        case SolverHUDDidDisappearStatus:
            [acti stopAnimating];
            break;
        default:
            break;
    }
}
@end
