//
//  MenuUITableViewController.h
//  cjh
//
//  Created by yale on 15-7-10.
//  Copyright (c) 2015年 武汉亦鸟科技有限公司. All rights reserved.
//
#import "MenuUIViewController.h"
#import "OneMainViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "MyOrderViewController.h"
#import "UIButton+Ext.h"
@implementation MenuUIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-50, SCREEN_HEIGHT-30)];
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsHorizontalScrollIndicator = false;
    self.tableView.showsVerticalScrollIndicator = false;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        //相对父窗自动调整左边的距离，保证与右边的距离不变
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = [UIImage imageNamed:@"default-user"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 50.0;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 3.0f;
        //图片相对于layer自适应拉伸
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;//提升图层渲染技巧
        imageView.clipsToBounds = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
        label.text = @"邱金勇";
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        [label sizeToFit];//文字自适应label
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [view addSubview:imageView];
        [view addSubview:label];
        view;
    });
    [self.view addSubview:self.tableView];
    UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-30, self.tableView.frame.size.width, 70)];
    bottom.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
    bottom.layer.borderWidth = 0.5f;
    bottom.backgroundColor = [UIColor whiteColor];
    UIButton *setting = [[UIButton alloc] initWithFrame:CGRectMake(15,20, 0, 24)];
    [setting setImage:[UIImage imageNamed:@"setting"] withTitle:@"设置" forState:0];
    [setting sizeToFit];//文字自适应label
    //自动调整右边的距离，保证左边距离不变
    setting.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    [bottom addSubview:setting];
    
    UIButton *sm = [[UIButton alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width-100,20, 0, 24)];
    [sm setImage:[UIImage imageNamed:@"sm"] withTitle:@"扫一扫" forState:0];
    [sm sizeToFit];//文字自适应label
    //自动调整左边的距离，保证右边距离不变
    sm.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [bottom addSubview:sm];
    
    [self.view addSubview:bottom];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = SYS_TEXT_COLOR;
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
}

//section的style
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return nil;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    [view addSubview:label];
    
    return view;
}

//section高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 0.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        MyOrderViewController *oneMain = [[MyOrderViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:oneMain];
        navigationController.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
        [navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        [navigationController.navigationBar setBarTintColor:SYS_MAIN_COLOR_NORMAL];
        [self presentViewController:navigationController animated:NO completion:^{
        }];
    }
    [self.frostedViewController hideMenuViewController];
}



#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_H;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if(sectionIndex==0){
        return 3;
    }else if(sectionIndex==1){
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width-100, 15, 90, 20)];
    label.textColor = SYS_MAIN_COLOR_NORMAL;
    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont systemFontOfSize:12];
    if (indexPath.section == 0) {
        NSArray *titles = @[@"我的订单", @"我的小店",@"我的钱包"];
        NSArray *icons = @[@"myOrder", @"myStore", @"myBag"];
        NSArray *description = @[@"下单送优惠卷", @"", @""];
        cell.imageView.image = [UIImage imageNamed:icons[indexPath.row]];
        cell.textLabel.text = titles[indexPath.row];
        label.text = description[indexPath.row];
        
    } else if (indexPath.section == 1) {
        NSArray *titles = @[@"会员专区", @"优惠卷"];
        NSArray *icons = @[@"member", @"pv"];
        NSArray *description = @[@"每日签到有礼", @""];
        cell.imageView.image = [UIImage imageNamed:icons[indexPath.row]];
        cell.textLabel.text = titles[indexPath.row];
        label.text = description[indexPath.row];
    }else if (indexPath.section == 2) {
        NSArray *titles = @[@"帮助反馈"];
        NSArray *icons = @[@"help"];
        cell.imageView.image = [UIImage imageNamed:icons[indexPath.row]];
        cell.textLabel.text = titles[indexPath.row];
    }
    [cell.contentView addSubview:label];
    return cell;
}

@end
