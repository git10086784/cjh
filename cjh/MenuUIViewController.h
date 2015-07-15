//
//  MenuUITableViewController.h
//  cjh
//
//  Created by yale on 15-7-10.
//  Copyright (c) 2015年 武汉亦鸟科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import "BaseViewController.h"
@interface MenuUIViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>
@property UITableView *tableView;
@end
