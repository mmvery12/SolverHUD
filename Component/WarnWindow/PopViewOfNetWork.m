//
//  WarnViewOfNetWork.m
//  XF9H-HD
//
//  Created by liyuchang on 14-11-10.
//  Copyright (c) 2014年 com.Vacn. All rights reserved.
//

#import "PopViewOfNetWork.h"
#import "PopView.h"
@implementation PopViewOfNetWork
-(WarnStyle)decsription
{
    return NetWork;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)addView:(UIView *)wait
{
    UIViewController *ctr = [[UIViewController alloc] init];
    ctr.view.backgroundColor = [UIColor clearColor];
    self.rootViewController = ctr;
    self.windowLevel = 102;
    [self.rootViewController.view addSubview:wait];
}

+(PopViewOfNetWork *)WarnWindowAddView:(UIView *)cover during:(NSTimeInterval)time joinQueue:(BOOL)join  animate:(BOOL)animate
{
    PopViewOfNetWork *window = [[PopViewOfNetWork alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [window addView:cover];
    window.time = time;
    window.joinQueue = join;
    window.animate = animate;
    [PopSingleInstance ShowWarn:window];
    return window;
}

+(UIView *)ShowWarnNoNetClient:(NSString *)string during:(NSTimeInterval)time joinQueue:(BOOL)join animate:(BOOL)animate
{
    PopView *cover = [PopView panner:0.618 height:74 allBlack:NO];
    UILabel *label = [[UILabel alloc] initWithFrame:cover.bounds];
    label.text = string;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:28];
    label.textAlignment = NSTextAlignmentCenter;
    [cover addSubview:label];
    cover.blackPan.layer.cornerRadius = 8.0;
    cover.blackPan.layer.masksToBounds = YES;
    return [PopViewOfNetWork WarnWindowAddView:cover during:time joinQueue:join animate:animate];
}

@end
