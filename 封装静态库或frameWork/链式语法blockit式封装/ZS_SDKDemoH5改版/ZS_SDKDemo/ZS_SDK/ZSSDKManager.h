//
//  ZSSDKManager.h
//  ZS_SDKDemo
//
//  Created by HUN on 16/8/24.
//  Copyright © 2016年 com.zeustel.zssdk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZSSDKProtocol.h"
@interface ZSSDKManager : NSObject
#pragma mark == 管理单例对象 ==
extern ZSSDKManager *shareZSSDKManager();

#pragma mark == 设置委托对象 ==
/**
 *  设置委托 返回BOOL判断是否设置成功
 设置成功后才可使用中心管理器方法
 需保证委托对象被其他对象强持有且常驻内存
 否则被销毁后无法调用和再次设置委托
 
 委托对象需遵守两个协议： ZS_SDKDelegate，
 委托方法:
 updateStateWithCentralManager:
 */
@property (nonatomic,copy,readonly) ZSSDKManager* ((^setDelegate)(id <ZS_SDKDelegate> delegate));



#pragma mark == 设置数据源对象 ==
/**
 *  设置数据源 返回BOOL判断是否设置成功
 设置成功后才可使用推出去的页面控制器方法
 需保证委托对象被其他对象强持有且常驻内存
 否则被销毁后无法调用和再次设置数据源
 
 委托对象需遵守数据源： ZS_SDKDelegate，
 委托方法:
 updateStateWithCentralManager:
 */
@property (nonatomic,copy,readonly) ZSSDKManager* ((^setDatasource)(id <ZS_SDKDatasoure> datasource));



/**
 *  跳转页面
 */
@property(nonatomic,copy,readonly)ZSSDKManager* ((^sendToWeb)(NSString *urlStr));


@property(nonatomic,copy,readonly)ZSSDKManager* ((^sendJSCommandToWeb)(NSString *urlStr));

@end
