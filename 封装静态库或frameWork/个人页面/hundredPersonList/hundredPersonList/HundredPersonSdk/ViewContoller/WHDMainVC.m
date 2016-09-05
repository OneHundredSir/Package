//
//  WHDMainVC.m
//  hundredPersonList
//
//  Created by HUN on 16/8/25.
//  Copyright © 2016年 com.zeustel.zssdk. All rights reserved.
//

#import "WHDMainVC.h"
#import "Header.h"
@interface WHDMainVC ()<UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)WHDMainArrDataSource *mydatasource;
@end

@implementation WHDMainVC
NS_ENUM(NSInteger,BtnStyle){
    JIANJIE=0,
    BLOG,
    WEIBO,
    GONGZHONGHAO,
    ANIMATION,
    CAMARA,
    PICTURE,
    MAP,
    YAOYIYAO
};
-(void)viewDidLoad
{
    self.title = @"作者介绍";
    [self _initTable];
}

//@[@"show",@"show1",@"show2",@"show3"]图片名称
-(void)_initTable
{
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    _tableView.delegate = self;
    WHDMainArrDataSource *datasource = [[WHDMainArrDataSource alloc]
                                        initWithItems:@[@"作者简介",
                                                        @"个人简书/博客",
                                                        @"作者微博",
                                                        @"作者技术公众号",
                                                        @"转场动画",
                                                        @"打开相机/相册",
                                                        @"打开地图",
                                                        @"摇一摇"]
                                        cellIdentifier:@"Cell"
                                        configureCellBlock:^(MainCell *cell, id item) {
                                            cell.showLB.text = item;
                                        }];
    self.mydatasource = datasource;
    
    _tableView.tableHeaderView =[ [HundredHeaderView alloc]initWithFrame:(CGRect){0,0,CGRectGetWidth(self.view.frame),200}];
    _tableView.dataSource = datasource;
    _tableView.bounces = NO;
    [_tableView registerNib:[UINib nibWithNibName:@"MainCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    [self.view addSubview:_tableView];
}




#pragma mark delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case JIANJIE:
            [self jianjie];
            break;
        case BLOG:
            [self webLinkWith:JIANSHUURL];
            break;
        case WEIBO:
            [self webLinkWith:WEIBOURL];
            break;
        case GONGZHONGHAO:
            [self gongzhonghao];
            break;
        case ANIMATION:
            [self animation];
            break;
        case CAMARA:
            [self camane];
            break;
        case MAP:
            break;
        case YAOYIYAO:
            [self yaoyiyao];
            break;
        default:
            break;
    }
}


-(void)camane
{
    CAViewController *yaoVC = [CAViewController new];
    [self.navigationController pushViewController:yaoVC animated:YES];
}
#pragma mark 转场动画
-(void)animation
{
    AnViewController *yaoVC = [AnViewController new];
    [self.navigationController pushViewController:yaoVC animated:YES];
}

#pragma mark 摇一摇
-(void)yaoyiyao
{
    YaoYiYaoVC *yaoVC = [YaoYiYaoVC new];
    [self.navigationController pushViewController:yaoVC animated:YES];
}

#pragma mark 公众号
-(void)gongzhonghao
{
    Gongzhonghao *vc = [Gongzhonghao new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 个人简介
-(void)jianjie
{
    UIViewController *vc = [UIViewController new];
    UIView *xlvV =[[NSBundle mainBundle] loadNibNamed:@"SelfIntroduce" owner:nil options:nil][0];\
    xlvV.frame = (CGRect){0,64,CGRectGetWidth(vc.view.frame),CGRectGetHeight(vc.view.frame)};
    [vc.view addSubview:xlvV];

    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 页面跳转
-(void)webLinkWith:(NSString *)webUrl
{
    HunWebVC *vc = [HunWebVC new];
    vc.webUrl = webUrl;
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}



@end
