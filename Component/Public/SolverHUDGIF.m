//
//  SolverHUDGIF.m
//  SolverHUD
//
//  Created by JD on 16/9/2.
//  Copyright © 2016年 com.Vacn. All rights reserved.
//

#import "SolverHUDGIF.h"

@interface SolverHUDGIF ()
@property (nonatomic,copy)NSArray *images;
@end

@implementation SolverHUDGIF
+(SolverHUD *)solverHUD:(id)params
{
    SolverHUDGIF *sf = [SolverHUDGIF new];
    sf.layer.cornerRadius = 8;
    sf.layer.masksToBounds = YES;
    sf.clipsToBounds = YES;
    sf.frame = CGRectMake(0, 0, 100, 100);
    sf.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.8];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:sf.bounds];
    [sf addSubview:image];
    image.tag = 10086;
    sf.images = params;
    image.image = [UIImage imageWithCGImage:(__bridge CGImageRef _Nonnull)([params firstObject])];
    return sf;
}

-(void)hudStatusDidChange:(SolverHUDStatus)status;
{
    if (status == SolverHUDShowingStatus) {
        [self animatebegin];
    }
    if (status == SolverHUDOutAnimateingStatus) {
        [self animateend];
    }
}

-(void)animatebegin
{
    UIImageView *imageView = (id)[self viewWithTag:10086];
    [imageView.layer addAnimation:[self keyAniamte] forKey:@"animate"];
}

-(void)animateend
{
    UIImageView *imageView = (id)[self viewWithTag:10086];
    [imageView.layer removeAllAnimations];
}

-(CAKeyframeAnimation *)keyAniamte
{
    CAKeyframeAnimation *anio = [CAKeyframeAnimation animation];;
    anio.keyPath = @"contents";
    anio.removedOnCompletion = NO;
    anio.fillMode = kCAFillModeForwards;
    anio.repeatCount = INT_MAX;
    anio.duration = 3;
    anio.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    anio.values= self.images;
    return anio;
}


+(id)ScheduledShowInView:(UIView *)view withImages:(NSArray *)imgs;
{
    return [super ScheduledShowInView:view params:imgs during:0];
}

+(id)ShowInView:(UIView *)view  withImages:(NSArray *)imgs;
{
    return [super ShowInView:view params:imgs during:0];
}

+(id)ScheduledShowInWindowWithImages:(NSArray *)imgs;
{
    return [super ScheduledShowInWindowWithParams:imgs during:0];
}

+(id)ShowInWindowWithImages:(NSArray *)imgs;
{
    return [super ShowInWindowWithParams:imgs during:0];
}


@end
