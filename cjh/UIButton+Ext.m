//
//  UIButton+Ext.m
//  cjh
//
//  Created by yale on 15-7-12.
//  Copyright (c) 2015年 武汉亦鸟科技有限公司. All rights reserved.
//

#import "UIButton+Ext.h"
#import <UIKit/UIKit.h>
#import "UIImage+Ext.h"
@implementation UIButton(Ext)
- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType {
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-8.0,0.0,0.0,0.0)];
    [self setImage:[image transformWidth:24 height:24] forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(-8,10,0.0,-10)];
    [self setTitle:title forState:stateType];
    [self setTitleColor:SYS_TEXT_COLOR forState:stateType];
}
@end
