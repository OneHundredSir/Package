//
//  AppDelegate.m
//  hundredPersonList
//
//  Created by HUN on 16/8/25.
//  Copyright © 2016年 com.zeustel.zssdk. All rights reserved.
//

#import "AppDelegate.h"

#import "WHDMainVC.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    WHDMainVC *vc = [[WHDMainVC alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav= [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


@end
