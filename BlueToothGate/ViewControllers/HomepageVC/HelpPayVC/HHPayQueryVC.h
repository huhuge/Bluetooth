//
//  HHPayQueryVC.h
//  BlueToothGate
//
//  Created by JeroMac on 16/8/25.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHPayQueryVC : UIViewController


@property (weak, nonatomic  ) IBOutlet UITextField *TFCommunity;

@property (weak, nonatomic  ) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView      *footerView;


@end
