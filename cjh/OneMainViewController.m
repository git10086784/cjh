//
//  OneMainViewController.m
//  cjh
//
//  Created by yale on 15-7-10.
//  Copyright (c) 2015年 武汉亦鸟科技有限公司. All rights reserved.
//

#import "OneMainViewController.h"
#import "BaseNavigationController.h"
#import "BRYSerialAnimationQueue.h"
#import "EScrollerView.h"
#import "SearchViewController.h"
#import "onpagescrollview/OTPageView.h"
#import "DBImageView.h"
#define SEARCH_BAR_H 40
@interface OneMainViewController (){
    UITableView     *table;
    OTPageView *pScrollView;
    UIView *view ;
    NSArray *dataArray;
}
@property (nonatomic) BRYSerialAnimationQueue *queue;
@property (nonatomic) UIButton *button;
@end
int _lastPosition = 0;
BOOL flag = true;
@implementation OneMainViewController

- (void)viewDidLoad {
    [self setUpNavigationItem];
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addScrollViewWithItem];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 600;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"被点击");
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    SearchViewController *sfv = [[SearchViewController alloc] init];
    UINavigationController *sfvNAV=[[UINavigationController alloc] initWithRootViewController:sfv];
    sfvNAV.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
    [self presentViewController:sfvNAV animated:YES completion:^{
        
    }];
}

//代理滚动隐藏事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int currentPostion = scrollView.contentOffset.y;
    void (^updateLabelOriginY)(CGFloat) = ^(CGFloat originY) {
        CGRect frame = view.frame;
        frame.origin.y = originY;
        view.frame = frame;
    };
    if (currentPostion - _lastPosition > 25||(scrollView.contentSize.height-scrollView.contentOffset.y<=self.view.frame.size.height)) {//是否达到底部或向上滑动小于25,,,,隐藏
        _lastPosition = currentPostion;
        updateLabelOriginY(-CGRectGetHeight(view.frame));
        [self.queue animateWithDuration:0.2 animations:^{
            flag = true;
            updateLabelOriginY(-CGRectGetHeight(view.frame));
            table.y = 0;
        } completion:^(BOOL finished) {
            
        }];
    }else if (_lastPosition - currentPostion > 25||currentPostion<=0){//显示
        _lastPosition = currentPostion;
        if(flag){
            [self.view bringSubviewToFront:view];
            updateLabelOriginY(-CGRectGetHeight(view.frame));
            
            [self.queue animateWithDuration:0.2 animations:^{
                flag = false;
                updateLabelOriginY(0);
                table.y = 65+view.frame.size.height;
                
            }];
        }
    }
}

-(void)addScrollViewWithItem{
    _queue = [[BRYSerialAnimationQueue alloc] init];
    view = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SEARCH_BAR_H)];
    view.backgroundColor = [UIColor whiteColor];
    UISearchBar    *searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    searchBar.frame = CGRectMake(10, 70, view.frame.size.width/5*4-20, view.frame.size.height-10);
    for (UIView *view in searchBar.subviews) {//修改searchBar背景颜色
        // for before iOS7.0
        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [view removeFromSuperview];
            break;
        }
        // for later iOS7.0(include)
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    
    searchBar.delegate = self;
    searchBar.placeholder = @"搜索商品、店铺、用户";
    searchBar.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
    searchBar.layer.borderWidth = 1.0f;
    searchBar.layer.masksToBounds=YES;
    searchBar.layer.cornerRadius=4.0f;
    [view addSubview:searchBar];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/5*4,70, SCREEN_WIDTH/5-10, SEARCH_BAR_H-10)];
    [button addTarget:self action:@selector(toFlPage) forControlEvents:UIControlEventTouchUpInside];
    //设置按钮文字居中显示
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [button setTitle:@"分类" forState:0];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor whiteColor] forState:0];
    [button setTitleColor:[UIColor whiteColor] forState:1<<0];
    [button setTitleColor:[UIColor whiteColor] forState:1<<2];
    [button setBackgroundColor:SYS_MAIN_COLOR_NORMAL];
    button.layer.cornerRadius = 5;//背景颜色弧度
    [view addSubview:button];
    [self.view addSubview:view];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0,65+view.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = [UIColor whiteColor];
    table.showsVerticalScrollIndicator = false;
    table.showsHorizontalScrollIndicator = false;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    table.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 230.0)];
        NSArray *imgarr=@[@"http://s18.mogucdn.com/p1/150713/upload_ieytgnlggbqwmzbvgizdambqmeyde_785x500.jpg",@"http://s17.mogucdn.com/p1/150713/upload_ie2wgnldmy3gczbvgizdambqhayde_785x500.jpg",@"http://s18.mogucdn.com/p1/150713/upload_ie2tentggyydkzbvgizdambqhayde_785x500.jpg"];
        EScrollerView *scrollview=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, SCREEN_WIDTH, 150) ImageArray:imgarr TitleArray:nil];
        [view addSubview:scrollview];
        
        pScrollView = [[OTPageView alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 90)];
        pScrollView.pageScrollView.dataSource = self;
        pScrollView.pageScrollView.delegate = self;
        pScrollView.pageScrollView.padding =10;
        pScrollView.pageScrollView.leftRightOffset = 0;
        pScrollView.pageScrollView.frame = CGRectMake(10, 10, SCREEN_WIDTH, 70);
        pScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        dataArray = [NSArray arrayWithObjects:
                      @"http://img0.bdstatic.com/img/image/shouye/tpmlmxab001.jpg",
                      @"http://img0.bdstatic.com/img/image/shouye/qdwzmx002.jpg",
                      @"http://img0.bdstatic.com/img/image/shouye/huabianwl003.jpg",
                      @"http://img0.bdstatic.com/img/image/shouye/tpmlmxzs004.jpg",
                      @"http://img0.bdstatic.com/img/image/shouye/huabianwl005.jpg",
                      @"http://img0.bdstatic.com/img/image/shouye/qdmmx06.jpg",
                      @"http://img0.bdstatic.com/img/image/shouye/tpmlmxqd07.jpg",
                      @"http://img0.bdstatic.com/img/image/shouye/huabianwl003.jpg",
                      @"http://img0.bdstatic.com/img/image/shouye/tpmlmxzs004.jpg",
                      @"",nil];
        [pScrollView.pageScrollView reloadData];
        [view addSubview:pScrollView];
        
        view;
    });
    [self.view addSubview:table];

}

- (NSInteger)numberOfPageInPageScrollView:(OTPageScrollView*)pageScrollView{
    return [dataArray count];
}

- (UIView*)pageScrollView:(OTPageScrollView*)pageScrollView viewForRowAtIndex:(int)index{
    UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(0, 2, 70, 70)];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    ;
    DBImageView *imageView = [[DBImageView alloc] initWithFrame:CGRectMake(0,2, 70, 70)];
    [imageView  setPlaceHolder:[UIImage imageNamed:@""]];
    [imageView setTag:index];
    //异步加载
    [imageView  setImageWithPath:dataArray[index]];
    [cell addSubview:imageView];
    return cell;
}

- (CGSize)sizeCellForPageScrollView:(OTPageScrollView*)pageScrollView
{
    return CGSizeMake(70, 70);
}

- (void)pageScrollView:(OTPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index{
    NSLog(@"%ld",index);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    NSLog(@"%ld",index);
}


- (void)setUpNavigationItem
{
    CustomBarItem *leftItem = [self.navigationItem setItemWithImage:@"menu" size:CGSizeMake(20, 16) itemType:left];
    [leftItem addTarget:(BaseNavigationController *)self.navigationController selector:@selector(showMenu) event:(UIControlEventTouchUpInside)];
    [leftItem setOffset:0];//设置item偏移量(正值向左偏，负值向右偏)
    
    //CustomBarItem *centerItem = [self.navigationItem setItemWithTitle:@"中间的中间的中" textColor:[UIColor whiteColor] fontSize:19 itemType:center];
    CustomBarItem *centerItem = [self.navigationItem setItemWithImage:@"banner" size:CGSizeMake(150, 30) itemType:center];
    [centerItem setOffset:0];
    
    CustomBarItem *rightItem = [self.navigationItem setItemWithImage:@"gw" size:CGSizeMake(20, 16) itemType:right];
    [rightItem addTarget:(BaseNavigationController *)self.navigationController selector:@selector(gwAction) event:(UIControlEventTouchUpInside)];
    [rightItem setOffset:0];
    
}

-(void)toFlPage{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
