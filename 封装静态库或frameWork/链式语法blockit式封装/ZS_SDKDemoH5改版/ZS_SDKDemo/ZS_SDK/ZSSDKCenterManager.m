//
//  ZSSDKCenterManager.m
//  ZS_SDKDemo
//
//  Created by HUN on 16/8/25.
//  Copyright © 2016年 com.zeustel.zssdk. All rights reserved.
//

#import "ZSSDKCenterManager.h"

#import "ZS_UIWebViewController.h"

@interface ZSSDKCenterManager ()

@property(nonatomic,weak)id<ZS_SDKDelegate> delegate;

@property(nonatomic,strong)dispatch_queue_t queue;

@end

@implementation ZSSDKCenterManager
{
    UIViewController *managerVC;
    ZS_UIWebViewController *nowWebVC;
}

-(instancetype)init
{
    return nil;
}

-(instancetype)initWithDelegate:(id<ZS_SDKDelegate>)delegate
                       andQueue:(dispatch_queue_t )queue
{
    if (self = [super init])
    {
        self.delegate = delegate;
        self.queue = queue;
    }
    return self;
}


-(void)setDatasource:(id<ZS_SDKDatasoure>)datasource
{
    _datasource = datasource;
    if ([_datasource respondsToSelector:@selector(zs_webPresentedWithRootViewcontroller)])
    {
        managerVC = [_datasource zs_webPresentedWithRootViewcontroller];
    }
}
#pragma mark 对外的方法

//页面弹出加载H5
-(void)managerConfigWithWebUrl:(NSString *)webUrl
{
    if (managerVC) {
        ZS_UIWebViewController *webVC = [[ZS_UIWebViewController alloc]init];
        webVC.requestStr = webUrl;
        
        if ([self.delegate respondsToSelector:@selector(zs_webFeedBackJSContent:)]) {
            webVC.feedBackBlock = ^(NSURL *url,UIWebView *webView){
                [self.delegate zs_webFeedBackJSContent:url];
            };
        }
        
        [managerVC presentViewController:webVC animated:YES completion:nil];
        nowWebVC = webVC;
    }
}


-(void)sendToWebWithJSCommand:(NSString *)JSCommand
{
    nowWebVC.jsCommandStr = JSCommand;
}


@end
