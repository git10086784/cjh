//
//  MyTableViewCell.m
//  cjh
//
//  Created by yale on 15-7-12.
//  Copyright (c) 2015年 武汉亦鸟科技有限公司. All rights reserved.
//

#import "MyTableViewCell.h"
#import "UIImage+Ext.h"
@implementation MyTableViewCell

//重载layoutSubviews
- (void)layoutSubviews
{
    UIImage *img = self.imageView.image;
    self.imageView.image = [img transformWidth:24 height:24];
    [super layoutSubviews];
    self.imageView.image = img;
}

@end
