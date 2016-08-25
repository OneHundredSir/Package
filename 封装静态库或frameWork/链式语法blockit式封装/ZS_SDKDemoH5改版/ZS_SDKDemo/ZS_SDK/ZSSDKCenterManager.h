//
//  ZSSDKCenterManager.h
//  ZS_SDKDemo
//
//  Created by HUN on 16/8/25.
//  Copyright © 2016年 com.zeustel.zssdk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZSSDKProtocol.h"
@interface ZSSDKCenterManager : NSObject

// ----- for 属性
@property(nonatomic,weak)id<ZS_SDKDatasoure> datasource;




// ----- for 方法
-(instancetype)initWithDelegate:(id<ZS_SDKDelegate>)delegate
                       andQueue:(dispatch_queue_t )queue;


/**
 *  传值跳转页面值
 *
 *  @param webUrl 页面跳转访问
 */
-(void)managerConfigWithWebUrl:(NSString *)webUrl;


/**
 *  发送JS指令
 *
 *  @param JSCommand 发送指令
 */
-(void)sendToWebWithJSCommand:(NSString *)JSCommand;



@end
