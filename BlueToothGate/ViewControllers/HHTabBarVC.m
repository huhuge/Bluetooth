//
//  HHTabBarVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/16.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHTabBarVC.h"
#import "HHCircleVC.h"
#import "HHHomepageVC.h"
#import "HHMailVC.h"
#import "HHMyVC.h"
#import "HHOpenGateVC.h"
#import "HHButton.h"
#import <CoreMotion/CoreMotion.h>
#import <AudioToolbox/AudioToolbox.h>
#import "StaticBlueComplete.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface HHTabBarVC (){
    UIView *myView;
    StaticBlueComplete *_blue;
    NSMutableArray *_btnArr;

    NSArray *StoreArr;
}


 ///设置之前选中的按钮
@property (nonatomic, weak) UIButton *selectedBtn;

@end

@implementation HHTabBarVC


- (void)getSpeciesOfGoods{
    NSString *str = [NSString stringWithFormat:@"app/store_goods_class.htm"];
    [[HYHttp sharedHYHttp] GET:str parameters:nil success:^(id  _Nonnull responseObject) {
        NSLog(@"23%@", responseObject);
        if ([responseObject[@"success"] intValue]) {
            NSDictionary *objDic = responseObject[@"obj"];
            StoreArr = objDic[@"rows"];
            NSLog(@"554%lu", (unsigned long)StoreArr.count);
            [self setUpTabViewControllers];
           
            
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        NSLog(@"2343%@", error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getSpeciesOfGoods];
    [self initBlueTooth];

//    [self setUpTabViewControllers];
//    NSLog(@"%s",__func__);
//    NSLog(@"%@",self.view.subviews); //能打印出所有子视图,和其frame
  
    //删除现有的tabBar
    CGRect rect = self.tabBar.frame;
    [self.tabBar removeFromSuperview];  //移除TabBarController自带的下部的条
    _btnArr = [NSMutableArray new];
    //测试添加自己的视图
    myView = [[UIView alloc] init];
    myView.frame = rect;
    myView.backgroundColor = kRGBColor(242, 242, 242);
    [self.view addSubview:myView];
    
    
    NSArray *tabbarImages = @[@"fticon1",@"fticon2",@"",@"fticon3",@"fticon4"];
    NSArray *tabbarSelectImages = @[@"fthover1",@"fthover2",@"",@"fthover3",@"fthover4"];
    NSArray *titleArrs = @[@"首页",@"圈子",@"开门",@"商城",@"我的"];
    for (int i = 0; i < 5; i++) {
        HHButton *btn = [[HHButton alloc] init];
        NSString *imageName = tabbarImages[i];
        NSString *imageNameSel = tabbarSelectImages[i];
        
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imageNameSel] forState:UIControlStateSelected];
        
        CGFloat x = i * myView.frame.size.width / 5;
        btn.frame = CGRectMake(x, 4, myView.frame.size.width / 5, 26);
        
        [myView addSubview:btn];
//        btn.backgroundColor = [UIColor blueColor];
        btn.tag = i;//设置按钮的标记, 方便来索引当前的按钮,并跳转到相应的视图
        //带参数的监听方法记得加"冒号"
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
           if (2 == i) {
               btn.frame = CGRectMake(ScreenW/2-25, -20, 50, 50);
               [btn setImage:[UIImage imageNamed:@"X-img03"] forState:UIControlStateNormal];
               btn.backgroundColor     = HHThemeColor;
               btn.layer.masksToBounds = YES;
               btn.layer.cornerRadius  = 25;
               btn.layer.borderColor   = [UIColor whiteColor].CGColor;
               btn.layer.borderWidth   = 5;
            
        }
        
        UILabel *lab      = [[UILabel alloc]initWithFrame:CGRectMake(x, 31, myView.frame.size.width / 5, 20)];
        lab.text          = titleArrs[i];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font          = [UIFont systemFontOfSize:12];
        lab.textColor     = [UIColor grayColor];
        lab.tag           = i;
        [myView addSubview:lab];
        
        //设置刚进入时,第一个按钮为选中状态
        if (0 == i) {
            btn.selected = YES;
            self.selectedBtn = btn;  //设置该按钮为选中的按钮
            lab.textColor = HHThemeColor;
        }

    }
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(valueChanged:) name:EnterMailNotification object:nil];
    
}

#pragma mark ---通知---======================================
- (void)valueChanged:(NSNotification *)noti{
    kLog(@"%@",noti.object);
    UIButton *btn = [UIButton new];
    btn.tag = 3;
    [self clickBtn:btn];
}


- (void)clickBtn:(UIButton *)button {
    
    if (button.tag == 2) {
        [self openGate];
        return;
    }
    
    //1.先将之前选中的按钮设置为未选中
    self.selectedBtn.selected = NO;
    //2.再将当前按钮设置为选中
    button.selected = YES;
    //3.最后把当前按钮赋值为之前选中的按钮
    self.selectedBtn = button;
    //4.跳转到相应的视图控制器. (通过selectIndex参数来设置选中了那个控制器)
    self.selectedIndex = button.tag;
    
    NSArray *subViews = [myView subviews];
    NSMutableArray *labArr = [NSMutableArray new];
    
    if (button.tag == 3) {
        for (int i=0; i<subViews.count; i++) {
            if ([subViews[i] isKindOfClass:[UIButton class]]) {
                [_btnArr addObject:subViews[i]];
            }
        }
        for (UIButton *btn in _btnArr) {
            if (btn.tag == 3) {
                btn.selected = YES;
                self.selectedBtn = btn;
            }
        }
    }
    
    for (int i = 0; i < subViews.count; i++) {
        if ([subViews[i] isKindOfClass:[UILabel class]]) {
            [labArr addObject:subViews[i]];
        }
    }
    
    for (int i = 0; i < labArr.count; i++) {
        UILabel *lab = labArr[i];
        if (lab.tag == button.tag) {
            lab.textColor = HHThemeColor;
        }else{
            lab.textColor = [UIColor grayColor];
        }
    }
//    kLog(@"subViews= %@",subViews);
}

#pragma mark ---openAction---======================================
- (void)openGate{
    kLog(@"open gate");
//    [_blue begin];

}

#pragma mark ---initBlueTooth---======================================
- (void)initBlueTooth{
//    _blue = [[StaticBlueComplete alloc]init];
//    _blue.cardName = @"A0000000";
//    _blue.searchError = @"未找到设备";
//    _blue.searching = @"正在开门，请稍等";
//    _blue.blueName = @"E00001";
}


#pragma mark ---安装子视图控制器
- (void)setUpTabViewControllers{
    HHHomepageVC *HVC = [[HHHomepageVC alloc]init];
    HVC.title = @"首页";
    UINavigationController *nav0 = [[UINavigationController alloc]initWithRootViewController:HVC];
    nav0.navigationBar.translucent = YES;
    
    
    HHCircleVC *CVC = [[HHCircleVC alloc]init];
    CVC.title = @"圈子";
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:CVC];
    nav1.navigationBar.translucent = YES;
    
    HHOpenGateVC *OVC = [[HHOpenGateVC alloc]init];
    OVC.title = @"开门";
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:OVC];
    nav2.navigationBar.translucent = YES;
    
    HHMailVC *MVC = [[HHMailVC alloc]init];
    MVC.title = @"商城";
    MVC.titleARR = StoreArr;
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:MVC];
    nav3.navigationBar.translucent = YES;
    
    HHMyVC *MyVC = [[HHMyVC alloc]init];
    MyVC.title = @"我的";
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:MyVC];
    nav4.navigationBar.translucent = YES;

    self.viewControllers = @[HVC,CVC,OVC,MVC,MyVC];
    
}

@end
