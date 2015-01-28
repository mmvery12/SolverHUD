//
//  WarnViewOfNetWork.h
//  XF9H-HD
//
//  Created by liyuchang on 14-11-10.
//  Copyright (c) 2014年 com.Vacn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopWindow.h"
@interface PopViewOfNetWork : PopWindow
+(UIWindow *)ShowWarnNoNetClient:(NSString *)string during:(NSTimeInterval)time joinQueue:(BOOL)join animate:(BOOL)animate;
@end
