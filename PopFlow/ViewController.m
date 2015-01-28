//
//  ViewController.m
//  WarnView
//
//  Created by liyuchang on 15-1-28.
//  Copyright (c) 2015年 com.Vacn. All rights reserved.
//

#import "ViewController.h"
#import "Pop.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    PopViewOfWait *temp = [PopViewOfWait ShowWarnViewWaitingActivity:@"" animate:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [PopSingleInstance forceDismissWin:temp];
        [PopViewOfWorkFlow ShowWarnViewSuccess:@"abc" during:2 joinQueue:YES animate:YES];
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
