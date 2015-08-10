//
//  Warn.h
//  XF9H-HD
//
//  Created by liyuchang on 14-11-10.
//  Copyright (c) 2014年 com.Vacn. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#define WarnViewPercent 0.618
#define WarnViewHeight 74
#define WarnViewAlpha 0.7
#ifndef ipad
#define ipad [[[UIDevice currentDevice] model] hasPrefix:@"ipad"]
#endif
#ifndef iphone
#define iphone [[[UIDevice currentDevice] model] hasPrefix:@"iphone"]
#endif
@interface PopView : UIView
@property (nonatomic,retain)UIView *blackPan;
+(PopView *)panner:(CGFloat)width height:(CGFloat)height allBlack:(BOOL)isAll;
@end
