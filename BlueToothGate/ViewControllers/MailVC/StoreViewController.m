//
//  StoreViewController.m
//  BlueToothGate
//
//  Created by guobao on 16/9/13.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "StoreViewController.h"
#import "SDCycleScrollView.h"
#import "CollectionViewCell.h"
#import "HeadReusableView.h"

#import "GoodsDetailViewController.h"
@interface StoreViewController ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

{
    UICollectionView *collectionView;
    SDCycleScrollView *cycleScrollView2;
    UICollectionReusableView *headerVC;
    
    NSMutableArray *picMuArr;
    NSMutableArray *goodsMuArr;
    
    NSInteger refreshCount;
}

@end

@implementation StoreViewController
NSString *headerIdentifier = @"header";

- (void)viewDidLoad {
    refreshCount = 0;
    goodsMuArr = [NSMutableArray array];
//     kLog(@"%@--%@", self.nameStr,self.imageArr);
    self.StoreNAme.text = self.nameStr;
    [self getStoreInfomation];
    [super viewDidLoad];
   
    
//   [self.view addSubview:self.MyCollectionView];
    [self CreatUIConnent];
    

    
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)CreatUIConnent{
    //创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置最小行间距
    flowLayout.minimumLineSpacing = 10;//设置行间距
    flowLayout.minimumInteritemSpacing = 0;//设置列间距
    flowLayout.itemSize = CGSizeMake((ScreenW - 50) / 2.0, (ScreenW - 50) / 2.0 +50);
    //设置滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置集合视图内间距(上左下右)
    flowLayout.sectionInset = UIEdgeInsetsMake(15, 10, 10, 10);
    flowLayout.headerReferenceSize = CGSizeMake(ScreenW, 200);
    // 设置footer区域的大小
    // flowLayout.footerReferenceSize = CGSizeMake(414, 40);
    
    collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, ScreenH-64) collectionViewLayout:flowLayout];
    //设置属性
    collectionView.backgroundColor = [UIColor whiteColor];
    //是否显示纵向指示标
    collectionView.showsVerticalScrollIndicator = NO;
    //设置是否有反弹效果
//    collectionView.bounces = NO;
    
    //设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    //注册cell
    UINib *cellNib = [UINib nibWithNibName:@"CollectionViewCell" bundle:nil];
    [collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cell"];

    [collectionView registerClass:[HeadReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
     [self.view addSubview:collectionView];
    
    
    collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];

    collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
     [collectionView.mj_header beginRefreshing];
   
}
- (void)loadNewData{
    [self getStoreInfomation];
    
}

- (void)loadMoreData{
    refreshCount++;
     NSLog(@">>>>>  %ld", refreshCount);
    [self getStoreInfomation];
    
    
    
}
- (void)getStoreInfomation{
    
    NSMutableDictionary *StoreMUdic = [NSMutableDictionary dictionary];
    [StoreMUdic setObject:self.StoreID forKey:@"id"];
    [StoreMUdic setObject:@"12" forKey:@"pageSize"];
    [StoreMUdic setObject:[NSString stringWithFormat:@"%ld",(long)refreshCount] forKey:@"page"];
   [[HYHttp sharedHYHttp] POST:GetStopGoodsListUrl parameters:StoreMUdic success:^(id  _Nonnull responseObject) {
//       kLog(@"%@", responseObject);
       if ([responseObject[@"success"] intValue]) {
           NSDictionary *dic = responseObject[@"obj"];
           [goodsMuArr addObjectsFromArray:dic[@"rows"]];
           
       }
       [collectionView.mj_header endRefreshing];
       [collectionView.mj_footer endRefreshing];
       [collectionView reloadData];
   } failure:^(NSError * _Nonnull error) {
       
       
        kLog(@"%@", error);
   }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *collectionID = @"cell";
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
    [cell sizeToFit];
    
    cell.GoodsName.text = goodsMuArr[indexPath.item][@"goods_name"];
    cell.RealyPrice.text = [NSString stringWithFormat:@"￥%@", goodsMuArr[indexPath.item][@"store_price"]];
     cell.StorePrice.text = [NSString stringWithFormat:@"￥%@", goodsMuArr[indexPath.item][@"goods_price"]];
    [cell.GoodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@",API_URL_BASE,goodsMuArr[indexPath.item][@"path"],goodsMuArr[indexPath.item][@"name"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    cell.SoldNum.text = [NSString stringWithFormat:@"￥%@", goodsMuArr[indexPath.item][@"goods_price"]];
    return cell;
}


//设置每个分区返回多少item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return goodsMuArr.count;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
   HeadReusableView *headReVC = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
    headReVC.backgroundColor = [UIColor cyanColor];
    
    NSArray *imagesURLStrings = self.imageArr;
//    NSArray *imagesURLStrings = @[
//                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
//                                   @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"
//                                  ];
    // 情景三：图片配文字
    NSArray *titles = @[
                        ];
    
    // 网络加载 --- 创建带标题的图片轮播器
    cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, 200) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView2.autoScrollTimeInterval = 60000;
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    //    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [headReVC addSubview:cycleScrollView2];
   
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    });

    return headReVC;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *goodDic = goodsMuArr[indexPath.item];
    GoodsDetailViewController *detaillVC = [[GoodsDetailViewController alloc] init];
    
    detaillVC.nameStr = goodDic[@"goods_name"];
    detaillVC.readyStr = [NSString stringWithFormat:@"￥%@",[goodDic[@"store_price"] stringValue]];
    detaillVC.StoreStr = [NSString stringWithFormat:@"￥%@",[goodDic[@"goods_price"] stringValue]];
    detaillVC.goodsId = goodsMuArr[indexPath.item][@"id"];
    detaillVC.StoreID = [NSString stringWithFormat:@"￥%@",[goodDic[@"goods_store_id"] stringValue]];
    
    
    [self.navigationController pushViewController:detaillVC animated:YES];
}

@end
