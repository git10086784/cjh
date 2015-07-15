//
//  MyOrderViewController.m
//  cjh
//
//  Created by yale on 15-7-11.
//  Copyright (c) 2015年 武汉亦鸟科技有限公司. All rights reserved.
//

#import "MyOrderViewController.h"
@interface MyOrderViewController ()

@end

@implementation MyOrderViewController



- (void)viewDidLoad
{
    self.customLab.text = @"我的订单";
    [self setUpNavigationItem];
    [super viewDidLoad];
}


- (void)setUpNavigationItem
{
    CustomBarItem *leftItem = [self.navigationItem setItemWithImage:@"back" size:CGSizeMake(24, 24) itemType:left];
    [leftItem addTarget:self selector:@selector(onclickBack) event:(UIControlEventTouchUpInside)];
}


-(void)onclickBack{
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
