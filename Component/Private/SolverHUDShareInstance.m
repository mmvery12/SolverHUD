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
#import "SolverHUDConf.h"
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

+(void)ShowSolverHUD:(SolverHUDView *)xhud_
{
    __weak typeof(xhud_) whud_ = xhud_;
    __weak SolverHUDShareInstance *instance = [SolverHUDShareInstance shareInstance];
    [instance perHUD:whud_ status:SolverHUDNearMallocStatus];
    if ([instance isSuspend]) {
        return;
    }
    @synchronized(instance)
    {
        if ([instance hudShouldAnimate:whud_]) {
            [whud_ setValue:^(CAAnimation *anio,SolverHUDView *hud,NSString *type){
                [instance hudAnimationDidStart:anio hud:hud type:type];
            } forKey:@"animateStart"];
            [whud_ setValue:^(CAAnimation *anio,SolverHUDView *hud,NSString *type){
                [instance hudAnimationDidStop:anio hud:hud type:type];
            } forKey:@"animateStop"];
        }
        BOOL join = [whud_ valueForKey:@"joinQueue"];
        if (join && ![instance.solverQueueArr containsObject:whud_]) {
            __weak SolverHUDView *lastHud;
            lastHud = [instance.solverQueueArr lastObject];
            [instance.solverQueueArr addObject:whud_];
            [instance perHUD:whud_ status:SolverHUDJoinQueueStatus];
            @synchronized (instance) {
                if (lastHud) {
                    dispatch_block_t blt = ^{
                        [instance show:whud_];
                    };
                    [lastHud setValue:blt forKey:@"showNext"];
                }else
                {
                    [instance show:whud_];
                }
            }
        }else
            [instance show:whud_];
    }
}

+(void)DisappearSolverHUD:(SolverHUDView *)hud_;
{
    SolverHUDShareInstance *instance = [SolverHUDShareInstance shareInstance];
    @synchronized(instance)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:instance selector:@selector(hidden:) object:hud_];
        [instance hidden:hud_];
    }
}

-(void)show:(SolverHUDView *)hud_
{
    UIView *view = [self hudShowInView:hud_];
    [view addSubview:hud_];
    if (hud_.manimate) {
        CAAnimation *anio = [self hudStartAnio:hud_];
        if (anio) {
            [hud_.layer addAnimation:anio forKey:KeyAppearAnimate];
        }
    }else
    {
        SEL sel = NSSelectorFromString(@"animationDidStart:");
        Method meth = (Method)class_getInstanceMethod(object_getClass(hud_), sel);
        if (meth) {
            VImp imp = (VImp)method_getImplementation(meth);
            imp(hud_,sel,KeyAppearAnimate);
        }
        
        sel = NSSelectorFromString(@"animationDidStop:finished:");
        meth = (Method)class_getInstanceMethod(object_getClass(hud_), sel);
        if (meth) {
            VImp imp = (VImp)method_getImplementation(meth);
            imp(hud_,sel,KeyAppearAnimate,1);
        }
    }
}

-(void)hidden:(SolverHUDView *)hud_
{
    if (hud_.manimate) {
        CAAnimation *anio = [self hudStopAnio:hud_];
        if (anio) {
            [hud_.layer addAnimation:anio forKey:KeyDisAppearAnimate];
        }
    }else
    {
        SEL sel = NSSelectorFromString(@"animationDidStart:");
        Method meth = (Method)class_getInstanceMethod(object_getClass(hud_), sel);
        if (meth) {
            VImp imp = (VImp)method_getImplementation(meth);
            imp(hud_,sel,KeyDisAppearAnimate);
        }
        
        sel = NSSelectorFromString(@"animationDidStop:finished:");
        meth = (Method)class_getInstanceMethod(object_getClass(hud_), sel);
        if (meth) {
            VImp imp = (VImp)method_getImplementation(meth);
            imp(hud_,sel,KeyDisAppearAnimate,1);
        }
    }
}

-(void)hudAnimationDidStart:(CAAnimation *)anio hud:(SolverHUDView *)hud type:(NSString *)type
{
    SolverHUDView *hud_ = hud;
    if ([type isEqualToString:KeyFromAppear]) {
        [self perHUD:hud_ status:SolverHUDInAnimateingStatus];
        [self tryCatchUI:hud_];
    }
    if ([type isEqualToString:KeyFromeDisAppear]) {
        [self perHUD:hud_ status:SolverHUDOutAnimateingStatus];
    }
}

-(void)hudAnimationDidStop:(CAAnimation *)anio hud:(SolverHUDView *)hud type:(NSString *)type
{
    SolverHUDView *hud_ = hud;
    if ([type isEqualToString:KeyFromAppear]) {
        [self perHUD:hud_ status:SolverHUDShowingStatus];
        if (hud_.duringTime!=0) {
            [self performSelector:@selector(hidden:) withObject:hud_ afterDelay:hud_.duringTime];
        }
        [hud_.layer removeAllAnimations];
    }
    if ([type isEqualToString:KeyFromeDisAppear]) {
        [self tryUnCatchUI:hud_];
        [hud_ removeFromSuperview];
        hud_.hidden = YES;
        [self perHUD:hud_ status:SolverHUDDidDisappearStatus];
        [self.solverQueueArr removeObject:hud_];
        
        dispatch_block_t blt = [hud_ valueForKey:@"showNext"];
        if (blt) {
            blt();
        }
        /**
         clear
         */
        [hud_ setValue:nil forKey:@"showNext"];
        [hud_ setValue:nil forKeyPath:@"showAnio.delegate"];
        [hud_ setValue:nil forKeyPath:@"disAAnio.delegate"];
        [hud_ setValue:nil forKeyPath:@"showAnio"];
        [hud_ setValue:nil forKeyPath:@"disAAnio"];
        [hud_ setValue:nil forKeyPath:@"animateStart"];
        [hud_ setValue:nil forKeyPath:@"animateStop"];
        [hud_.layer removeAllAnimations];
        hud_ = nil;
    }
}

-(CAAnimation *)hudStartAnio:(SolverHUDView *)hud_
{
    return [hud_ valueForKey:@"showAnio"];
}

-(CAAnimation *)hudStopAnio:(SolverHUDView *)hud_
{
    return [hud_ valueForKey:@"disAAnio"];
}

-(UIView *)hudShowInView:(SolverHUDView *)hud_
{
    return [hud_ valueForKey:@"showInview"];
}

-(BOOL)hudShouldAnimate:(SolverHUDView *)hud_
{
    return [hud_ valueForKey:@"manimate"];
}

-(void)perHUD:(SolverHUDView *)hud_ status:(SolverHUDStatus)status_
{
    SEL sel = NSSelectorFromString(@"setStatus:");
    objc_msgSend(hud_,sel,status_);
}

-(void)tryCatchUI:(SolverHUDView *)hud_
{
    if (hud_.isCatchingUserInteraction) {
        UIView *view = [self hudShowInView:hud_];
        view.userInteractionEnabled = NO;
    }
}

-(void)tryUnCatchUI:(SolverHUDView *)hud_
{
    if (hud_.isCatchingUserInteraction) {
        UIView *view = [self hudShowInView:hud_];
        view.userInteractionEnabled = YES;
    }
}
@end
