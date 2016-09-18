//
//  SolverHUD.h
//  SolverHUD
//
//  Created by JD on 16/9/2.
//  Copyright © 2016年 com.Vacn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SolverHUDPosition){
    SolverHUDTopPosition,//after top around 64px
    SolverHUDMiddlePosition,//center
    SolverHUDBottomPosition//behand bottom around 64px
};
typedef NS_ENUM(NSInteger,SolverHUDStatus) {
    SolverHUDNearMallocStatus,//刚创建
    SolverHUDJoinQueueStatus,//刚加入队列开始瞬间
    SolverHUDInAnimateingStatus,//载入动画开始瞬间
    SolverHUDShowingStatus,//正在显示(加到superview后)开始瞬间
    SolverHUDOutAnimateingStatus,//载出动画开始瞬间
    SolverHUDDidDisappearStatus//将要消失开始瞬间
};

#import "SolverHUDDelegate.h"
@interface SolverHUD : UIView<SolverHUDDelegate>
@property (nonatomic,readonly,assign)BOOL isCatchingUserInteraction;//禁用响应链
@property (nonatomic,readonly,assign)SolverHUDPosition position;//当前设置的显示位置
@property (nonatomic,readonly,assign)SolverHUDStatus status;//当前UI的状态
@property (nonatomic,readonly,assign)NSTimeInterval duringTime;//当前设置的持续时间，UI正在显示的时候不可改变
@property (nonatomic,readonly,assign)BOOL manimate;
/*******************************
 下面2个方法会讲需要pop的加入到自定义的view之中
 ScheduledShowInView 加入pop queue，队列显示
 ShowInView 不加入pop queue，立即显示
*******************************/
+(id)ScheduledShowInView:(UIView *)view position:(SolverHUDPosition)position catchUI:(BOOL)tryCatchUI animate:(BOOL)animate during:(NSTimeInterval)during;

+(id)ShowInView:(UIView *)view position:(SolverHUDPosition)position catchUI:(BOOL)tryCatchUI animate:(BOOL)animate during:(NSTimeInterval)during;

/*******************************
 下面2个方法会讲需要pop的加入到自定义的window之中
 ScheduledShowInView 加入pop queue，队列显示
 ShowInView 不加入pop queue，立即显示
 *******************************/
+(id)ScheduledShowInWindowWithPosition:(SolverHUDPosition)position catchUI:(BOOL)tryCatchUI animate:(BOOL)animate during:(NSTimeInterval)during;

+(id)ShowInWindowWithPosition:(SolverHUDPosition)position catchUI:(BOOL)tryCatchUI animate:(BOOL)animate during:(NSTimeInterval)during;

/* 默认position ＝ center ／ catchUI ＝ true ／ show animate ＝ true ／ duringtime ＝ 3s */
+(id)ScheduledShowInView:(UIView *)view;
+(id)ShowInView:(UIView *)view;

+(id)ScheduledShowInWindow;
+(id)ShowInWindow;
@end


@interface SolverHUD (Params)
+(id)ScheduledShowInView:(UIView *)view params:(id)params;
+(id)ShowInView:(UIView *)view params:(id)params;

+(id)ScheduledShowInWindowWithParams:(id)params;
+(id)ShowInWindowWithParams:(id)params;

+(id)ScheduledShowInView:(UIView *)view params:(id)params during:(NSTimeInterval)during;
+(id)ShowInView:(UIView *)view params:(id)params during:(NSTimeInterval)during;

+(id)ScheduledShowInWindowWithParams:(id)params during:(NSTimeInterval)during;
+(id)ShowInWindowWithParams:(id)params during:(NSTimeInterval)during;
@end
