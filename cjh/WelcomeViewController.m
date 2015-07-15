//
//  WelcomeViewController.m
//  zxjy
//
//  Created by yale on 15-6-12.
//  Copyright (c) 2015年 武汉亦鸟科技有限公司. All rights reserved.
//

#import "WelcomeViewController.h"
#import "OnboardingViewController.h"
#import "OneMainViewController.h"
#import "TwoMainViewController.h"
#import "ThreeMainViewController.h"
#import "FourMainViewController.h"
#import "BaseNavigationController.h"
#import "MenuUIViewController.h"
#import "REFrostedViewController.h"
@interface WelcomeViewController ()
@property UITabBarController *mainTab;
@end
OneMainViewController *v1;
TwoMainViewController *v2;
ThreeMainViewController *v3;
FourMainViewController *v4;
BaseNavigationController *mainNav;
@implementation WelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   [self.navigationController pushViewController:[self generateFirstDemoVC] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (OnboardingViewController *)generateFirstDemoVC {
    OnboardingContentViewController *firstPage = [OnboardingContentViewController contentWithTitle:@"" body:@"" image:[UIImage imageNamed:@"1@2x.jpg"] buttonText:nil action:nil];
    
    OnboardingContentViewController *secondPage = [OnboardingContentViewController contentWithTitle:@"" body:@"" image:[UIImage imageNamed:@"2@2x.jpg"] buttonText:nil action:nil];
    secondPage.movesToNextViewController = YES;
    
    OnboardingContentViewController *thirdPage = [OnboardingContentViewController contentWithTitle:@"" body:@"" image:[UIImage imageNamed:@"3@2x.jpg"] buttonText:nil action:nil];
    thirdPage.movesToNextViewController = YES;
    
    OnboardingContentViewController *fourPage = [OnboardingContentViewController contentWithTitle:@"" body:@"" image:[UIImage imageNamed:@"4@2x.jpg"] buttonText:nil action:nil];
    fourPage.movesToNextViewController = YES;
    
    OnboardingContentViewController *fivePage = [OnboardingContentViewController contentWithTitle:@"" body:@"" image:[UIImage imageNamed:@"5@2x.jpg"] buttonText:@"开始血拼" action:^{
        [self handleOnboardingCompletion];
    }];
    
    
    OnboardingViewController *onboardingVC = [OnboardingViewController onboardWithBackgroundImage:[UIImage imageNamed:@""] contents:@[firstPage, secondPage, thirdPage,fourPage,fivePage]];
    onboardingVC.shouldFadeTransitions = YES;
    onboardingVC.fadePageControlOnLastPage = YES;
    
    return onboardingVC;
}


- (void)handleOnboardingCompletion {
    
    [self setupNormalRootViewControllerAnimated:YES];
}

- (void)setupNormalRootViewControllerAnimated:(BOOL)animated {
    v1 = [[OneMainViewController alloc]init];
    v2 = [[TwoMainViewController alloc]init];
    v3 = [[ThreeMainViewController alloc]init];
    v4 = [[FourMainViewController alloc]init];
    NSArray *vc_arr=[NSArray arrayWithObjects:v1,v2,v3,v4, nil];
    NSMutableArray *nav_arr=[NSMutableArray arrayWithCapacity:3];
    NSArray *titleArray=tabbarTitleArray;
    NSArray *imgArray=tabbarImageArray;
    for (int i=0; i<vc_arr.count; i++) {
        UITabBarItem *item=[[UITabBarItem alloc] init];
        item.imageInsets = UIEdgeInsetsMake(20, 20, 20,20);
        [item  setTitleTextAttributes:@{UITextAttributeFont : [UIFont systemFontOfSize:12],UITextAttributeTextColor : RGBColor(83, 83, 83)} forState:UIControlStateNormal];
        
        [item setTitleTextAttributes:@{UITextAttributeFont : [UIFont systemFontOfSize:12],UITextAttributeTextColor : SYS_MAIN_COLOR_NORMAL} forState:UIControlStateSelected];
        [item setTitle:titleArray[i]];
        NSString* string;
        string = [@"yale" stringByAppendingString:imgArray[i]];
        UIImage *image = [UIImage imageNamed:imgArray[i]];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *imagesel = [UIImage imageNamed:string];
        imagesel = [imagesel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setImage:image];
        [item setSelectedImage:imagesel];
        __weak UIViewController *vc=vc_arr[i];
        vc.tabBarItem=item;
        
        UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 0, 100, 30)];
        [customLab setTextColor:[UIColor whiteColor]];
        customLab.textAlignment = NSTextAlignmentCenter;
        if(i==2){
                 [customLab setText:titleArray[i]];
        }
        customLab.font = [UIFont boldSystemFontOfSize:20];
        vc.navigationItem.titleView = customLab;
         mainNav=[[BaseNavigationController alloc] initWithRootViewController:vc];
        [mainNav.navigationController.navigationBar setTranslucent:NO];//设置navigationbar的半透明
        [mainNav.navigationBar setTintColor:[UIColor whiteColor]];
        [mainNav.navigationBar setBarTintColor:SYS_MAIN_COLOR_NORMAL];
        [nav_arr addObject:mainNav];
    };
    MenuUIViewController *menuController = [[MenuUIViewController alloc] init];
    
    _mainTab=[[UITabBarController alloc] init];
    _mainTab.viewControllers=nav_arr;
    _mainTab.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:_mainTab menuViewController:menuController];
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    [self presentViewController:frostedViewController animated:NO completion:^{
        
    }];

}

-(void)changeTabBar:(NSNotification*)aNotification
{
    _mainTab.selectedIndex = 0;
}

@end
