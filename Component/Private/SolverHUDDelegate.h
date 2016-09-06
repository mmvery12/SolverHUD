//
//  SolverHUDDelegate.h
//  SolverHUD
//
//  Created by JD on 16/9/2.
//  Copyright © 2016年 com.Vacn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class SolverHUD;
@protocol SolverHUDDelegate <NSObject>
/*******************************
 data source
 *******************************/
@optional
+(SolverHUD *)solverHUD;

+(SolverHUD *)solverHUD:(id)params;


+(CAAnimation *)solverHUDShowAnimate;
+(CAAnimation *)solverHUDDisappearAnimate;

/*******************************
 delegaet
 *******************************/
@optional
-(void)hudStatusDidChange:(SolverHUDStatus)status;

@end
