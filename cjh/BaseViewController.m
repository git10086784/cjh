//
//  BaseViewController.m
//  zxjy
//
//  Created by yale on 15-6-13.
//  Copyright (c) 2015年 武汉亦鸟科技有限公司. All rights reserved.
//

#import "BaseViewController.h"
@interface BaseViewController (){
}

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _customLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 0, 100, 30)];
        [_customLab setTextColor:[UIColor whiteColor]];
        _customLab.textAlignment = NSTextAlignmentCenter;
        _customLab.font = [UIFont boldSystemFontOfSize:20];
        self.navigationItem.titleView = _customLab;
        
        
    }
    return self;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

//去掉多余分割线
//当tableview的dataSource为空时，也就是没有数据可显示时，该方法无效，只能在numberOfRowsInsection函数，通过判断dataSouce的数据个数，如果为零可以将tableview的设置为UITableViewCellSeparatorStyleNone去掉分割线，然后在大于零时将其设置为UITableViewCellSeparatorStyleSingleLine
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    [tableView setTableFooterView:view];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
