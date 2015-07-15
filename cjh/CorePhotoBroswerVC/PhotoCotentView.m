//
//  PhotoCotentView.m
//  CorePhotoBroswerVC
//
//  Created by 冯成林 on 15/5/15.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "PhotoCotentView.h"

@implementation PhotoCotentView



-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGRect myFrame = self.bounds;
    
    NSUInteger maxRow = 3;
    
    NSUInteger maxCol = 3;
    
    CGFloat width = myFrame.size.width / maxRow;
    
    CGFloat height = myFrame.size.height / maxCol;

    
    //遍历
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        NSUInteger row = idx % maxRow;
        
        NSUInteger col = idx / maxCol;
        
        CGFloat x = width * row;
        
        CGFloat y = height * col;
        
        CGRect frame = CGRectMake(x, y, width, height);
        
        subView.frame = frame;
    }];
}



-(void)setImage:(UIImage *)image index:(NSString *) idx{
        UIImageView *imageV = [[UIImageView alloc] initWithImage:image];
        //设置tag
        imageV.tag = [idx intValue];
        [self addSubview:imageV];
}

-(void)updateImage:(UIImage *)image index:(NSString *) idx{
    @try{
        UIImageView *imageV = (UIImageView*)[self viewWithTag:[idx intValue] ] ;
        [imageV setImage:image];
        
        //开启事件
        imageV.userInteractionEnabled = YES;
        
        //模式
        imageV.contentMode=UIViewContentModeScaleAspectFill;
        
        imageV.clipsToBounds = YES;
        
        //添加手势
        [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchImage:)]];
    }@catch(NSException *e){
    
    }
    

}


-(void)touchImage:(UITapGestureRecognizer *)tap{
    if(_ClickImageBlock != nil) _ClickImageBlock(tap.view.tag-1);
}




@end
