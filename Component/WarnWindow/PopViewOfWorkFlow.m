//
//  WarnView.m
//  XF9H-HD
//
//  Created by liyuchang on 14-11-4.
//  Copyright (c) 2014年 com.Vacn. All rights reserved.
//

#import "PopViewOfWorkFlow.h"
#import "PopView.h"
@implementation PopViewOfWorkFlow
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
    self.windowLevel = 101;
    [self.rootViewController.view addSubview:wait];
}

+(PopViewOfWorkFlow *)WarnWindowAddView:(UIView *)cover during:(NSTimeInterval)time  joinQueue:(BOOL)join animate:(BOOL)animate
{
    PopViewOfWorkFlow *window = [[PopViewOfWorkFlow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.time = time;
    window.joinQueue = join;
    window.animate = animate;
    [window addView:cover];
    [PopSingleInstance ShowWarn:window];
    return window;
}

+(UIView *)ShowWarnViewSuccess:(NSString *)string during:(NSTimeInterval)time  joinQueue:(BOOL)join animate:(BOOL)animate
{
    CGRect rect = CGRectZero;
    CGFloat width = ipad?60:44;
    if (string) {
        rect = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width*WarnViewPercent-width-10-10, 10000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
        
    }
    CGFloat tal = rect.size.width+width+10+10;
    CGFloat height = 10+rect.size.height+10;
    PopView *cover = [PopView panner:tal height:height allBlack:NO];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, (height-width)/2.0, width, width)];
    image.contentMode = UIViewContentModeCenter;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"success" ofType:@"png" inDirectory:@"WarnViewBundle.bundle"];
    image.image = [UIImage imageWithContentsOfFile:path];
    [cover.blackPan addSubview:image];
    if (string) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x, 0, rect.size.width, height)];
        label.backgroundColor = [UIColor clearColor];
        label.text = string;
        label.numberOfLines = 0;
        label.textColor = [UIColor whiteColor];
        [cover.blackPan addSubview:label];
        label.font = [UIFont systemFontOfSize:20];
    }
    return [PopViewOfWorkFlow WarnWindowAddView:cover during:time joinQueue:join animate:animate];
}

+(UIView *)ShowWarnViewError:(NSString *)string during:(NSTimeInterval)time  joinQueue:(BOOL)join animate:(BOOL)animate
{
    CGRect rect = CGRectZero;
    CGFloat width = ipad?60:44;
    if (string) {
        rect = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width*WarnViewPercent-width-10-10, 10000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
        
    }
    CGFloat tal = rect.size.width+width+10+10;
    CGFloat height = 10+rect.size.height+10;
    PopView *cover = [PopView panner:tal height:height allBlack:NO];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, (height-width)/2.0, width, width)];
    image.contentMode = UIViewContentModeCenter;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"error" ofType:@"png" inDirectory:@"WarnViewBundle.bundle"];
    image.image = [UIImage imageWithContentsOfFile:path];
    [cover.blackPan addSubview:image];
    if (string) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x, 0, rect.size.width, height)];
        label.backgroundColor = [UIColor clearColor];
        label.text = string;
        label.numberOfLines = 0;
        label.textColor = [UIColor whiteColor];
        [cover.blackPan addSubview:label];
        label.font = [UIFont systemFontOfSize:20];
    }
    return [PopViewOfWorkFlow WarnWindowAddView:cover during:time joinQueue:join animate:animate];
}

@end
