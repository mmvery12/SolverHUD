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
typedef void (*VImp)(id, SEL, ...);
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
    @synchronized (self) {
        _isSuspend = suspend;
    }
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
                    [lastHud setValue:blt forKey:@"showNext"];
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
    UIView *view = [self hudShowInView:hud_];
    [view addSubview:hud_];
    if (hud_.manimate) {
        CAAnimation *anio = [self hudStartAnio:hud_];
        if (anio) {
            [hud_.layer addAnimation:anio forKey:@"animate"];
        }
    }else
    {
        SEL sel = NSSelectorFromString(@"animationDidStart:");
        Method meth = (Method)class_getInstanceMethod(object_getClass(hud_), sel);
        if (meth) {
            VImp imp = (VImp)method_getImplementation(meth);
            imp(hud_,sel,@"animate");
        }
        
        sel = NSSelectorFromString(@"animationDidStop:finished:");
        meth = (Method)class_getInstanceMethod(object_getClass(hud_), sel);
        if (meth) {
            VImp imp = (VImp)method_getImplementation(meth);
            imp(hud_,sel,@"animate",1);
        }
    }
}

-(void)hidden:(SolverHUD *)hud_
{
    if (hud_.manimate) {
        CAAnimation *anio = [self hudStopAnio:hud_];
        if (anio) {
            [hud_.layer addAnimation:anio forKey:@"disApWithAnimate"];
        }
    }else
    {
        SEL sel = NSSelectorFromString(@"animationDidStart:");
        Method meth = (Method)class_getInstanceMethod(object_getClass(hud_), sel);
        if (meth) {
            VImp imp = (VImp)method_getImplementation(meth);
            imp(hud_,sel,@"disApWithAnimate");
        }
        
        sel = NSSelectorFromString(@"animationDidStop:finished:");
        meth = (Method)class_getInstanceMethod(object_getClass(hud_), sel);
        if (meth) {
            VImp imp = (VImp)method_getImplementation(meth);
            imp(hud_,sel,@"disApWithAnimate",1);
        }
    }
}

-(void)hudAnimationDidStart:(CAAnimation *)anio
{
    SolverHUD *hud_ = objc_getAssociatedObject(anio, @"startAnio");
    BOOL startanimateType = [objc_getAssociatedObject(anio, @"startanimateType") boolValue];
    if (startanimateType==0) {
        [self perHUD:hud_ status:SolverHUDInAnimateingStatus];
        [self tryCatchUI:hud_];
        if (hud_.duringTime!=0) {
            [self performSelector:@selector(hidden:) withObject:hud_ afterDelay:hud_.duringTime];
        }
    }
    if (startanimateType==1) {
        [self perHUD:hud_ status:SolverHUDOutAnimateingStatus];
    }
}

-(void)hudAnimationDidStop:(CAAnimation *)anio
{
    SolverHUD *hud_ = objc_getAssociatedObject(anio, @"stopAnio");
    BOOL stopanimateType = [objc_getAssociatedObject(anio, @"stopanimateType") boolValue];
    if (stopanimateType==0) {
        [self perHUD:hud_ status:SolverHUDShowingStatus];
    }
    if (stopanimateType==1) {
        [self tryUnCatchUI:hud_];
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
    return [hud_ valueForKey:@"manimate"];
}

-(void)perHUD:(SolverHUD *)hud_ status:(SolverHUDStatus)status_
{
    SEL sel = NSSelectorFromString(@"setStatus:");
    objc_msgSend(hud_,sel,status_);
}

-(void)tryCatchUI:(SolverHUD *)hud_
{
    if (hud_.isCatchingUserInteraction) {
        UIView *view = [self hudShowInView:hud_];
        view.userInteractionEnabled = NO;
    }
}

-(void)tryUnCatchUI:(SolverHUD *)hud_
{
    if (hud_.isCatchingUserInteraction) {
        UIView *view = [self hudShowInView:hud_];
        view.userInteractionEnabled = YES;
    }
}
@end
