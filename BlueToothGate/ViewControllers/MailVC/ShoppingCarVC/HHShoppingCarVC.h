//
//  HHShoppingCarVC.h
//  BlueToothGate
//
//  Created by JeroMac on 16/9/12.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHShoppingCarVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *btnSelectAll;
@property (weak, nonatomic) IBOutlet UILabel *labTotal;
@property (weak, nonatomic) IBOutlet UIButton *btnPay;


@end
