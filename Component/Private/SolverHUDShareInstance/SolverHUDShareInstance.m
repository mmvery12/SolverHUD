//
//  WarnSingleInstance.m
//  XF9H-HD
//
//  Created by liyuchang on 14-11-12.
//  Copyright (c) 2014年 com.Vacn. All rights reserved.
//

#import "SolverHUDShareInstance.h"
#import <objc/message.h>
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
    SEL sel = NSSelectorFromString(@"setStatus:");
    objc_msgSend(hud_,sel,SolverHUDNearMallocStatus);
    if ([instance isSuspend]) {
        return;
    }
    @synchronized(instance)
    {
        BOOL join = [hud_ valueForKey:@"joinQueue"];
        if (join && ![instance.solverQueueArr containsObject:hud_]) {
            __weak SolverHUD *lastHud;
            lastHud = [instance.solverQueueArr lastObject];
            [instance.solverQueueArr addObject:hud_];
            SEL sel = NSSelectorFromString(@"setStatus:");
            objc_msgSend(hud_,sel,SolverHUDJoinQueueStatus);
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
    SEL sel = NSSelectorFromString(@"setStatus:");
    objc_msgSend(hud_,sel,SolverHUDWillshowingStatus);
    hud_.transform = CGAffineTransformMakeScale(0.8, 0.8);
    hud_.alpha = 0.8;
    UIView *view = [hud_ valueForKey:@"showInview"];
    [view addSubview:hud_];
    [UIView animateWithDuration:[hud_ valueForKey:@"showWithAnimate"]?animatetime:0 animations:^{
        SEL sel = NSSelectorFromString(@"setStatus:");
        objc_msgSend(hud_,sel,SolverHUDAnimateingStatus);
        hud_.transform = CGAffineTransformIdentity;
        hud_.alpha = 1;
    } completion:^(BOOL finished) {
        SEL sel = NSSelectorFromString(@"setStatus:");
        objc_msgSend(hud_,sel,SolverHUDShowingStatus);
        if (hud_.duringTime!=0) {
            [self performSelector:@selector(hidden:) withObject:hud_ afterDelay:hud_.duringTime];
        }
    }];
}

-(void)hidden:(SolverHUD *)hud_
{
    [UIView animateWithDuration:[hud_ valueForKey:@"showWithAnimate"]?animatetime:0 animations:^{
        SEL sel = NSSelectorFromString(@"setStatus:");
        objc_msgSend(hud_,sel,SolverHUDAnimateingStatus);
        hud_.transform = CGAffineTransformMakeScale(0.8, 0.8);
        hud_.alpha = 0.3;
    } completion:^(BOOL finished) {
        dispatch_block_t blt = [hud_ valueForKey:@"showNext"];
        if (blt) {
            blt();
        }
        [hud_ removeFromSuperview];
        hud_.hidden = YES;
        SEL sel = NSSelectorFromString(@"setStatus:");
        objc_msgSend(hud_,sel,SolverHUDDidDisappearStatus);
        [self.solverQueueArr removeObject:hud_];
    }];
}
@end
