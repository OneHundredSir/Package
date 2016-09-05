//
//  HunWebVC.m
//  hundredPersonList
//
//  Created by HUN on 16/8/30.
//  Copyright © 2016年 com.zeustel.zssdk. All rights reserved.
//

#import "HunWebVC.h"

@interface HunWebVC ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation HunWebVC

-(UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}
-(void)setWebUrl:(NSString *)webUrl
{
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:webUrl]];
    [self.webView loadRequest:request];
}


#pragma mark delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    
    
    return YES;
}

@end
