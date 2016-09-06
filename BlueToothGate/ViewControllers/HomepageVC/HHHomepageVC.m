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


struct utsname systemInfo;

@interface HHHomepageVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate,HHSelectCommunityDelegate>{
    CollectHeaderView *collHeaderView;
    SDCycleScrollView *_topScroll;
    NSMutableArray *_imageArray;
    
}

@end

@implementation HHHomepageVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    uname(&systemInfo);

    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setRequest];
    
    [self setLayout];
    
    [self setNib];
    
    //    [self setUI];
    
}

#pragma mark ---setRequest---======================================
- (void)setRequest{
    NSDictionary *dic = [NSDictionary new];
    [[HYHttp sharedHYHttp]GET:CorpListUrl parameters:dic success:^(id  _Nonnull responseObject) {
        kLog(@"response = %@",responseObject);
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
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
}

#pragma mark ---setData---======================================
- (void)setData{
    _imageArray = [[NSMutableArray alloc]initWithObjects:@"img1.jpg",@"img2.jpg",@"img3.jpg",@"img4.jpg",@"img5.jpg", nil];
    
}

#pragma mark ---setUI---======================================
- (void)setUI{
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    UIScrollView *demoContainerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 120)];
    demoContainerView.contentSize = CGSizeMake(ScreenW, 120);
    demoContainerView.backgroundColor = [UIColor redColor];
    [collHeaderView.scrollBackView addSubview:demoContainerView];
    
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, 120) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    //    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    //    cycleScrollView2.autoScrollTimeInterval = 0.2;
    [demoContainerView addSubview:cycleScrollView2];
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
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
    
    return 10;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"simpleCell";
    HHHomepageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
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
            
        }
            break;
        case 2://促销
        {
            
        }
            break;
        case 3://代缴费用
        {
            HHPayQueryVC *nextVC = [[HHPayQueryVC alloc]init];
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
