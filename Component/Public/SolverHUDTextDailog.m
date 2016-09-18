//
//  SolverHUDNetStatus.m
//  SolverHUD
//
//  Created by JD on 16/9/2.
//  Copyright © 2016年 com.Vacn. All rights reserved.
//

#import "SolverHUDTextDailog.h"



@implementation SolverHUDTextDailog
+(SolverHUD *)solverHUD:(NSString *)text
{
    SolverHUDTextDailog *sf = [SolverHUDTextDailog new];
    sf.layer.cornerRadius = 8;
    sf.layer.masksToBounds = YES;
    sf.clipsToBounds = YES;
    sf.frame = CGRectMake(0, 0, 100, 100);
    sf.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.8];
    UILabel *label =[UILabel new];
    label.tag = 10086;
    label.text = text;
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:16];
    [sf addSubview:label];
    return sf;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    UILabel *label = (id)[self viewWithTag:10086];
    CGRect frame = self.superview.bounds;
    frame = [label.text boundingRectWithSize:CGSizeMake(frame.size.width-60, CGFLOAT_MAX-60) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    frame.origin.x = frame.origin.y = 15;
    label.frame = frame;
    
    frame.size.width+=30;
    frame.size.height+=30;
    self.frame = frame;
}

+(id)ScheduledShowInView:(UIView *)view withText:(NSString *)text;
{
    return [super ScheduledShowInView:view params:text];
}

+(id)ShowInView:(UIView *)view  withText:(NSString *)text;
{
    return [super ShowInView:view params:text];
}

+(id)ScheduledShowInWindowWithText:(NSString *)text;
{
    return [super ScheduledShowInWindowWithParams:text];
}

+(id)ShowInWindowWithText:(NSString *)text;
{
    return [super ShowInWindowWithParams:text];
}

@end
