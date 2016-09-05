//
//  SolverHUD.h
//  SolverHUD
//
//  Created by JD on 16/9/2.
//  Copyright © 2016年 com.Vacn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SolverHUDDelegate.h"
typedef NS_ENUM(NSInteger,SolverHUDPosition){
    SolverHUDTopPosition = 0x01,//after top around 64px
    SolverHUDMiddlePosition,//center
    SolverHUDBottomPosition//behand bottom around 64px
};
typedef NS_ENUM(NSInteger,SolverHUDStatus) {
    SolverHUDNearMallocStatus = 1,
    SolverHUDJoinQueueStatus = 1<<1,
    SolverHUDAnimateingStatus = 1<<2,
    
    SolverHUDWillshowingStatus = 1<<3,
    SolverHUDShowingStatus = 1<<4,
    SolverHUDDidDisappearStatus = 1<<5
};
@interface SolverHUD : UIView<SolverHUDDelegate>
@property (nonatomic,readonly,assign)BOOL isCatchingUserInteraction;
@property (nonatomic,readonly,assign)SolverHUDPosition position;
@property (nonatomic,readonly,assign)SolverHUDStatus status;
@property (nonatomic,readonly,assign)NSTimeInterval duringTime;
/*******************************
 下面2个方法会讲需要pop的加入到自定义的view之中
 ScheduledShowInView 加入pop queue，队列显示
 ShowInView 不加入pop queue，立即显示
*******************************/
+(id)ScheduledShowInView:(UIView *)view position:(SolverHUDPosition)position catchUserInteraction:(BOOL)tryCatchUserInteraction showWithanimate:(BOOL)animate during:(NSTimeInterval)during;

+(id)ShowInView:(UIView *)view position:(SolverHUDPosition)position catchUserInteraction:(BOOL)tryCatchUserInteraction showWithanimate:(BOOL)animate during:(NSTimeInterval)during;

/*******************************
 下面2个方法会讲需要pop的加入到自定义的window之中
 ScheduledShowInView 加入pop queue，队列显示
 ShowInView 不加入pop queue，立即显示
 *******************************/
+(id)ScheduledShowInWindowWithPosition:(SolverHUDPosition)position catchUserInteraction:(BOOL)tryCatchUserInteraction showWithanimate:(BOOL)animate during:(NSTimeInterval)during;

+(id)ShowInWindowWithPosition:(SolverHUDPosition)position catchUserInteraction:(BOOL)tryCatchUserInteraction showWithanimate:(BOOL)animate during:(NSTimeInterval)during;

/* */
@end
