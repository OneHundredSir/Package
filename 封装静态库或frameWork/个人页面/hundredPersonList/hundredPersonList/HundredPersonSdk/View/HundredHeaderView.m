//
//  HundredHeaderView.m
//  hundredPersonList
//
//  Created by HUN on 16/8/25.
//  Copyright © 2016年 com.zeustel.zssdk. All rights reserved.
//

#import "HundredHeaderView.h"
#import "EDColor.h"
@implementation HundredHeaderView



-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self _initIconWithFrame:frame];
}

//颜色选项
-(void)_initIconWithFrame:(CGRect)rect
{
    self.backgroundColor = [UIColor colorWithRed:0.1 green:0.2 blue:0.3 alpha:1 ];
    CGFloat imageWH = rect.size.height*0.5;
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:(CGRect){0,0,imageWH,imageWH}];
    imgV.image = [UIImage imageNamed:@"geren.jpg"];
    imgV.center = self.center;
    imgV.layer.cornerRadius = imageWH/2.0;
    imgV.layer.borderWidth = 4;
    imgV.layer.borderColor = [UIColor iOS7yellowColor].CGColor;
    imgV.clipsToBounds = YES;
    [self addSubview:imgV];
    UIButton *btn = [[UIButton alloc]initWithFrame:imgV.frame];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}


-(void)btnAction:(id)sender
{
    NSLog(@"--->");
}


@end
