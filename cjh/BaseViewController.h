//
//  BaseViewController.h
//  zxjy
//
//  Created by yale on 15-6-13.
//  Copyright (c) 2015年 武汉亦鸟科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BaseViewController : UIViewController
@property UILabel *customLab;
- (void)setExtraCellLineHidden: (UITableView *)tableView;
@end
