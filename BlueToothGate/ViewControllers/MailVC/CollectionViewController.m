//
//  CollectionViewController.m
//  BlueToothGate
//
//  Created by guobao on 16/9/12.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "GoodsDetailViewController.h"
#import "MJRefresh.h"
@interface CollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *myCollectionView;
    NSArray *typeArr;
    NSMutableArray *muTypeArr;
}

@property (nonatomic, assign) int RefreshTimes;

@end

@implementation CollectionViewController

static NSString * const ID = @"Cell";

-(instancetype)init{
    // 流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置cell的尺寸
    CGFloat screecW = [UIScreen mainScreen].bounds.size.width;
    //    layout.itemSize = CGSizeMake(50, 50);
    
    //每个cell的间距
    CGFloat minimum = 20;
    //一行cell 的个数
    CGFloat count = 2;
    //每一行的上下距离
    CGFloat minimum2 = 20;
    //每个cell的宽
    CGFloat cellW = (screecW  - minimum *count - minimum)/count ;
    //每个cell的高
    CGFloat cellH = cellW;
    layout.itemSize = CGSizeMake(cellW, cellH+50);
    
    // 设置每一行的间距
    layout.minimumLineSpacing = minimum2;
    
    // 设置每个cell的间距
    layout.minimumInteritemSpacing = minimum;
    
    // 设置每组的内边距
    layout.sectionInset = UIEdgeInsetsMake(20, minimum, 0, minimum);
    //    UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    // 设置滚动方向
    //    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [self initWithCollectionViewLayout:layout];
    
}
- (void)viewDidLoad {
    
    typeArr = [NSArray array];
    muTypeArr = [NSMutableArray array];
    [super viewDidLoad];
    [self getStoreInfo];

    // self.clearsSelectionOnViewWillAppear = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.frame = CGRectMake(0, 5,ScreenW, ScreenH-50);
    
    // 注册cell
    UINib *cellNib = [UINib nibWithNibName:@"CollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"CCell"];
//    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    _RefreshTimes = 0;
//    [self setUpRefresh];
    
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewGoodsData)];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreGoodsData)];
    
    [self.collectionView.mj_header beginRefreshing];
}


- (void)loadNewGoodsData{
    NSLog(@"8980");
    [self.collectionView.mj_header endRefreshing];
    
}
- (void)loadMoreGoodsData{
    NSLog(@"8980");
    [self.collectionView.mj_footer endRefreshing];
    
}


- (void)setUpRefresh{
    //1.添加刷新控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    

    [refreshControl addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];

    [myCollectionView addSubview:refreshControl];

    [refreshControl beginRefreshing];

    [self refreshStateChange:refreshControl];
    
}

//执行下拉刷新
- (void)refreshStateChange:(UIRefreshControl *)control{

    
        _RefreshTimes = _RefreshTimes + 1;
       [self getStoreInfo];
       [control endRefreshing];
    
    [myCollectionView reloadData];
    
}





-(void)getStoreInfo{
    NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
    [mudic setObject:self.typeId forKey:@"gcId"];
    [mudic setObject:@"12" forKey:@"pageSize"];
    NSString *pageStr = [NSString stringWithFormat:@"%d", _RefreshTimes];
    [mudic setObject:pageStr forKey:@"page"];
     NSLog(@"2343%@", self.typeId);
//    NSString *str = [NSString stringWithFormat:@"app/shopping_goods_class.htm"];
    [[HYHttp sharedHYHttp] GET:MarketGoodsUnderClassUrl parameters:mudic success:^(id  _Nonnull responseObject) {
//        NSLog(@"23%@", responseObject);
        if ([responseObject[@"success"] intValue]) {
            NSDictionary *dic = responseObject[@"obj"];
            typeArr = dic[@"rows"];
            if (typeArr.count) {
                
            }else{
                return ;
            }
        }
        
        [myCollectionView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
        NSLog(@"2343%@", error);
    }];
}


#pragma mark <UICollectionViewDataSource>
// 返回有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
//    int num = [_countStr intValue];
    return typeArr.count;
//    return 11;
}

// 返回每个cell长什么样子
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *collectionID = @"CCell";
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
   
    NSDictionary *goodDic = typeArr[indexPath.item];
//    NSLog(@"78888%@", goodDic);
    NSString *imageStr = [NSString stringWithFormat:@"%@%@/%@",API_URL_BASE,goodDic[@"path"],goodDic[@"path"]];
    [cell.GoodsImage sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    [cell.GoodsImage setImage:[UIImage imageNamed:@"X-open02"]] ;
    cell.GoodsName.text = goodDic[@"goods_name"];
    cell.RealyPrice.text = [NSString stringWithFormat:@"￥%@",[goodDic[@"store_price"] stringValue]];
    cell.StorePrice.text = [NSString stringWithFormat:@"￥%@",[goodDic[@"goods_price"] stringValue]];
    cell.SoldNum.text = [NSString stringWithFormat:@"￥%@",[goodDic[@"goods_salenum"] stringValue]];
    
//    static NSString *collectionID = @"CCell";
//    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor redColor];
//    UIImageView *imageVC = [[UIImageView alloc] init];
//    imageVC.frame = CGRectMake(10, 0, cell.frame.size.width-20, cell.frame.size.width-20);
//    imageVC.layer.cornerRadius = (cell.frame.size.width-20)/2;
//    imageVC.backgroundColor = Color(81, 161, 217);
//    [cell addSubview:imageVC];
//    _lab = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-20, cell.frame.size.width, 20)];
//    _lab.textColor = [UIColor grayColor];
//    _lab.textAlignment = NSTextAlignmentCenter;
//    [cell addSubview:_lab];
    
    
    [myCollectionView reloadData];
    
//    [imageVC sd_setImageWithURL:_muArrImage[indexPath.item]];
//    _lab.text = _muArrName[indexPath.item];
    
    //    NSLog(@"567%@", _muArrImage);
    //    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *goodDic = typeArr[indexPath.item];
    GoodsDetailViewController *detaillVC = [[GoodsDetailViewController alloc] init];
    
    detaillVC.nameStr = goodDic[@"goods_name"];
    detaillVC.readyStr = [NSString stringWithFormat:@"￥%@",[goodDic[@"store_price"] stringValue]];
    detaillVC.StoreStr = [NSString stringWithFormat:@"￥%@",[goodDic[@"goods_price"] stringValue]];
    detaillVC.goodsId = typeArr[indexPath.item][@"id"];
    detaillVC.StoreID = [NSString stringWithFormat:@"￥%@",[goodDic[@"goods_store_id"] stringValue]];
    [self.navigationController pushViewController:detaillVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/








#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
