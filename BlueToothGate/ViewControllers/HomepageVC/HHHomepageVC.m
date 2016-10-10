//
//  HHHomepageVC.m
//  BlueToothGate∨∨∨vvvvVVVVV
//
//  Created by JeroMac on 16/8/16.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHHomepageVC.h"
#import "SDCycleScrollView.h"
#import "HHHomepageCell.h"
#import "CollectHeaderView.h"
#import "HHNoticeVC.h"
#import "HHWillRepairVC.h"
#import "HHSelectCommunityVC.h"
#import "HHLoginVC.h"
#import "HHPhoneBookVC.h"
#import "HHPayQueryVC.h"
#import "HHSecondHandVC.h"
#import <sys/utsname.h>
#import "HHSelectCommunityModel.h"
#import "HHHelpPayListNewVC.h"
#import "HHShoppingCarVC.h"
#import "HHHomepageModel.h"
#import "HHLeaveMessageVC.h"
#import "HHRemoteVC.h"
#import "JPUSHService.h"


static NSInteger loadCount;
struct utsname systemInfo;

@interface HHHomepageVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate,HHSelectCommunityDelegate>{
    CollectHeaderView *collHeaderView;
    SDCycleScrollView *_topScroll;
    NSMutableArray *_imageArray;
    NSMutableArray *_communityArray;
    NSMutableArray *_goodsArray;
    
}

@end

@implementation HHHomepageVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    uname(&systemInfo);
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:HHUser_info_areaID]) {
        kLog(@"存在areaID")
    }else{
        kLog(@"不存在areaID");
    }

    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:HHUser_LoginStatus]) {
        [self getCommunity];
        return;
    }else{
        HHLoginVC *nextVC = [HHLoginVC new];
        nextVC.isHideBackBtn = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    
  }

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    
    [self getADImagesRequest];//获取广告图
    
    [self setLayout];
    
    [self setNib];
    
//    [self setUI];
    
    [self getCommunity];
}

#pragma mark ---轮播图---======================================
- (void)getADImagesRequest{
    
    NSDictionary *dic = [NSDictionary new];
    [[HYHttp sharedHYHttp]GET:HomeAdImageUrl parameters:dic success:^(id  _Nonnull responseObject) {
        kLog(@"response = %@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1){
            NSDictionary *obj = [responseObject objectForKey:@"obj"];
            NSArray *rows = [obj objectForKey:@"rows"];
            for (NSDictionary *dic in rows) {
                NSString *imageStr = [NSString stringWithFormat:@"%@/%@/%@",API_URL_BASE,dic[@"path"],dic[@"name"]];
                [_imageArray addObject:imageStr];
            }
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
#pragma mark ---获取推荐商品---======================================
- (void)getGoodsRecommendWithId:(NSString *)residentialInfoId{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    NSString *resID = [NSString stringWithFormat:@"%@",residentialInfoId];
    [dic setObject:@"36" forKey:@"residentialInfo_id"];
    [[HYHttp sharedHYHttp]POST:HomeGoodsRecommendUrl parameters:dic success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            [_goodsArray removeAllObjects];
            NSDictionary *obj = [responseObject objectForKey:@"obj"];
            NSArray *rows = [obj objectForKey:@"rows"];
            for (NSDictionary * dic in rows) {
                HHHomepageModel *model = [HHHomepageModel new];
                [model setValuesForKeysWithDictionary:dic];
                [_goodsArray addObject:model];
            }
            [_collectionView reloadData];
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];

}
#pragma mark ---获取小区---======================================
- (void)getCommunity{
    
    if (![[NSUserDefaults standardUserDefaults]boolForKey:HHUser_LoginStatus]) {
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[[NSUserDefaults standardUserDefaults] objectForKey:HHUser_info_userID] forKey:@"userId"];
    [[HYHttp sharedHYHttp]POST:GetUserHouseInfoUrl parameters:param success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            [_communityArray removeAllObjects];

            NSDictionary *obj     = [responseObject objectForKey:@"obj"];
            NSArray *rows         = [obj objectForKey:@"rows"];
            if (!rows.count) {
                return ;
            }
            NSDictionary *dic_one = rows[0];

            NSUserDefaults *ud    = [NSUserDefaults standardUserDefaults];
    
            if (![ud dictionaryForKey:HHUser_info_selectedCommunity_dic]) {
                [ud setObject:dic_one forKey:HHUser_info_selectedCommunity_dic];
                [_btnTitle setTitle:[dic_one objectForKey:@"residentialName"]forState:UIControlStateNormal];
                [self getGoodsRecommendWithId:[dic_one objectForKey:@"residentialInfoId"]];
            }else{
                NSDictionary *dic = [ud dictionaryForKey:HHUser_info_selectedCommunity_dic];
                [_btnTitle setTitle:[dic objectForKey:@"residentialName"]forState:UIControlStateNormal];
                [self getGoodsRecommendWithId:[dic objectForKey:@"residentialInfoId"]];

            }
            
            for (NSDictionary *dic in rows) {
                HHSelectCommunityModel *model = [HHSelectCommunityModel new];
                [model setValuesForKeysWithDictionary:dic];
                [_communityArray addObject:model];
            }
            
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


#pragma mark ---setLayout---======================================
- (void)setLayout{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(150, 159)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //    flowLayout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 0);
    [self.collectionView setCollectionViewLayout:flowLayout];
}

#pragma mark ---setNib---======================================
- (void)setNib{
    UINib *cellNib = [UINib nibWithNibName:@"HHHomepageCell" bundle:nil];
    
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"simpleCell"];
    
    //注册headerView Nib的view需要继承UICollectionReusableView
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    
    self.collectionView.delegate   = self;
    self.collectionView.dataSource = self;
    
}

#pragma mark ---setData---======================================
- (void)setData{
    _imageArray     = [[NSMutableArray alloc]init];
    _communityArray = [NSMutableArray new];
    _goodsArray     = [NSMutableArray new];
}

#pragma mark ---setUI---======================================
- (void)setUI{
    if (loadCount > 0) {
        return;
    }
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    UIScrollView *demoContainerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 150)];
    demoContainerView.contentSize = CGSizeMake(ScreenW, 150);
    demoContainerView.backgroundColor = [UIColor redColor];
    [collHeaderView.scrollBackView addSubview:demoContainerView];
    
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, 150) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//        cycleScrollView2.titlesGroup = @[@"热烈换一个",@"顶顶顶顶",@"水水水水"];
    cycleScrollView2.currentPageDotColor = HHThemeColor; // 自定义分页控件小圆标颜色
    //    cycleScrollView2.autoScrollTimeInterval = 0.2;
    [demoContainerView addSubview:cycleScrollView2];
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = _imageArray;
        loadCount = 1;
    });
    
    [collHeaderView.btnNotice addTarget:self action:@selector(turnToFunction:) forControlEvents:UIControlEventTouchUpInside];
    [collHeaderView.btnMail addTarget:self action:@selector(turnToFunction:) forControlEvents:UIControlEventTouchUpInside];
    [collHeaderView.btnRemote addTarget:self action:@selector(turnToFunction:) forControlEvents:UIControlEventTouchUpInside];
    [collHeaderView.btnHelpPay addTarget:self action:@selector(turnToFunction:) forControlEvents:UIControlEventTouchUpInside];
    [collHeaderView.btnPhoneNumbers addTarget:self action:@selector(turnToFunction:) forControlEvents:UIControlEventTouchUpInside];
    [collHeaderView.btnRepair addTarget:self action:@selector(turnToFunction:) forControlEvents:UIControlEventTouchUpInside];
    [collHeaderView.btnSecondHand addTarget:self action:@selector(turnToFunction:) forControlEvents:UIControlEventTouchUpInside];
    [collHeaderView.btnLeaveMessage addTarget:self action:@selector(turnToFunction:) forControlEvents:UIControlEventTouchUpInside];
    
    collHeaderView.labTitle.text = @"123456";
    
}


#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    //    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}


#pragma mark ---collection delegate---=====================================
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _goodsArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"simpleCell";
    HHHomepageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    HHHomepageModel *model = _goodsArray[indexPath.row];
    [cell setCellDataWithModel:model];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        collHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        
        //6(s)p特殊处理
        NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
        if ([platform isEqualToString:@"iPhone8,2"]||[platform isEqualToString:@"iPhone7,1"]){//6(s)p真机
            collHeaderView.FunctionViewHeight.constant = 250;
        }
        if ([platform isEqualToString:@"x86_64"]){//模拟器
            kLog(@"6sp");
//            collHeaderView.FunctionViewHeight.constant = 250;
        }

        [self setUI];
        reusableview = collHeaderView;
    }
    
    if (kind == UICollectionElementKindSectionFooter){
        CollectHeaderView *footerview =   [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        reusableview = footerview;
    }
    return reusableview;
}

//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGFloat H;
    H = 418;
    CGSize size={ScreenW,H};
    return size;
}

//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, (ScreenW-300)/3, 0, (ScreenW-300)/3);//分别为上、左、下、右
    //    return UIEdgeInsetsMake((ScreenW-300)/3, (ScreenW-300)/3, 0,0);//分别为
}

//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    kLog(@"%ld",(long)indexPath.row);
}

#pragma mark ---function---======================================
- (void)turnToFunction:(UIButton *)sender{
    kLog(@"%ld",(long)sender.tag);
    switch (sender.tag) {
        case 0://社区公告
        {
            HHNoticeVC *nextVC = [[HHNoticeVC alloc]init];
            [self.navigationController pushViewController:nextVC animated:YES];
            //            [self presentViewController:nextVC animated:YES completion:nil];
        }
            break;
        case 1://商城
        {
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
            NSString *index = @"3";
            [nc postNotificationName:EnterMailNotification object:index userInfo:nil];

            self.tabBarController.selectedIndex = 3;
        }
            break;
        case 2://促销
        {
            HHRemoteVC *nextVC = [HHRemoteVC new];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
            break;
        case 3://代缴费用
        {
//            HHPayQueryVC *nextVC = [[HHPayQueryVC alloc]init];
            HHHelpPayListNewVC *nextVC = [HHHelpPayListNewVC new];
            [self.navigationController pushViewController:nextVC animated:YES];

        }
            break;
        case 4://电话簿
        {
            HHPhoneBookVC *nextVC = [[HHPhoneBookVC alloc]init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
            break;
        case 5://我要报修
        {
            HHWillRepairVC *nextVC = [[HHWillRepairVC alloc]init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
            break;
        case 6://二手闲置
        {
            HHSecondHandVC *nextVC = [[HHSecondHandVC alloc]init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
            break;
        case 7://物业留言
        {
            HHLeaveMessageVC *nextVC = [HHLeaveMessageVC new];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark ---选择小区---=====================================
- (IBAction)selectCommunity:(UIButton *)sender {
    HHSelectCommunityVC *nextVC = [HHSelectCommunityVC new];
    nextVC.currentCommunity     = _btnTitle.titleLabel.text;
    nextVC.delegate             = self;
    [self.navigationController pushViewController:nextVC animated:YES];
}

#pragma mark ---HHSelectCommunityDelegate---=====================================
- (void)getCurrentCommunityString:(NSString *)string{
    kLog(@"%@",string);
    [_btnTitle setTitle:string forState:UIControlStateNormal];
}

#pragma mark ---跳转消息---=====================================
- (IBAction)turnToMessage:(UIButton *)sender {
    kLog(@"message");
    HHLoginVC *nextVC = [HHLoginVC new];
    [self.navigationController pushViewController:nextVC animated:YES];
}




@end
