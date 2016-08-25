//
//  ZSSDKProtocol.h
//  ZS_SDKDemo
//
//  Created by HUN on 16/8/24.
//  Copyright © 2016年 com.zeustel.zssdk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@protocol ZS_SDKDelegate <NSObject>

#pragma mark  数据回调,H5交互,webview返回的JS数据
-(void)zs_webFeedBackJSContent:(NSURL *)urlFromWeb;

@end


#pragma mark 数据源方法
@protocol ZS_SDKDatasoure <NSObject>
@required
-(UIViewController *)zs_webPresentedWithRootViewcontroller;
@end

#pragma mark 个推的数据源方法
@protocol ZS_GTDatasoure <NSObject>
@required
-(UIViewController *)zs_GTPresentedWithRootViewcontroller;
@end
