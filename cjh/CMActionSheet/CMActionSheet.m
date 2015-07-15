

#import "CMActionSheet.h"
#import "CMRotatableModalViewController.h"


@interface CMActionSheet ()

@property (retain) UIView *backgroundActionView;
@property (retain) UIWindow *overlayWindow;
@property (retain) UIWindow *mainWindow;
@property (retain) NSMutableArray *items;
@property (retain) NSMutableArray *callbacks;

@end

@implementation CMActionSheet

@synthesize title, backgroundActionView, overlayWindow, mainWindow, items, callbacks;

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundActionView = [[[UIView alloc] init] autorelease];
        self.backgroundActionView.backgroundColor = [UIColor whiteColor];
        self.backgroundActionView.alpha = 0.8;
        self.backgroundActionView.contentMode = UIViewContentModeScaleToFill;
        self.backgroundActionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        self.overlayWindow = [[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
        self.overlayWindow.windowLevel = UIWindowLevelStatusBar;
        self.overlayWindow.userInteractionEnabled = YES;
        self.overlayWindow.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.9f];
        self.overlayWindow.hidden = YES;
        self.backgroundActionView .layer.masksToBounds=YES;
        self.backgroundActionView .layer.cornerRadius=12.0f;
    }
    return self;
}

- (void)dealloc {
    self.backgroundActionView = nil;
    self.overlayWindow = nil;
    self.mainWindow = nil;
    self.items = nil;
    self.callbacks = nil;
    
    [super dealloc];
}

- (void)addButtonWithTitle:(NSString *)buttonTitle type:(CMActionSheetButtonType)type block:(CallbackBlock)block {
    
    NSUInteger index = 0;
    
    if (!self.items) {
        self.items = [NSMutableArray array];
    }
    if (!self.callbacks) {
        self.callbacks = [NSMutableArray array];
    }
    
    UIColor* color = nil;
    if (CMActionSheetButtonTypeBlue == type) {
        color = SYS_MAIN_COLOR_NORMAL;
    } else if (CMActionSheetButtonTypeYellow == type) {
        color = SYS_MAIN_COLOR_NORMAL;
    } else if (CMActionSheetButtonTypeRed == type) {
        color = [UIColor redColor];
    } else {
        color = SYS_MAIN_COLOR_NORMAL;
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds=YES;
    button.layer.cornerRadius=4.0f;
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    button.titleLabel.minimumFontSize = 6;
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    button.titleLabel.textAlignment = UITextAlignmentCenter;
    button.titleLabel.shadowOffset = CGSizeMake(0, -1);
    button.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    button.accessibilityLabel = buttonTitle;
    
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.items addObject:button];
    [self.callbacks addObject:block];
    
    index++;
}

- (void)present {
    if (self.items && self.items.count > 0) {
        self.mainWindow = [UIApplication sharedApplication].keyWindow;
        CMRotatableModalViewController *viewController = [[CMRotatableModalViewController new] autorelease];
        viewController.rootViewController = mainWindow.rootViewController;
        
  
        UIView* actionSheet = [[[UIView alloc] initWithFrame:CGRectMake(0, viewController.view.frame.size.height, viewController.view.frame.size.width, 0)] autorelease];
        actionSheet.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [viewController.view addSubview:actionSheet];
        
    
        self.backgroundActionView.frame = CGRectMake(0, 0, actionSheet.frame.size.width, actionSheet.frame.size.height);
        [actionSheet addSubview:self.backgroundActionView];
        
        CGFloat offset = 15;
        
     
        if (self.title) {
            CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:18]
                            constrainedToSize:CGSizeMake(actionSheet.frame.size.width-10*2, 1000)
                                lineBreakMode:UILineBreakModeWordWrap];
            
            UILabel *labelView = [[[UILabel alloc] initWithFrame:CGRectMake(10, offset, actionSheet.frame.size.width-10*2, size.height)] autorelease];
            labelView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            labelView.font = [UIFont systemFontOfSize:18];
            labelView.numberOfLines = 0;
            labelView.lineBreakMode = UILineBreakModeWordWrap;
            labelView.textColor = [UIColor whiteColor];
            labelView.backgroundColor = [UIColor clearColor];
            labelView.textAlignment = UITextAlignmentCenter;
            labelView.shadowColor = [UIColor blackColor];
            labelView.shadowOffset = CGSizeMake(0, -1);
            labelView.text = title;
            [actionSheet addSubview:labelView];
            
            offset += size.height + 10;
        }
        
 
        NSUInteger tag = 100;
        
        for (UIView *item in self.items) {
            if ([item isKindOfClass:[UIImageView class]]) {
                item.frame = CGRectMake(0, offset, actionSheet.frame.size.width, 2);
                [actionSheet addSubview:item];
                
                offset += item.frame.size.height + 10;
            } else {
                item.frame = CGRectMake(10, offset, actionSheet.frame.size.width - 10*2, 45);
                item.tag = tag++;
                [actionSheet addSubview:item];
                
                offset += item.frame.size.height + 10;
            }
        }
        
        actionSheet.frame = CGRectMake(0, viewController.view.frame.size.height, viewController.view.frame.size.width, offset + 10);
   
        self.overlayWindow.rootViewController = viewController;
        self.overlayWindow.alpha = 0.0f;
        self.overlayWindow.hidden = NO;
        [self.overlayWindow makeKeyWindow];
        
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationCurveEaseOut animations:^{
            self.overlayWindow.alpha = 1;
            CGPoint center = actionSheet.center;
            center.y -= actionSheet.frame.size.height;
            actionSheet.center = center;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.01 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                CGPoint center = actionSheet.center;
                center.y += 10;
                actionSheet.center = center;
            } completion:^(BOOL finished) {
    
                [self retain];
            }];
        }];
    }
}

- (void)dismissWithClickedButtonIndex:(NSUInteger)index animated:(BOOL)animated {
   
    UIView *actionSheet = self.overlayWindow.rootViewController.view.subviews.lastObject;
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationCurveEaseOut animations:^{
        self.overlayWindow.alpha = 0;
        CGPoint center = actionSheet.center;
        center.y += actionSheet.frame.size.height;
        actionSheet.center = center;
    } completion:^(BOOL finished) {
        self.overlayWindow.hidden = YES;
        [self.mainWindow makeKeyWindow];

        [self release];
    }];

    CallbackBlock callback = [self.callbacks objectAtIndex:index];
    callback();
}


#pragma mark - Private


- (void)buttonClicked:(id)sender {
    NSUInteger buttonIndex = ((UIView *)sender).tag - 100;
    [self dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

@end
