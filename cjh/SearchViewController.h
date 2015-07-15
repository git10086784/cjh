//
//  SearchViewController.h
//  qcxx
//
//  Created by Mac on 15-5-18.
//  Copyright (c) 2015年 武汉亦鸟科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController
@property (nonatomic,copy) void(^searchBarSearch)(NSString *searchText);
@end
