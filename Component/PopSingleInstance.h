//
//  WarnSingleInstance.h
//  XF9H-HD
//
//  Created by liyuchang on 14-11-12.
//  Copyright (c) 2014年 com.Vacn. All rights reserved.
//

#import <Foundation/Foundation.h>
#define animatetime 0.2
@class PopWindow;
typedef void (^VoidBlock) (void);
@interface PopSingleInstance : NSObject
{
    BOOL _isSuspend;
}
-(void)setSuspended:(BOOL)suspend;
-(BOOL)isSuspend;
+(PopSingleInstance *)warSingleInstance;
+(void)ShowWarn:(PopWindow *)window;
+(void)forceDismissWin:(PopWindow *)win;
@end

