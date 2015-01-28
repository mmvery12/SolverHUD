//
//  WarnView.h
//  XF9H-HD
//
//  Created by liyuchang on 14-11-4.
//  Copyright (c) 2014年 com.Vacn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PopWindow.h"

@interface PopViewOfWorkFlow : PopWindow
+(UIView *)ShowWarnViewSuccess:(NSString *)string during:(NSTimeInterval)time joinQueue:(BOOL)join animate:(BOOL)animate;
+(UIWindow *)ShowWarnViewError:(NSString *)string during:(NSTimeInterval)time joinQueue:(BOOL)join animate:(BOOL)animate;
@end
