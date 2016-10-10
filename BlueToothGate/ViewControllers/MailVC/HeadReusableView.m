//
//  HeadReusableView.m
//  BlueToothGate
//
//  Created by guobao on 16/9/29.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HeadReusableView.h"
#import "SDCycleScrollView.h"
@interface HeadReusableView ()<SDCycleScrollViewDelegate>

@end
@implementation HeadReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor redColor];
//            NSArray *imagesURLStrings = @[
//                                          @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
//                                          @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg"
//                                          ];
//            // 情景三：图片配文字
//            NSArray *titles = @[@"新建交流QQ群：173041393 ",
//                                @"感谢您的支持"
//                                
//                                ];
//            
//            // 网络加载 --- 创建带标题的图片轮播器
//           SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, 200) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
//            cycleScrollView2.autoScrollTimeInterval = 60000;
//            cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//            //    cycleScrollView2.titlesGroup = titles;
//            cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
//            [self addSubview:cycleScrollView2];
//            
//            //         --- 模拟加载延迟
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
//            });
//            
    
            
        }
    
    return self;
}
@end
