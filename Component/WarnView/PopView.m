//
//  Warn.m
//  XF9H-HD
//
//  Created by liyuchang on 14-11-10.
//  Copyright (c) 2014年 com.Vacn. All rights reserved.
//

#import "PopView.h"

@implementation PopView
+(PopView *)panner:(CGFloat)width height:(CGFloat)height allBlack:(BOOL)isAll
{
    PopView *allCover = [[PopView alloc] init];
    
    allCover.blackPan = [[UIView alloc] init];
    CGRect frame = CGRectZero;
    
    CGRect windowbounds = [UIScreen mainScreen].bounds;
    if (width>=1) {
        frame.size.width = width;
    }
    if (height>=1) {
        frame.size.height = height;
    }
    if ([[UIApplication sharedApplication] statusBarOrientation]==UIDeviceOrientationPortrait
        ||[[UIApplication sharedApplication] statusBarOrientation]==UIDeviceOrientationPortraitUpsideDown)
    {
        if (width<1) {
            frame.size.width = width*windowbounds.size.width;
        }
        if (height<1) {
            frame.size.height = height*windowbounds.size.height;
        }
        frame.origin.x = (windowbounds.size.width - frame.size.width)/2.0;
        frame.origin.y = (windowbounds.size.height - frame.size.height)/2.0;
        allCover.frame = CGRectMake(0, 0, windowbounds.size.width, windowbounds.size.height);
    }else
        if ([[UIApplication sharedApplication] statusBarOrientation]==UIDeviceOrientationLandscapeLeft
            ||[[UIApplication sharedApplication] statusBarOrientation]==UIDeviceOrientationLandscapeRight)
        {
            if (width<1) {
                frame.size.width = width*windowbounds.size.height;
            }
            if (height<1) {
                frame.size.height = height*windowbounds.size.width;
            }
            frame.origin.x = (windowbounds.size.height - frame.size.width)/2.0;
            frame.origin.y = (windowbounds.size.width - frame.size.height)/2.0;
            allCover.frame = CGRectMake(0, 0, windowbounds.size.height, windowbounds.size.width);
        }
    allCover.blackPan.backgroundColor = [UIColor blackColor];
    allCover.blackPan.alpha = WarnViewAlpha;
    if (isAll) {
        allCover.blackPan.frame = CGRectMake(0, 0, windowbounds.size.height, windowbounds.size.width);
    }else
        allCover.blackPan.frame = frame;
    [allCover addSubview:allCover.blackPan];
    return allCover;
}
@end
