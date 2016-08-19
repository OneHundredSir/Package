 //
//  KToolBar.h
//  IT12 toolBar
//
//  Created by skd on 16/5/25.
//  Copyright © 2016年 lzm. All rights reserved.
//

#import <UIKit/UIKit.h>
// 声明了block
typedef void(^BtnActionBlock)(NSInteger index);



@protocol KToolBarDelegate <NSObject>

- (void)kToolBarBtnCLickIndex:(NSInteger)index;

@end

@interface KToolBar : UIView
@property (nonatomic,strong) NSArray * titles;
@property (nonatomic,weak) id<KToolBarDelegate>  delegate;
@property (nonatomic,copy) BtnActionBlock actionBlock;





- (instancetype)initWithframe:(CGRect)frame titles:(NSArray *)titles andActionBlock:(BtnActionBlock)block;

@end
