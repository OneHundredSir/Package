//
//  ViewController.m
//  ExampleObjective-C
//
//  Created by  东海 on 15/9/2.
//  Copyright (c) 2015年 ouy.Aberi. All rights reserved.
//

#import "SecondViewController.h"
#import "AnViewController.h"
#import "HyTransitions.h"
#import "HyLoginButton.h"

@interface AnViewController ()<UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *switchButton;

@end

@implementation AnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPresentControllerButton];
}

- (void)createPresentControllerButton{
    //自定义一个带动画的按钮
    HyLoginButton *loginButton = [[HyLoginButton alloc] initWithFrame:CGRectMake(20, CGRectGetHeight(self.view.bounds) - (40 + 80), [UIScreen mainScreen].bounds.size.width - 40, 40)];
    [loginButton setBackgroundColor:[UIColor colorWithRed:1 green:0.f/255.0f blue:128.0f/255.0f alpha:1]];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    
    //动画逻辑做在button上面
    [loginButton addTarget:self action:@selector(PresentViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}

- (void)PresentViewController:(HyLoginButton *)button {
    typeof(self) __weak weak = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_switchButton.on) {
            //网络正常 或者是密码账号正确跳转动画
            [button succeedAnimationWithCompletion:^{
                if (weak.switchButton.on) {
                    [weak didPresentControllerButtonTouch];
                }
            }];
        } else {
            //网络错误 或者是密码不正确还原动画
            [button failedAnimationWithCompletion:^{
                if (weak.switchButton.on) {
                    [weak didPresentControllerButtonTouch];
                }
            }];
        }
    });
}

- (void)didPresentControllerButtonTouch {
    UIViewController *controller = [SecondViewController new];
    controller.transitioningDelegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    navigationController.transitioningDelegate = self;
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return [[HyTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.5f isPush:true];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[HyTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.8f isPush:false];
}

@end
