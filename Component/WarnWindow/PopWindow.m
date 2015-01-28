//
//  WarnWindow.m
//  XF9H-HD
//
//  Created by liyuchang on 14-11-12.
//  Copyright (c) 2014年 com.Vacn. All rights reserved.
//

#import "PopWindow.h"
@implementation PopWindow
-(WarnStyle)decsription
{
    return -1;
}
+(void)forceDismiss:(PopWindow *)window
{
    [PopSingleInstance forceDismissWin:window];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (void)dealloc
{
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}
@end
