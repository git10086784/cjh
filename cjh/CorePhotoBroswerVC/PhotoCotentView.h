//
//  PhotoCotentView.h
//  CorePhotoBroswerVC
//
//  Created by 冯成林 on 15/5/15.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PhotoCotentView : UIScrollView



-(void)setImage:(UIImage *)image index:(NSString *)idx;
-(void)updateImage:(UIImage *)image index:(NSString *) idx;

@property (nonatomic,copy) void (^ClickImageBlock)(NSUInteger index);




@end
