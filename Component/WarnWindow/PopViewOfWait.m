//
//  WarnViewOfWait.m
//  XF9H-HD
//
//  Created by liyuchang on 14-11-12.
//  Copyright (c) 2014年 com.Vacn. All rights reserved.
//

#import "PopViewOfWait.h"
#import "PopView.h"
@implementation PopViewOfWait

-(WarnStyle)decsription
{
    return Wait;
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
    self.windowLevel = 100;
    [self.rootViewController.view addSubview:wait];
}

+(PopViewOfWait *)WarnWindowAddView:(UIView *)cover  animate:(BOOL)animate
{
    PopViewOfWait *window = [[PopViewOfWait alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [window addView:cover];
    window.animate = animate;
    window.joinQueue = NO;
    [PopSingleInstance ShowWarn:window];
    return window;
}


+(UIView *)ShowWarnViewWaitingActivity:(NSString *)string animate:(BOOL)animate
{
    PopView *cover = [PopView panner:ipad?120:80 height:ipad?120:80 allBlack:NO];
    UIActivityIndicatorView *ac = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [cover addSubview:ac];
    [ac startAnimating];
    ac.center = CGPointMake(cover.frame.size.width/2.0, cover.frame.size.height/2.);
    cover.blackPan.layer.cornerRadius = 5.0;
    cover.blackPan.layer.masksToBounds = YES;
    return [PopViewOfWait WarnWindowAddView:cover animate:animate];
}

+(UIView *)ShowWarnViewWaitingGif:(NSString *)string animate:(BOOL)animate
{
    UIView *cover = [PopView panner:200 height:200 allBlack:YES];
    UIWindow *window = [PopViewOfWait WarnWindowAddView:cover animate:animate];
    return window;
}
@end
