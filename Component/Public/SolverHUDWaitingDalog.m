//
//  SolverHUDWaitingDalog.m
//  SolverHUD
//
//  Created by JD on 16/9/2.
//  Copyright © 2016年 com.Vacn. All rights reserved.
//

#import "SolverHUDWaitingDalog.h"

@implementation SolverHUDWaitingDalog
+(SolverHUD *)solverHUD
{
    SolverHUDWaitingDalog *sf = [SolverHUDWaitingDalog new];
    sf.frame = CGRectMake(0, 0, 100, 100);
    sf.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];
    UIImageView *image = [UIImageView new];
    image.frame = sf.bounds;
    [sf addSubview:image];
    image.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"success" ofType:@"png" inDirectory:@"SolverHUDViewBundle.bundle"]];
    sf.layer.cornerRadius = 10;
    sf.layer.masksToBounds = YES;
    return sf;
}

-(void)hudStatusDidChange:(SolverHUDStatus)status;
{

}
@end
