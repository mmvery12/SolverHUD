//
//  SolverHUD.m
//  SolverHUD
//
//  Created by JD on 16/9/2.
//  Copyright © 2016年 com.Vacn. All rights reserved.
//

#import "SolverHUD.h"
#import "SolverHUDShareInstance.h"
#import <objc/runtime.h>
#import <objc/objc.h>
#import <objc/message.h>

@interface SolverHUD ()
@property (nonatomic,assign)BOOL joinQueue;
@property (nonatomic,assign)BOOL showWithAnimate;
@property (nonatomic,weak)UIView *showInview;
@property (nonatomic,assign)BOOL tryCatcheUI;

@property (nonatomic,copy)dispatch_block_t showNext;
@end


typedef SolverHUD *(*Imp)(id,SEL, ...);
@implementation SolverHUD

+(SolverHUD *)solverHUD
{
    return nil;
}

+(SolverHUD *)GenSolverHUD
{
    id hud = nil;
    
    SEL sel = NSSelectorFromString(@"solverHUD");
    Method meth = (Method)class_getClassMethod(self, sel);
    Imp imp = method_getImplementation(meth);
    if (imp) {
        hud = imp(self,sel);
    }
    return hud;
}

/*******************************
 
 *******************************/
+(id)ScheduledShowInView:(UIView *)view position:(SolverHUDPosition)position catchUserInteraction:(BOOL)tryCatchUserInteraction showWithanimate:(BOOL)animate during:(NSTimeInterval)during;
{
    id hud = [self cVi:view p:position c:tryCatchUserInteraction a:animate j:YES d:during];
    return hud;
}

+(id)ShowInView:(UIView *)view position:(SolverHUDPosition)position catchUserInteraction:(BOOL)tryCatchUserInteraction showWithanimate:(BOOL)animate during:(NSTimeInterval)during;
{
    id hud = [self cVi:view p:position c:tryCatchUserInteraction a:animate j:NO d:during];
    return hud;
}

/*******************************
 
 *******************************/
+(id)ScheduledShowInWindowWithPosition:(SolverHUDPosition)position catchUserInteraction:(BOOL)tryCatchUserInteraction showWithanimate:(BOOL)animate during:(NSTimeInterval)during;
{
    id hud = [self cVi:[UIApplication sharedApplication].keyWindow p:position c:tryCatchUserInteraction a:animate j:YES d:during];
    return hud;
}


+(id)ShowInWindowWithPosition:(SolverHUDPosition)position catchUserInteraction:(BOOL)tryCatchUserInteraction showWithanimate:(BOOL)animate during:(NSTimeInterval)during;
{
    id hud = [self cVi:[UIApplication sharedApplication].keyWindow p:position c:tryCatchUserInteraction a:animate j:NO d:during];
    return hud;
}

+(id)cVi:(UIView *)view p:(SolverHUDPosition)position c:(BOOL)tryCatchUserInteraction a:(BOOL)animate j:(BOOL)join d:(NSTimeInterval)during;
{
    SolverHUD* hud = [self GenSolverHUD];
    hud.position = position;
    hud.showInview = view;
    hud.tryCatcheUI = tryCatchUserInteraction;
    hud.joinQueue = join;
    hud.showWithAnimate = animate;
    hud.duringTime = during;
    [SolverHUDShareInstance ShowSolverHUD:hud];
    return hud;
}

-(void)setDuringTime:(NSTimeInterval)duringTime
{
    if (!(self.status & SolverHUDShowingStatus)) {
        _duringTime = duringTime;
    }
}

-(void)setPosition:(SolverHUDPosition)position
{
    _position = position;
}

-(void)setStatus:(SolverHUDStatus)status
{
    _status = status;
}

@end
