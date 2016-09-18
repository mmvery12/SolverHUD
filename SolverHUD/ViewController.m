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
//    [SolverHUDTextDailog ScheduledShowInView:self.view withText:@"asdasdasdasdsadsdasdasdsadasdasdasdsadasdasdsadasdsadsadasdasdas"];
    [SolverHUDWorkFlowFailed ScheduledShowInView:self.view];

    UILabel *label1 = [UILabel new];
    UILabel *label2 = [UILabel new];
    CGSize size;
    CGRect frame;
    UIFont *font = [UIFont systemFontOfSize:16];
    {
        frame = CGRectMake(30 , 30, MAXFLOAT, MAXFLOAT);
        label1.font = font;
        label1.numberOfLines = 0;
        label1.text = @"备注123123123123123112222222212123123123123123123123123112222222212123123123123123123123123112222222212123123123123123123123123112222222212123123123123123123123123112222222212123123123";
        size = [label1 sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        size.width = CGRectGetWidth(self.view.frame)-30-30;
        label1.lineBreakMode = NSLineBreakByTruncatingTail;
        frame.size = size;
        label1.frame = frame;
    }
    {
        frame = CGRectMake(30, CGRectGetMaxY(label1.frame)+30, 1000, 1000);
        label2.font = font;
        label2.text = @"1.发票要伐，发票发票";
        size = [label2 sizeThatFits:CGSizeMake(1000, 1000)];
        frame.size = size;
        label2.frame = frame;
    }
    [self.view addSubview:label1];
    [self.view addSubview:label2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
