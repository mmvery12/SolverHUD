//
//  WarnViewOfWait.h
//  XF9H-HD
//
//  Created by liyuchang on 14-11-12.
//  Copyright (c) 2014年 com.Vacn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopWindow.h"
@interface PopViewOfWait : PopWindow
+(PopViewOfWait *)ShowWarnViewWaitingActivity:(NSString *)string animate:(BOOL)animate;
+(PopViewOfWait *)ShowWarnViewWaitingGif:(NSString *)string animate:(BOOL)animate;
@end
