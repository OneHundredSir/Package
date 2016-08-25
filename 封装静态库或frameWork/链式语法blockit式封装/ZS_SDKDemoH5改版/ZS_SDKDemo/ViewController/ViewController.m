//
//  ViewController.m
//  ZS_SDKDemo
//
//  Created by HUN on 16/8/24.
//  Copyright © 2016年 com.zeustel.zssdk. All rights reserved.
//

#import "ViewController.h"
//#import "ZS_UIWebViewController.h"
#import "ZSSDKManager.h"
@interface ViewController ()<ZS_SDKDatasoure,ZS_SDKDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self _initIcon];
}


-(void)_initIcon
{
    UIButton *btn =[ [UIButton alloc]initWithFrame:(CGRect){0,0,100,100}];
    btn.backgroundColor = [UIColor redColor];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


//SDK调用部分
static NSString *webUrl = @"http://www.baidu.com";
-(void)btnAction
{
    shareZSSDKManager().setDelegate(self).setDatasource(self).sendToWeb(webUrl);
}


#pragma mark delegate
-(void)zs_webFeedBackJSContent:(NSURL *)urlFromWeb
{
    NSString *jsString  = @"alert('Nihao');";
    shareZSSDKManager().sendJSCommandToWeb(jsString);
    NSLog(@"%@",urlFromWeb);
}


#pragma mark datasource
-(UIViewController *)zs_webPresentedWithRootViewcontroller
{
    
    return self;
}

@end
