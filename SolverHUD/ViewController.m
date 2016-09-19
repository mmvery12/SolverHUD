//
//  ViewController.m
//  WarnView
//
//  Created by liyuchang on 15-1-28.
//  Copyright (c) 2015年 com.Vacn. All rights reserved.
//

#import "ViewController.h"
#import "SolverHUDConf.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
//    [SolverHUDGIF ScheduledShowInView:self.view withImages:@[(id)[UIImage imageNamed:@"microphone1"].CGImage,
//                                                             (id)[UIImage imageNamed:@"microphone2"].CGImage,
//                                                             (id)[UIImage imageNamed:@"microphone3"].CGImage]];
    [SolverHUDTextDailog ScheduledShowInView:self.view withText:@"asdasdasdasdsadsdasdasdsadasdasdasdsadasdasdsadasdsadsadasdasdas"];
//    [SolverHUDWorkFlowFailed ScheduledShowInView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
