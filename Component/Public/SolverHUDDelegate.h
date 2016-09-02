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
@required
+(SolverHUD *)solverHUD;
@optional
+(CAKeyframeAnimation *)solverHUDShowAnimate;
+(CAKeyframeAnimation *)solverHUDDisappearAnimate;
@end
