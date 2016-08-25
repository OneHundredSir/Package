//
//  ZSWebViewController.h
//  JS_OC_MessageHandler
//
//  Created by HUN on 16/8/12.
//  Copyright © 2016年 Haley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZS_UIWebViewController : UIViewController

//网络请求页面
@property(nonatomic,strong)NSString *requestStr;


@property(nonatomic,copy)NSString *jsCommandStr;
//传入的页面进入一开始调用JSblock
@property(nonatomic,copy)void(^loadWebJSBlock)(UIWebView *webview);

//返回的网页数据
@property(nonatomic,copy)void(^feedBackBlock)(NSURL *urlFromWeb,UIWebView *webview);


@end
