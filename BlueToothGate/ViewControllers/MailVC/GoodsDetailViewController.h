//
//  GoodsDetailViewController.h
//  BlueToothGate
//
//  Created by guobao on 16/9/12.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsDetailViewController : UIViewController

@property (nonatomic, strong)NSString *goodsId;
@property (nonatomic, strong) NSString *StoreID;
@property (weak, nonatomic) IBOutlet UIButton *decreaseBtn;
@property (weak, nonatomic) IBOutlet UIButton *increraseBtn;
@property (weak, nonatomic) IBOutlet UITextField *countTF;
@property (weak, nonatomic) IBOutlet UILabel *RealyPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *StorePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@property (nonatomic, strong)NSString *nameStr;
@property (nonatomic, strong)NSString *readyStr;
@property (nonatomic, strong)NSString *StoreStr;

@end
