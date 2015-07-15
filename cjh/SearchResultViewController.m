//
//  SearchResultViewController.m
//  qcxx
//
//  Created by yale on 15-5-25.
//  Copyright (c) 2015年 武汉亦鸟科技有限公司. All rights reserved.
//

#import "SearchResultViewController.h"

@interface SearchResultViewController ()
@end
NSMutableArray *arrayData;
int cData;
@implementation SearchResultViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reflushTableView:)
                                                 name:@"toChangeTableView"
                                               object:nil];
    [self setExtraCellLineHidden:self.tableView];
    //self.tableView.layer.borderWidth = 1;
    //self.tableView.layer.borderColor = [[UIColor blackColor] CGColor];
}

-(void)reflushTableView:(NSNotification*)aNotification
{
    NSDictionary *userInfo = aNotification.userInfo;
    NSString *searchText = [userInfo objectForKey:@"searchText"];
    arrayData = [[NSMutableArray alloc] initWithArray:@[@"推荐",@"鉴定",@"评估",@"基础",@"中级",@"高级",@"特级",@"特te级"]];
    cData = [arrayData count];
    [self.tableView reloadData ];
}

//去掉多余分割线
//当tableview的dataSource为空时，也就是没有数据可显示时，该方法无效，只能在numberOfRowsInsection函数，通过判断dataSouce的数据个数，如果为零可以将tableview的设置为UITableViewCellSeparatorStyleNone去掉分割线，然后在大于零时将其设置为UITableViewCellSeparatorStyleSingleLine
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cData;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.text = [arrayData objectAtIndex:indexPath.row];
     return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_H;
}

@end
