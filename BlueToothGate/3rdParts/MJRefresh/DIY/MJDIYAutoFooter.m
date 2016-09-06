//
//  MJDIYAutoFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJDIYAutoFooter.h"

@interface MJDIYAutoFooter()
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UISwitch *s;
@property (weak, nonatomic) UIActivityIndicatorView *loading;
@end

@implementation MJDIYAutoFooter
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 140;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
//    // 打酱油的开关
//    UISwitch *s = [[UISwitch alloc] init];
//    [self addSubview:s];
//    self.s = s;
    
    // loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loading = loading;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.label.frame =CGRectMake(self.bounds.origin.x, self.mj_h * 0.5-50, self.bounds.size.width, 15);
    self.loading.frame=CGRectMake(self.mj_w*0.5-107,self.mj_h * 0.5-50, 15, 15);
    
//    self.s.center = CGPointMake(self.mj_w - 20, self.mj_h - 20);
    
//    self.loading.center = CGPointMake(self.mj_w*0.5-100, self.mj_h * 0.5);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.label.text = @"";
            [self.loading stopAnimating];
            [self.s setOn:NO animated:YES];
            break;
        case MJRefreshStateRefreshing:
            [self.s setOn:YES animated:YES];
            self.label.text = @"加载数据中";
            [self.loading startAnimating];
            break;
        case MJRefreshStateNoMoreData:
            self.label.text = @"暂无更多数据";
            [self.s setOn:NO animated:YES];
            [self.loading stopAnimating];
            break;
        default:
            break;
    }
}

@end