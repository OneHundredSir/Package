//
//  Gongzhonghao.m
//  hundredPersonList
//
//  Created by HUN on 16/9/5.
//  Copyright © 2016年 com.zeustel.zssdk. All rights reserved.
//

#import "Gongzhonghao.h"

@implementation Gongzhonghao

-(void)viewDidLoad
{
    [self _initIcon];
}
-(void)_initIcon
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollV  = [[UIScrollView alloc]initWithFrame:self.view.frame];
    scrollV.bounces = NO;
    [self.view addSubview:scrollV];
 
    CGFloat imgWH = CGRectGetWidth(self.view.frame)*0.5;
    CGFloat imgX = self.view.center.x - imgWH*0.5;
    CGFloat imgY = imgWH*0.5;
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:(CGRect){imgX,imgY,imgWH,imgWH}];
    imgV.image = [UIImage imageNamed:@"gongzhonghao"];
    [scrollV addSubview:imgV];
    
    CGFloat maigin = 20;
    scrollV.contentSize = (CGSize){CGRectGetWidth(self.view.frame),maigin+imgWH+CGRectGetHeight(self.view.frame)};
    UIWebView *webView = [[UIWebView alloc]initWithFrame:(CGRect){0,imgWH+5*maigin,CGRectGetWidth(self.view.frame),CGRectGetHeight(self.view.frame)}];
    
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"gongzhong" ofType:@"gif"]];
    webView.userInteractionEnabled = NO;
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:@"UTF-8" baseURL:nil];
    //设置webview背景透明，能看到gif的透明层
    webView.opaque = NO;
    [scrollV addSubview:webView];
}

@end
