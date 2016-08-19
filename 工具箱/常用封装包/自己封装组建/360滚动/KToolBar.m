//
//  KToolBar.m
//  IT12 toolBar
//
//  Created by skd on 16/5/25.
//  Copyright © 2016年 lzm. All rights reserved.
//

#import "KToolBar.h"


@interface KToolBar()
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,weak) UIButton * lastBtn;
@property (nonatomic,strong) CALayer * line;

@end

@implementation KToolBar


- (instancetype)initWithframe:(CGRect)frame titles:(NSArray *)titles andActionBlock:(BtnActionBlock)block
{
    if ([self initWithFrame:frame] ) {
        self.titles = titles;
        self.actionBlock = block;
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.showsHorizontalScrollIndicator = _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
        [self addSubview:_scrollView];
        _line = [[CALayer alloc]init];
        _line.backgroundColor = [UIColor redColor].CGColor;
        _line.frame = CGRectMake(0, 0, 60, 1);
        [_scrollView.layer addSublayer:_line];
      
    }
    return self;
}



- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    CGFloat W = 60;
    CGFloat H = self.frame.size.height;
    for (int i = 0; i<titles.count; i++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(i*W, 0, W, H)];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 10+i;
        [_scrollView addSubview:btn];
        if (i == 0) {
            _lastBtn = btn;
            [self btnAction:btn];
        }
    }
    _scrollView.contentSize = CGSizeMake(titles.count * W, 0);
    
}


- (void)btnAction:(UIButton *)btn
{
    // 旧的
    _lastBtn.selected = NO;
    _lastBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    // 新的
    _lastBtn = btn;
    _lastBtn.selected = YES;
    _lastBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    
    /**
     *  调用代理方法
     */
//    if ([self.delegate respondsToSelector:@selector(kToolBarBtnCLickIndex:)]) {
//        [self.delegate kToolBarBtnCLickIndex:btn.tag-10];
//    }

    /**
     *  调用block
     */
    if (self.actionBlock) {
        self.actionBlock(btn.tag - 10);
    }
    
    // 移动line
    _line.position = CGPointMake(btn.center.x
                                 , btn.frame.size.height-2);
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
