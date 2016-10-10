//
//  HHShopCartCell.h
//  BlueToothGate
//
//  Created by JeroMac on 16/9/12.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHShopCartModel.h"

@interface HHShopCartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnSelect;
@property (weak, nonatomic) IBOutlet UIButton *btnIncrease;
@property (weak, nonatomic) IBOutlet UIButton *btnDecrease;
@property (weak, nonatomic) IBOutlet UIView *funcView;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labOldPrice;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UITextField *TFCount;

- (void)setCellDataWithModel:(HHShopCartModel *)model andSelect:(BOOL)isSelected;

@end
