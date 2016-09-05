//
//  WarnSingleInstance.m
//  XF9H-HD
//
//  Created by liyuchang on 14-11-12.
//  Copyright (c) 2014年 com.Vacn. All rights reserved.
//

#import "SolverHUDShareInstance.h"
#import <objc/message.h>
#import <objc/runtime.h>
@interface SolverHUDShareInstance ()
@property (nonatomic,strong) NSMutableArray *solverQueueArr;
@end

@implementation SolverHUDShareInstance

- (instancetype)init
{
    self = [super init];
    if (self) {
        _solverQueueArr = [NSMutableArray array];
    }
    return self;
}

-(void)setSuspended:(BOOL)suspend
{
    _isSuspend = suspend;
}

-(BOOL)isSuspend
{
    return _isSuspend;
}

+(SolverHUDShareInstance *)shareInstance
{
    static SolverHUDShareInstance *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [SolverHUDShareInstance new];
    });
    return share;
}

+(void)ShowSolverHUD:(SolverHUD *)hud_
{
    __weak SolverHUDShareInstance *instance = [SolverHUDShareInstance shareInstance];
    [instance perHUD:hud_ status:SolverHUDNearMallocStatus];
    if ([instance isSuspend]) {
        return;
    }
    @synchronized(instance)
    {
        if ([instance hudShouldAnimate:hud_]) {
            [hud_ setValue:^(CAAnimation *anio){
                [instance hudAnimationDidStart:anio];
            } forKey:@"animateStart"];
            [hud_ setValue:^(CAAnimation *anio){
                [instance hudAnimationDidStop:anio];
            } forKey:@"animateStop"];
        }
        
        BOOL join = [hud_ valueForKey:@"joinQueue"];
        if (join && ![instance.solverQueueArr containsObject:hud_]) {
            __weak SolverHUD *lastHud;
            lastHud = [instance.solverQueueArr lastObject];
            [instance.solverQueueArr addObject:hud_];
            [instance perHUD:hud_ status:SolverHUDJoinQueueStatus];
            @synchronized (lastHud) {
                if (lastHud) {
                    dispatch_block_t blt = ^{
                        [instance show:hud_];
                    };
                    [hud_ setValue:blt forKey:@"showNext"];
                }else
                {
                    [instance show:hud_];
                }
            }
        }else
            [instance show:hud_];
    }
}

+(void)DisappearSolverHUD:(SolverHUD *)hud_;
{
    SolverHUDShareInstance *instance = [SolverHUDShareInstance shareInstance];
    @synchronized(instance)
    {
        [instance hidden:hud_];
    }
}

-(void)show:(SolverHUD *)hud_
{
    [self perHUD:hud_ status:SolverHUDWillshowingStatus];
    UIView *view = [self hudShowInView:hud_];
    [view addSubview:hud_];
    if ([self hudShouldAnimate:hud_]) {
        [self perHUD:hud_ status:SolverHUDAnimateingStatus];
        CAAnimation *anio = [self hudStartAnio:hud_];
        if (anio) {
            [hud_.layer addAnimation:anio forKey:@"showWithAnimate"];
        }
    }
}

-(void)hidden:(SolverHUD *)hud_
{
    if ([self hudShouldAnimate:hud_]) {
        [self perHUD:hud_ status:SolverHUDAnimateingStatus];
        CAAnimation *anio = [self hudStopAnio:hud_];
        if (anio) {
            [hud_.layer addAnimation:anio forKey:@"disApWithAnimate"];
        }
    }
}


-(void)hudAnimationDidStart:(CAAnimation *)anio
{
    SolverHUD *hud_ = objc_getAssociatedObject(anio, @"startAnio");
    BOOL startanimateType = [objc_getAssociatedObject(anio, @"startanimateType") boolValue];
    if (startanimateType==0) {
        [self perHUD:hud_ status:SolverHUDShowingStatus];
        if (hud_.duringTime!=0) {
            [self performSelector:@selector(hidden:) withObject:hud_ afterDelay:hud_.duringTime];
        }
    }
}

-(void)hudAnimationDidStop:(CAAnimation *)anio
{
    SolverHUD *hud_ = objc_getAssociatedObject(anio, @"stopAnio");
    BOOL stopanimateType = [objc_getAssociatedObject(anio, @"stopanimateType") boolValue];
    if (stopanimateType==1) {
        dispatch_block_t blt = [hud_ valueForKey:@"showNext"];
        if (blt) {
            blt();
        }
        [hud_ removeFromSuperview];
        hud_.hidden = YES;
        [self perHUD:hud_ status:SolverHUDDidDisappearStatus];
        [self.solverQueueArr removeObject:hud_];
        hud_ = nil;
    }
}

-(CAAnimation *)hudStartAnio:(SolverHUD *)hud_
{
    return [hud_ valueForKey:@"showAnio"];
}

-(CAAnimation *)hudStopAnio:(SolverHUD *)hud_
{
    return [hud_ valueForKey:@"disAAnio"];
}

-(UIView *)hudShowInView:(SolverHUD *)hud_
{
    return [hud_ valueForKey:@"showInview"];
}

-(BOOL)hudShouldAnimate:(SolverHUD *)hud_
{
    return [hud_ valueForKey:@"showWithAnimate"];
}

-(void)perHUD:(SolverHUD *)hud_ status:(SolverHUDStatus)status_
{
    SEL sel = NSSelectorFromString(@"setStatus:");
    objc_msgSend(hud_,sel,status_);
}
@end