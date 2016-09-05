//
//  WHDMainArrDataSource.h
//  hundredPersonList
//
//  Created by HUN on 16/8/25.
//  Copyright © 2016年 com.zeustel.zssdk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MainCell.h"
typedef void (^TableViewCellConfigureBlock)(MainCell *cell, id item);
@interface WHDMainArrDataSource : NSObject<UITableViewDataSource>

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
