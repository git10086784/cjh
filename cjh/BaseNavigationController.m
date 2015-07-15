//
//  BaseNavigationController.m
//  cjh
//
//  Created by yale on 15-7-10.
//  Copyright (c) 2015年 武汉亦鸟科技有限公司. All rights reserved.
//
#import "UIViewController+REFrostedViewController.h"
#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)showMenu
{
    [self.frostedViewController presentMenuViewController];
}

-(void)gwAction{
    
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    [self.frostedViewController panGestureRecognized:sender];
}

@end
