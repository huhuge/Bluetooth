//
//  HHAddNewPayVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/9/10.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHAddNewPayVC.h"
#import "HHSelectCommunityModel.h"

@interface HHAddNewPayVC (){
    ///房屋信息
    NSMutableArray *_houseInfoArray;
    ///房屋名
    NSMutableArray *_houseNameArray;
    ///类型名
    NSMutableArray *_payTypeNameArray;
    ///类型ID
    NSMutableArray *_payTypeInfoArray;
    ///
    NSString *_houseID;
    NSString *_typeID;
}

@end

@implementation HHAddNewPayVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setData];
    
    [self getCommunity];
    
    [self getType];
    
}

#pragma mark ---setData---======================================
- (void)setData{
    _houseInfoArray   = [NSMutableArray new];
    _houseNameArray   = [NSMutableArray new];
    _payTypeInfoArray = [NSMutableArray new];
    _payTypeNameArray = [NSMutableArray new];
    
    if (_carNumber) {
        _TFCarNumber.text = _carNumber;
        _TFhouse.text     = _house_from_fommer;
        _houseID          = _houseID_from_fommer;
        _TFPayType.text   = _type_from_fommer;
        _typeID           = _type_id_form_fommer;
    }
}

#pragma mark ---获取小区---======================================
- (void)getCommunity{
    if (_carNumber) {
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[[NSUserDefaults standardUserDefaults] objectForKey:HHUser_info_userID] forKey:@"userId"];
    [[HYHttp sharedHYHttp]POST:GetUserHouseInfoUrl parameters:param success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            NSDictionary *obj = [responseObject objectForKey:@"obj"];
            NSArray *rows     = [obj objectForKey:@"rows"];
            
            for (NSDictionary *dic in rows) {
                HHSelectCommunityModel *model = [HHSelectCommunityModel new];
                [model setValuesForKeysWithDictionary:dic];
                if ([model.authentication integerValue] == 2) {
                    NSString *nameStr = [NSString stringWithFormat:@"%@-%@-%@-%@",model.residentialName,model.buildingName,model.floor,model.houseNum];
                    
                    [_houseInfoArray addObject:model];
                    [_houseNameArray addObject:nameStr];
                }
            }
            HHSelectCommunityModel *model = _houseInfoArray[0];
            _TFhouse.text = [NSString stringWithFormat:@"%@-%@-%@-%@",model.residentialName,model.buildingName,model.floor,model.houseNum];
            _houseID = model.myID;
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark ---getType---======================================
- (void)getType{
    if (_carNumber) {
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary new];
    [[HYHttp sharedHYHttp]POST:GetPayTypeUrl parameters:param success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            NSDictionary *obj = [responseObject objectForKey:@"obj"];
            NSArray *rows     = [obj objectForKey:@"rows"];
            for (NSDictionary *dic in rows) {
                [_payTypeNameArray addObject:[dic objectForKey:@"typeName"]];
                [_payTypeInfoArray addObject:dic];
            }
            _TFPayType.text = [_payTypeInfoArray[0] objectForKey:@"typeName"];
            _typeID         = [_payTypeInfoArray[0] objectForKey:@"id"];
        }
    } failure:^(NSError * _Nonnull error) {
        kLog(@"fail");
    }];
}

#pragma mark --选择---=====================================
- (IBAction)selectAction:(UIButton *)sender {
    if (_dataID) {
        [ShowMessage showTextOnly:@"只能编辑卡号" messageView:self.view];
        return;
    }
    if (sender == _btnSelectHouse) {
        [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake( _TFhouse.frame.origin.x, _TFhouse.frame.origin.y+30+64, _TFhouse.frame.size.width, 150) selectData:_houseNameArray action:^(NSInteger index) {
            HHSelectCommunityModel *model = _houseInfoArray[index];
            _TFhouse.text = [NSString stringWithFormat:@"%@-%@-%@-%@",model.residentialName,model.buildingName,model.floor,model.houseNum];
            _houseID = model.myID;

        } animated:YES];

    }else{
        [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake( _TFPayType.frame.origin.x, _TFPayType.frame.origin.y+30+64, _TFPayType.frame.size.width, 150) selectData:_payTypeNameArray action:^(NSInteger index) {
            _TFPayType.text = _payTypeNameArray[index];
            _typeID = [_payTypeInfoArray[index] objectForKey:@"id"];
        } animated:YES];

    }
}


#pragma mark ---确定---=====================================
- (IBAction)ensureAction:(UIButton *)sender {
    if ([_TFCarNumber.text isEqualToString:@""]||_TFCarNumber.text.length == 0) {
        [ShowMessage showTextOnly:@"请输入卡号" messageView:self.view];
        return;
    }
    [ShowMessage showLoadingData:self.view strMessage:@"提交中，稍等"];

    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:_typeID forKey:@"proxyPayTypeId"];
    [param setObject:_houseID forKey:@"userHoueseInfoId"];
    [param setObject:_TFCarNumber.text forKey:@"cardNum"];
    if (_dataID) {
        [param setObject:_dataID forKey:@"id"];
    }
    
    [[HYHttp sharedHYHttp]POST:BindPayTypeUrl parameters:param success:^(id  _Nonnull responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            [ShowMessage showTextOnly:[responseObject objectForKey:@"obj"] messageView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [ShowMessage showTextOnly:[responseObject objectForKey:@"errorMessage"] messageView:self.view];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [ShowMessage showTextOnly:@"保存失败，请重试" messageView:self.view];

        kLog(@"fail");
    }];
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
