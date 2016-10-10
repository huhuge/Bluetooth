//
//  GoodsDetailViewController.m
//  BlueToothGate
//
//  Created by guobao on 16/9/12.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "SDCycleScrollView.h"
#import "StoreViewController.h"
#import "HHShoppingCarVC.h"
@interface GoodsDetailViewController ()<SDCycleScrollViewDelegate>
{
    UIWebView *DetailWebView;
    NSMutableArray *PicMuarr;
    NSString *StoreNameStr;
    NSString *URLStr;
}
@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    self.StoreID = @"1";
    PicMuarr = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    self.countTF.layer.borderColor = kRGBColor(225, 225, 255).CGColor;
    [super viewDidLoad];
    [self CreatUI];
    [self getGoodsDetail];
    [self getStorePic];
    [self getGoodsDetailInfo];
    // Do any additional setup after loading the view from its nib.
}

- (void)getGoodsDetailInfo{
    NSMutableDictionary *StoreMUdic = [NSMutableDictionary dictionary];
    [StoreMUdic setObject:self.goodsId forKey:@"id"];
    [[HYHttp sharedHYHttp] POST:GetGoodDetailInfoListUrl parameters:StoreMUdic success:^(id  _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([responseObject[@"success"] integerValue]) {
            NSDictionary *dic = responseObject[@"obj"];
            @try {
           
                    URLStr = dic[@"goods_details"];

            } @catch (NSException *exception) {
                    URLStr = @"http://www.baidu.com";
            }
           
            
                    }
        
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@", error);
        
        
    }];
}

- (void)getStorePic{
    NSMutableDictionary *StoreMUdic = [NSMutableDictionary dictionary];
    [StoreMUdic setObject:self.StoreID forKey:@"id"];
    [[HYHttp sharedHYHttp] POST:GetADsUrl parameters:StoreMUdic success:^(id  _Nonnull responseObject) {
//        kLog(@"%@", responseObject);
        if ([responseObject[@"success"] intValue]) {
            NSDictionary *dic = responseObject[@"obj"];
            NSArray *picArr = dic[@"slides"];
            for (NSDictionary *Dic in picArr) {
                NSString *picStr = [NSString stringWithFormat:@"%@%@/%@",API_URL_BASE,Dic[@"path"],Dic[@"name"]];
                [PicMuarr addObject:picStr];
                StoreNameStr = Dic[@"store_name"];
            }
        }
        
        
    } failure:^(NSError * _Nonnull error) {
        
        
        kLog(@"%@", error);
    }];
    
}

- (void)CreatUI{
    
    self.nameLabel.text = self.nameStr;
    self.RealyPriceLabel.text = self.readyStr;
    self.StorePriceLabel.text = self.StoreStr;
    
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    // 情景三：图片配文字
    NSArray *titles = @[@"新建交流QQ群：173041393 ",
                        @"感谢您的支持",
                        @"如果在使用过程中出现问题",
                        @"您可以发邮件到jero@126.com"
                        ];
    
    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, ScreenW, 200) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView2.autoScrollTimeInterval = 60000;
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [self.view addSubview:cycleScrollView2];
    
    // --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    });
    

//    UILabel *currentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 264, ScreenW-20, 80)];
//    currentLabel.text = @"$88";
//    currentLabel.font = [UIFont systemFontOfSize:20];
//    [self.view addSubview:currentLabel];
//    currentLabel.textAlignment = NSTextAlignmentCenter;
//    currentLabel.textColor = [UIColor redColor];
    
    
   
     }

- (void)getGoodsDetail{
    NSMutableDictionary *mudic = [NSMutableDictionary new];
    [mudic setObject:self.goodsId forKey:@"id"];
    [[HYHttp sharedHYHttp] POST:GetGoodBaseInfoListUrl parameters:mudic success:^(id  _Nonnull responseObject) {
//        NSLog(@"333%@", responseObject);
        if ([responseObject[@"success"] intValue]) {
            NSDictionary *objDic = responseObject[@"obj"];
            NSDictionary *objBaseDic = objDic[@"objBase"];
            NSDictionary *objMainPhotoDic = objDic[@"objMainPhoto"];
            NSDictionary *objPhotosDic = responseObject[@"objPhotos"];
            
        }
    } failure:^(NSError * _Nonnull error) {
         NSLog(@"44%@", error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GoodsDetailBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)SelectBtn:(UISegmentedControl *)sender {
      UISegmentedControl* control = (UISegmentedControl*)sender;
//    NSLog(@"123%@", URLStr);
    if (control.selectedSegmentIndex) {
        DetailWebView = [[UIWebView alloc] init];
        DetailWebView.frame = CGRectMake(0, 64, ScreenW, ScreenH-114);
        
//        NSURL *url = [NSURL URLWithString:@"http:www.baidu.com"];
        NSURLRequest *requeset = [NSURLRequest requestWithURL:[NSURL URLWithString:URLStr]];
        [DetailWebView loadRequest:requeset];
        [self.view addSubview:DetailWebView];
    }else{
        [DetailWebView removeFromSuperview];
        [self viewDidLoad];
    }
}

#pragma mark ---数量减
- (IBAction)decreaseCount:(UIButton *)sender {
    int count = self.countTF.text.intValue;
    if (count <= 1) {
        return;
    }else{
        self.countTF.layer.borderColor = [UIColor redColor].CGColor;
        count--;
        self.countTF.text = [NSString stringWithFormat:@"%d",count];
    }
    
}

#pragma mark ---数量加
- (IBAction)increaseCount:(UIButton *)sender {
    int count = self.countTF.text.intValue;
    count++;
    self.countTF.text = [NSString stringWithFormat:@"%d",count];
    
    
}



- (IBAction)enterStore:(UIButton *)sender {
    StoreViewController *storeVC =  [[StoreViewController alloc] init];
    storeVC.StoreID = self.StoreID;
    storeVC.imageArr = PicMuarr;
    storeVC.nameStr = StoreNameStr;
    [self.navigationController pushViewController:storeVC animated:YES];
}

- (IBAction)goShoppingCarBtn:(id)sender {
    HHShoppingCarVC *shoppingCarVC = [[HHShoppingCarVC alloc ] init];
    [self.navigationController pushViewController:shoppingCarVC animated:YES];
}


- (IBAction)JoinShoppingCart:(UIButton *)sender {
    
}

- (IBAction)immediatelyBuyBtn:(UIButton *)sender {
        
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
