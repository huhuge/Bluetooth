//
//  HHGoodsDetailVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/29.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHGoodsDetailVC.h"

@interface HHGoodsDetailVC ()

@end

@implementation HHGoodsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.tableHeaderView = _headerView;
    _tableView.separatorStyle  = UITableViewCellSelectionStyleNone;
    
    if (_model) {
        [self setUI];
    }
}


#pragma mark ---UI---======================================
- (void)setUI{
    
    NSArray *imageArr = [_model.imgs componentsSeparatedByString:@","];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@",API_URL_BASE,_model.headImg,_model.headImgName]] placeholderImage:GetImage(@"placeholder")];
    [_image_one sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",API_URL_BASE,@"app/load_app_imgFle.htm?imgId=",imageArr[0]]] placeholderImage:GetImage(@"placeholder")];
    [_image_two sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",API_URL_BASE,@"app/load_app_imgFle.htm?imgId=",imageArr[1]]] placeholderImage:GetImage(@"placeholder")];
    [_image_thr sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",API_URL_BASE,@"app/load_app_imgFle.htm?imgId=",imageArr[2]]] placeholderImage:GetImage(@"placeholder")];
    
    _labTitle.text       = [NSString stringWithFormat:@"%@",_model.title];
    _labCommunity.text   = [NSString stringWithFormat:@"%@",_model.residentialInfoName];
    _labTime.text        = [NSString stringWithFormat:@"%@天前",_model.days];
    _labGoodsName.text   = [NSString stringWithFormat:@"%@",_model.goodsName];
    _labDescription.text = [NSString stringWithFormat:@"%@",_model.goodsDescribe];
    _labGoodsPrice.text  = [NSString stringWithFormat:@"%@",_model.price];
    _labPrice.text       = [NSString stringWithFormat:@"%@",_model.price];
    _labNew.text         = [NSString stringWithFormat:@"%@成新",_model.oldAndNew];
    NSString *type       = [NSString stringWithFormat:@"%@",_model.type];
    _labRent.text        = [type isEqualToString:@"0"]?@"租":@"售";
    _labRent.backgroundColor = [type isEqualToString:@"0"]?HHThemeColor:kRGBColor(254, 198, 54);
    
    self.goodView.hidden =  _isHouse;
    self.roomView.hidden = !_isHouse;

}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
