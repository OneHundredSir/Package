//
//  KeyChainStore.h
//  webtest
//
//  Created by HUN on 16/8/4.
//  Copyright © 2016年 hundred Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainStore : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;


@end
