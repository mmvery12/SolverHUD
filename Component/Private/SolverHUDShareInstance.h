//
//  WarnSingleInstance.h
//  XF9H-HD
//
//  Created by liyuchang on 14-11-12.
//  Copyright (c) 2014年 com.Vacn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SolverHUDView.h"
/*******************************
    view show & dismiss 动作
 *******************************/
#define animatetime 0.2
@class SolverHUDWindow;
typedef void (^VoidBlock) (void);
@interface SolverHUDShareInstance : NSObject
{
    BOOL _isSuspend;
}
-(void)setSuspended:(BOOL)suspend;
-(BOOL)isSuspend;
+(void)ShowSolverHUD:(SolverHUDView *)hud;
+(void)DisappearSolverHUD:(SolverHUDView *)hud;
@end

