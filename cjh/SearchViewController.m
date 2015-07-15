//
//  SearchViewController.m
//  qcxx
//
//  Created by Mac on 15-5-18.
//  Copyright (c) 2015年 武汉亦鸟科技有限公司. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTableViewCell.h"
#import "SearchResultViewController.h"
@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate>
@property (strong, nonatomic)  UISearchBar *searchBar;
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  UIBarButtonItem *backBt;
@property SearchResultViewController *searchResultViewController;
@property NSString *searchText;


@end
int countData = 0;
NSMutableArray *arrayData;
@implementation SearchViewController


//最适合创建一些附加的view和控件了。有一点需要注意的是，viewDidLoad会调用多次
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setTranslucent:YES];
    //self.navigationController.navigationBarHidden = true;
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH , 45)];
    self.searchBar.placeholder = @"输入课名或讲师姓名";
    self.searchBar.showsCancelButton = true;
    self.searchBar.searchResultsButtonSelected = true;
    self.searchBar.backgroundColor=[UIColor clearColor];
    for (UIView *view in self.searchBar.subviews) {//修改searchBar背景颜色
        for (id vv in [view subviews] ) {
            if ( [vv isKindOfClass: [UIButton class]] ) {
                UIButton *cancelButton = (UIButton*)vv;
                cancelButton.enabled = YES;
                [cancelButton setTitleColor: SYS_MAIN_COLOR_NORMAL forState:UIControlStateNormal];
                [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
                [cancelButton addTarget:self action:@selector(onclickBack) forControlEvents:UIControlEventTouchUpInside];
                break;
            }
        }
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
    self.searchBar.tintColor = [UIColor blueColor];
    self.searchBar.delegate = self;
    [self.navigationController.view addSubview:self.searchBar];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = true;
    UITapGestureRecognizer *singleTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.tableView addGestureRecognizer:singleTouch];
    [self setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
    [self searchData:self.searchText];
    
    _searchResultViewController = [[ SearchResultViewController alloc] initWithStyle:UITableViewStylePlain];
    [_searchResultViewController.view setFrame:CGRectMake(0, 60, SCREEN_WIDTH , 0)];//hidden
    [self.view addSubview:_searchResultViewController.view];
    
    
}
//这个一般在view被添加到superview之前，切换动画之前调用。在这里可以进行一些显示前的处理。比如键盘弹出，一些特殊的过程动画（比如状态条和navigationbar颜色）
- (void)viewDidAppear:(BOOL)animated
{
    [self.searchBar becomeFirstResponder];
}

//搜索框中的内容发生改变时 回调（即要搜索的内容改变）
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (_searchBar.text.length == 0) {
        [self setSearchControllerHidden:YES]; //控制下拉列表的隐现
    }else{
        [self setSearchControllerHidden:NO];
        
    }
    //用来通知搜索结果视图tableview的
    NSArray* paramValue = [[NSArray alloc] initWithObjects:searchText, nil];
    NSArray* paramName = [[NSArray alloc] initWithObjects:@"searchText", nil];
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:paramValue forKeys:paramName];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"toChangeTableView"
                                                            object:nil userInfo:userInfo];
}

- (void) setSearchControllerHidden:(BOOL)hidden {
    NSInteger height = hidden ? 0: SCREEN_HEIGHT;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [_searchResultViewController.view setFrame:CGRectMake(0, 65, SCREEN_WIDTH , height)];
    [UIView commitAnimations];
}

//搜索刚完成
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.text = @"";
}
//搜索结束
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    //searchBar.showsCancelButton = NO;
}

//DidEndDecelerating停止减速的时候开始执行，而DidEndDragging停止拖拽的时候开始执行
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}

-(void)dismissKeyboard:(id)sender{
    [self.searchBar resignFirstResponder];
}
-(void)onclickBack:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void) searchData:(NSString *) searchText{
    arrayData = [[NSMutableArray alloc] initWithArray:@[@"推荐",@"鉴定",@"评估",@"基础",@"中级",@"高级",@"特级",@"特te级"]];
    countData = [arrayData count];
    [_tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark-UITableViewdataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return countData;
    
}


-(void)onclickBack{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//去掉多余分割线
//当tableview的dataSource为空时，也就是没有数据可显示时，该方法无效，只能在numberOfRowsInsection函数，通过判断dataSouce的数据个数，如果为零可以将tableview的设置为UITableViewCellSeparatorStyleNone去掉分割线，然后在大于零时将其设置为UITableViewCellSeparatorStyleSingleLine
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchTableViewCell  *cell;
    //定义一个复用标示
    static NSString *indentifier=@"SearchTableViewCell";
    //根据复用标识查找TableView里是否有可复用的cell,有则返回给cell
    cell=(SearchTableViewCell*) [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        NSArray *nib=  [[NSBundle mainBundle] loadNibNamed:indentifier owner:self options:nil];
        cell=[nib objectAtIndex:0];
        cell.name.font = [UIFont systemFontOfSize:14.0];
        cell.order.font = [UIFont systemFontOfSize:14.0];
        if(indexPath.row==0||indexPath.row == 1||indexPath.row == 2){
            cell.order.textColor = [UIColor whiteColor];
            if(indexPath.row==0){
                cell.backColor.backgroundColor = SYS_MAIN_COLOR_NORMAL;
            }else if(indexPath.row == 1){
                cell.backColor.backgroundColor = SYS_MAIN_COLOR_NORMAL;
            }else if(indexPath.row == 2){
                cell.backColor.backgroundColor = SYS_MAIN_COLOR_NORMAL;
            }
        }
        cell.order.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
        cell.name.text = [arrayData objectAtIndex:indexPath.row];
        }
    cell.backColor.layer.masksToBounds=YES;
    cell.backColor.layer.cornerRadius=4.0f;
    return cell;
}
-(void)cancleBt:(UIButton *)recognizer{

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_H;
}

#pragma mark-UITableViewdelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


@end
