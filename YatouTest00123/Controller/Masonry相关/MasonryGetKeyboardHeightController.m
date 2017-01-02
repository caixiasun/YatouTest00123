//
//  MasonryGetKeyboardHeightController.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/30.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "MasonryGetKeyboardHeightController.h"
#import "CustomView_GetKeyboardHeight_Masonry.h"
#import "AppDelegate.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface MasonryGetKeyboardHeightController ()<CustomView_GetKeyboardHeight_MasonryDelegate>

@end

@implementation MasonryGetKeyboardHeightController

- (void)loadView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [AppDelegate shareInstance].isLandspace = YES;
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    [AppDelegate shareInstance].isLandspace = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CustomView_GetKeyboardHeight_Masonry createViewInView:self.view Delegate:self];
    
    
    //注册通知，监听屏幕方向改变事件。
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    UITextField *tf = [UITextField new];
    tf.frame = CGRectMake(100, 210, 200, 30);
    tf.backgroundColor = [UIColor whiteColor];
    tf.placeholder = @"输入内容：";
    [self.view addSubview:tf];
    
}

//通过改变self.view.transform，在视觉上让用户觉得屏幕旋转了
- (void)deviceOrientationDidChange
{
    NSLog(@"deviceOrientationDidChange:%ld",(long)[UIDevice currentDevice].orientation);
    if([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
        [self orientationChangeWithStatus:2];
        //注意： UIDeviceOrientationLandscapeLeft 与 UIInterfaceOrientationLandscapeRight
    } else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft) {
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
        [self orientationChangeWithStatus:1];
    }else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft];
        [self orientationChangeWithStatus:3];
    }
}

- (void)orientationChangeWithStatus:(int)landscapeRight
{
    if (landscapeRight == 1) {//左横屏
        [UIView animateWithDuration:0.2f animations:^{
            self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.view.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    } else if (landscapeRight == 2){//竖屏
        [UIView animateWithDuration:0.2f animations:^{
            self.view.transform = CGAffineTransformMakeRotation(0);
            self.view.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    }else {//右横屏
        [UIView animateWithDuration:0.2f animations:^{
            self.view.transform = CGAffineTransformMakeRotation(-M_PI_2);
            self.view.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    }
}



//横屏
- (BOOL)shouldAutorotate {
    return NO;
}
/*
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}
*/


- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

/**横屏
 1、模态弹出界面横屏方法：
 （1）在APPDelete.h中声明属性：
 @property (nonatomic, assign) BOOL isLandspace;
 
 （2）在APPDelete.m中实现如下方法：
 - (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
 if (self.isLandspace) {
 return UIInterfaceOrientationMaskLandscape ;
 }
 return UIInterfaceOrientationMaskPortrait;
 }
 
  （3）在需要横屏的controller中的viewWillAppear方法中设置：
 [AppDelegate shareInstance].isLandspace = YES;
 
  （4）在该controller中的viewWillDisappear方法中设置：
 [AppDelegate shareInstance].isLandspace = NO;
 
  (5)如果刚进入该界面时是竖屏，你可以通过如下方法设置界面初始方向：（ios6 加入该方法。 该方法默认值为Info.plist 中配置的 Supported interface orientations 项的值。所以通过这个方法，也可以达到全局控制。）
 - (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
 return UIInterfaceOrientationLandscapeLeft;
 }
 
  （6）存在问题：
 退出该界面后返回的界面初始状态仍然是横屏。
 
 2、
 *
 */
