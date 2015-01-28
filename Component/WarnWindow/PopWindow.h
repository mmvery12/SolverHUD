//
//  WarnWindow.h
//  XF9H-HD
//
//  Created by liyuchang on 14-11-12.
//  Copyright (c) 2014年 com.Vacn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopSingleInstance.h"
typedef void (^NextShow) (void);
@interface PopWindow : UIWindow

typedef enum {
    Wait = 1,
    NetWork,
    Extern
}WarnStyle;

-(WarnStyle)decsription;

+(void)forceDismiss:(PopWindow *)window;
@property (nonatomic,assign)BOOL joinQueue;
@property (nonatomic,assign)BOOL animate;
@property (nonatomic,assign)NSTimeInterval time;
@property (nonatomic,copy)NextShow next;
@end
