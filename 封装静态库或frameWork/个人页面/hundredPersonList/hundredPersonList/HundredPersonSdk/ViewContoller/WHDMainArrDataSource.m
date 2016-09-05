//
//  WHDMainArrDataSource.m
//  hundredPersonList
//
//  Created by HUN on 16/8/25.
//  Copyright © 2016年 com.zeustel.zssdk. All rights reserved.
//

#import "WHDMainArrDataSource.h"

@interface WHDMainArrDataSource()

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, copy) NSString *cellIdentifier;

@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;

@end


@implementation WHDMainArrDataSource


//这里为什么要重写这个?
- (id)init
{
    return nil;
}

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
{
    self = [super init];
    if (self) {
        self.items = anItems;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = [aConfigureCellBlock copy];
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[(NSUInteger) indexPath.row];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];

    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    return cell;
}
@end
