//
//  SolverHUDWorkFlowFailed.m
//  SolverHUD
//
//  Created by JD on 16/9/5.
//  Copyright © 2016年 com.Vacn. All rights reserved.
//

#import "SolverHUDWorkFlowFailed.h"

@implementation SolverHUDWorkFlowFailed
+(SolverHUD *)solverHUD
{
    SolverHUDWorkFlowFailed *sf = [SolverHUDWorkFlowFailed new];
    sf.frame = CGRectMake(0, 0, 70, 70);
    sf.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];
    UIImageView *image = [UIImageView new];
    image.frame = sf.bounds;
    [sf addSubview:image];
    image.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"error" ofType:@"png" inDirectory:@"SolverHUDViewBundle.bundle"]];
    image.contentMode = UIViewContentModeCenter;
    sf.layer.cornerRadius = 10;
    sf.layer.masksToBounds = YES;
    return sf;
}
@end
