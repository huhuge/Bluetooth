//
//  HHMailVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/16.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHMailVC.h"
#import "UIView+Extension.h"
#import "CollectionViewController.h"
#import "HHShoppingCarVC.h"
#define RandomColor [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0]


static CGFloat const titleH = 44;/** 文字高度  */

static CGFloat const MaxScale = 1.2;/** 选中文字放大  */
@interface HHMailVC ()<UIWebViewDelegate,UIScrollViewDelegate>{
    
}


@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIScrollView *titleScrollView;

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic ,strong) NSArray * titlesArr;

@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic ,strong) UIButton * selectedBtn;

@property (nonatomic ,strong) UIImageView * imageBackView;

@end

@implementation HHMailVC

#pragma mark lazy loading
- (NSMutableArray *)buttons
{
    if (!_buttons)
    {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}


-(NSArray *)titlesArr
{
    
    if (!_titlesArr) {
        _titlesArr  = [NSArray array];
    }
    
    return _titlesArr;
}

- (void)viewDidLoad {
//    NSLog(@"%@----%@", _titlesArr, self.titleARR);
    [super viewDidLoad];
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@username=%@&password=%@",API_URL_BASE,MarketEnterenceUrl,[ud objectForKey:HHUser_info_Account],[ud objectForKey:HHUser_info_Psaaword]]]]];
    
    
    self.navigationItem.title = @"商城";
    
//    [self getSpeciesOfGoods];
    [self addChildViewController];
    [self setTitleScrollView];
    [self setContentScrollView];
    [self setupTitle];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentScrollView.contentSize = CGSizeMake(self.titleARR.count * ScreenW, 0);
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator  = NO;
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    self.contentScrollView.delegate = self;
    
}

- (IBAction)goShoppingCar:(id)sender {
    HHShoppingCarVC *shoppingCarVC = [[HHShoppingCarVC alloc] init];
    [self.navigationController pushViewController:shoppingCarVC animated:YES];
}



- (void)getSpeciesOfGoods{
    NSString *str = [NSString stringWithFormat:@"app/store_goods_class.htm"];
    [[HYHttp sharedHYHttp] GET:str parameters:nil success:^(id  _Nonnull responseObject) {
//        NSLog(@"23%@", responseObject);
        if ([responseObject[@"success"] intValue]) {
            NSDictionary *objDic = responseObject[@"obj"];
            _titlesArr = objDic[@"rows"];
             NSLog(@"554%lu", (unsigned long)_titlesArr.count);
        
            
            [self addChildViewController];


        }
        
    } failure:^(NSError * _Nonnull error) {
        
         NSLog(@"2343%@", error);
    }];
}

//- (void)webViewDidStartLoad:(UIWebView *)webView{
//    
//}
//-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    
//}
//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    
//}

-(void)addChildViewController{
    _titlesArr = self.titleARR;
//    NSLog(@"%@----%@", _titlesArr, self.titleARR);
    for (int i=0; i<_titlesArr.count; i++) {
        CollectionViewController *CollectionVC = [[CollectionViewController alloc] init];
        NSDictionary *titleDic = _titlesArr[i];
        CollectionVC.title = titleDic[@"className"];
        CollectionVC.typeId = titleDic[@"id"];
        CollectionVC.view.backgroundColor = kRGBColor(225, 225, 225);
        [self addChildViewController:CollectionVC];
    }
    
//    CollectionViewController *CollectionVC1 = [[CollectionViewController alloc] init];
//    NSDictionary *titleDic = _titlesArr[0];
//            CollectionVC1.title = titleDic[@"className"];
////    CollectionVC1.title = @"全部";
//    [self addChildViewController:CollectionVC1];
////    CollectionVC1.view.backgroundColor = [UIColor redColor];
//
//    CollectionViewController *CollectionVC2= [[CollectionViewController alloc] init];
//    CollectionVC2.title = @"促销";
//    [self addChildViewController:CollectionVC2];
//     CollectionVC2.view.backgroundColor = [UIColor cyanColor];
//
//    CollectionViewController *CollectionVC3= [[CollectionViewController alloc] init];
//    CollectionVC3.title = @"日用百货";
//    [self addChildViewController:CollectionVC3];
//     CollectionVC3.view.backgroundColor = [UIColor blueColor];
//
//    CollectionViewController *CollectionVC4= [[CollectionViewController alloc] init];
//    CollectionVC4.title = @"数码";
//    [self addChildViewController:CollectionVC4];

    
    
}
-(void)setTitleScrollView{
    
    CGRect rect  = CGRectMake(0, 64, ScreenW, titleH);
    self.titleScrollView = [[UIScrollView alloc] initWithFrame:rect];
    self.titleScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleScrollView];
    self.lineView.frame = CGRectMake(0, 0, ScreenW/4, 2);
    self.lineView.backgroundColor= HHThemeColor;
    [self.titleScrollView addSubview:self.lineView];
    
}
-(void)setContentScrollView{
    
    CGFloat y  = CGRectGetMaxY(self.titleScrollView.frame);
    CGRect rect  = CGRectMake(0, y, ScreenW, ScreenH - titleH);
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:rect];
    [self.view addSubview:self.contentScrollView];
    
    
}

-(void)setupTitle{
//    NSUInteger count = self.childViewControllers.count;
    NSUInteger count = self.titleARR.count;
    CGFloat x = 0;
    CGFloat w = ScreenW/4;
    CGFloat h = titleH;
    //    self.imageBackView  = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 80-10, titleH-10)];
    //    self.imageBackView.image = [UIImage imageNamed:@"b1"];
    //    self.imageBackView.backgroundColor = [UIColor whiteColor];
    //    self.imageBackView.userInteractionEnabled = YES;
    //    [self.titleScrollView addSubview:self.imageBackView];
    
    for (int i = 0; i < count; i++)
    {
        
        UICollectionViewController *vc = self.childViewControllers[i];
        
        x = i * w;
        CGRect rect = CGRectMake(x, 0, w, h);
        UIButton *btn = [[UIButton alloc] initWithFrame:rect];
        
        btn.tag = i;
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        
        [self.buttons addObject:btn];
        [self.titleScrollView addSubview:btn];
        
        
        if (i == 0)
        {
            [self click:btn];
        }
        
    }
    self.titleScrollView.contentSize = CGSizeMake(count * w, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
}
-(void)click:(UIButton *)sender{
    
    self.lineView.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y+sender.frame.size.height - 2, ScreenW/4, 2);
    
    [self selectTitleBtn:sender];
    NSInteger i = sender.tag;
    self.VCMark = sender.tag;
    CGFloat x  = i *ScreenW;
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    
    [self setUpOneChildController:i];
    
    //    self.lineView.backgroundColor = Color(17, 135, 76);
}

-(void)selectTitleBtn:(UIButton *)btn{
    
    
    [self.selectedBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.selectedBtn.transform = CGAffineTransformIdentity;
    
    //    self.lineView.backgroundColor = Color(17, 135, 76);
    [btn setTitleColor:HHThemeColor forState:UIControlStateNormal];
    btn.transform = CGAffineTransformMakeScale(MaxScale, MaxScale);
    self.selectedBtn = btn;
    
    [self setupTitleCenter:btn];
    
}

-(void)setupTitleCenter:(UIButton *)sender
{
    
    CGFloat offset = sender.center.x - ScreenW * 0.5;
    if (offset < 0) {
        offset = 0;
    }
    CGFloat maxOffset  = self.titleScrollView.contentSize.width - ScreenW;
    if (offset > maxOffset) {
        offset = maxOffset;
    }
    [self.titleScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
    
}

-(void)setUpOneChildController:(NSInteger)index{
    
    
    CGFloat x  = index * ScreenW;
    UICollectionViewController *vc  =  self.childViewControllers[index];
    if (vc.view.superview) {
        return;
    }
    vc.view.frame = CGRectMake(x, 0, ScreenW, ScreenH - self.contentScrollView.frame.origin.y);
    [self.contentScrollView addSubview:vc.view];
    
}


#pragma mark - UIScrollView  delegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger i  = self.contentScrollView.contentOffset.x / ScreenW;
    [self selectTitleBtn:self.buttons[i]];
    [self setUpOneChildController:i];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetX  = scrollView.contentOffset.x;
    NSInteger leftIndex  = offsetX / ScreenW;
    
    self.VCMark = leftIndex;
    
    NSInteger rightIdex  = leftIndex + 1;
    UIButton *leftButton = self.buttons[leftIndex];
    
    self.lineView.frame= CGRectMake((ScreenW/4) *leftIndex, leftButton.frame.origin.y+titleH - 2, ScreenW/4, 2);
    
    UIButton *rightButton  = nil;
    if (rightIdex < self.buttons.count) {
        rightButton  = self.buttons[rightIdex];
    }
    CGFloat scaleR  = offsetX / ScreenW - leftIndex;
    CGFloat scaleL  = 1 - scaleR;
    CGFloat transScale = MaxScale - 1;
    
    self.imageBackView.transform  = CGAffineTransformMakeTranslation((offsetX*(self.titleScrollView.contentSize.width / self.contentScrollView.contentSize.width)), 0);
    
    leftButton.transform = CGAffineTransformMakeScale(scaleL * transScale + 1, scaleL * transScale + 1);
    rightButton.transform = CGAffineTransformMakeScale(scaleR * transScale + 1, scaleR * transScale + 1);
    
    //    UIColor *rightColor = [UIColor colorWithRed:(174+66*scaleR)/255.0 green:(174-71*scaleR)/255.0 blue:(174-174*scaleR)/255.0 alpha:1];
    //    UIColor *leftColor = [UIColor colorWithRed:(174+66*scaleL)/255.0 green:(174-71*scaleL)/255.0 blue:(174-174*scaleL)/255.0 alpha:1];
    
    [leftButton setTitleColor:HHThemeColor forState:UIControlStateNormal];
    //    [rightButton setTitleColor:rightColor forState:UIControlStateNormal];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init ];
    }
    return _lineView;
}

@end
