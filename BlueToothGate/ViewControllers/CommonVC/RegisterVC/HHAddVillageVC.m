//
//  HHAddVillageVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/22.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHAddVillageVC.h"
#import "HHAddressInfoModel.h"
#import "HHCommunityInfoModel.h"
#import "HHBuildingInfoModel.h"
#import "HYPicModel.h"

@interface HHAddVillageVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    ///省
    NSMutableArray *_proArray;
    ///市
    NSMutableArray *_cityArray;
    ///区
    NSMutableArray *_areaArray;
    ///小区
    NSMutableArray *_commArray;
    ///楼栋
    NSMutableArray *_buildArray;
    NSString *buildID;
    ///查询ID
    NSString *_tempIDString;
    NSInteger _flag;
    UIImage *_tempImage;
    NSString *_fullPath;
    NSData *_imgData;
}

@end

@implementation HHAddVillageVC

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self setDadta];
    
    [self getAddressWithParentId:@""];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUI];
    
}

#pragma mark ---setData---======================================
- (void)setDadta{
    _proArray   = [NSMutableArray new];
    _cityArray  = [NSMutableArray new];
    _areaArray  = [NSMutableArray new];
    _commArray  = [NSMutableArray new];
    _buildArray = [NSMutableArray new];
    _tempImage  = [[UIImage alloc]init];
    _flag = 0;
}

#pragma mark ---setUI---======================================
- (void)setUI{
    
    _lineOne_x.constant = ScreenW/3;
    _lineTwo_x.constant = ScreenW/3 * 2;
    
}


#pragma mark ---获取省市区小区楼栋---=====================================
- (IBAction)selectAddress:(UIButton *)sender {
    kLog(@"%ld",(long)sender.tag);
    NSMutableArray *tempArray = [NSMutableArray new];
    switch (sender.tag) {
        case 1://显示省
        {
            if (_proArray.count == 0) {
                [ShowMessage showTextOnly:@"无可选省份" messageView:self.view];
                return;
            }
            _flag = 1;
            for (int i = 0; i < _proArray.count; i++) {
                HHAddressInfoModel *model = _proArray[i];
                NSString *name = model.areaName;
                [tempArray addObject:name];
            }
            [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake( 50, 100, ScreenW-100, 150) selectData:tempArray action:^(NSInteger index) {
                _labProvence.text = tempArray[index];
                HHAddressInfoModel *model = _proArray[index];
                NSString *idString = [NSString stringWithFormat:@"%@",model.myID];
                
                [self getAddressWithParentId:idString];
                [self cleanInfo];

            } animated:YES];

        }
            break;
        case 2://市
        {
            if (_cityArray.count == 0) {
                [ShowMessage showTextOnly:@"无可选市" messageView:self.view];
                return;
            }
            
            _flag = 2;
            for (int i = 0; i < _cityArray.count; i++) {
                HHAddressInfoModel *model = _cityArray[i];
                NSString *name = model.areaName;
                [tempArray addObject:name];
            }
            [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake( 50, 100, ScreenW-100, 150) selectData:tempArray action:^(NSInteger index) {
                _labCity.text = tempArray[index];
                HHAddressInfoModel *model = _cityArray[index];
                NSString *idString = [NSString stringWithFormat:@"%@",model.myID];
                
                [self getAddressWithParentId:idString];
                [self cleanInfo];

            } animated:YES];

        }
            break;
        case 3://区
        {
            if (_areaArray.count == 0) {
                [ShowMessage showTextOnly:@"无可选区" messageView:self.view];
                return;
            }
            _flag = 3;
            for (int i = 0; i < _areaArray.count; i++) {
                HHAddressInfoModel *model = _areaArray[i];
                NSString *name = model.areaName;
                [tempArray addObject:name];
            }
            [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake( 50, 100, ScreenW-100, 150) selectData:tempArray action:^(NSInteger index) {
                _labArea.text = tempArray[index];
                HHAddressInfoModel *model = _areaArray[index];
                NSString *idString = [NSString stringWithFormat:@"%@",model.myID];
                
                [self getCommunityWithID:idString];
                [self cleanInfo];

            } animated:YES];
            

        }
            break;
        case 4://小区
        {
            if (_commArray.count == 0) {
                [ShowMessage showTextOnly:@"无可选小区" messageView:self.view];
                return;
            }
            _flag = 4;
            for (int i = 0; i < _commArray.count; i++) {
                HHCommunityInfoModel *model = _commArray[i];
                NSString *name = model.residentialName;
                [tempArray addObject:name];
            }
            [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake( 50, 100, ScreenW-100, 150) selectData:tempArray action:^(NSInteger index) {
                _TFCommunity.text = tempArray[index];
                HHCommunityInfoModel *model = _commArray[index];
                NSString *idString = [NSString stringWithFormat:@"%@",model.myID];
                
                [self getBuildingInfoWithID:idString];
                [self cleanInfo];

            } animated:YES];
            
            

        }
            break;
        case 5://楼栋
        {
            if (_buildArray.count == 0) {
                [ShowMessage showTextOnly:@"无可选楼栋" messageView:self.view];
                return;
            }
            _flag = 5;
            for (int i = 0; i < _buildArray.count; i++) {
                HHBuildingInfoModel *model = _buildArray[i];
                NSString *name = model.buildingName;
                [tempArray addObject:name];
            }
            [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake( 50, 100, ScreenW-100, 150) selectData:tempArray action:^(NSInteger index) {
                _TFBuilding.text = tempArray[index];
                HHBuildingInfoModel *model = _buildArray[index];
                NSString *idString = [NSString stringWithFormat:@"%@",model.myID];
                _tempIDString = idString;
                buildID = idString;
            } animated:YES];

        }
            break;
            
        default:
            break;
    }
}
#pragma mark ---清空信息---======================================
- (void)cleanInfo{
    switch (_flag) {
        case 1:
        {
            _labCity.text = @"请选择市";
            _labArea.text = @"请选择区";
            _TFCommunity.text = @"";
            _TFBuilding.text  = @"";
        }
            break;
        case 2:
        {
            _labArea.text = @"请选择区";
            _TFCommunity.text = @"";
            _TFBuilding.text  = @"";

        }
            break;
        case 3:
        {
            _TFCommunity.text = @"";
            _TFBuilding.text  = @"";
        }
            break;
        case 4:
        {
            _TFBuilding.text  = @"";

        }
            break;
        case 5:
        {
            
        }
            break;
            
        default:
            break;
    }
}
#pragma mark ---请求地址省市区---======================================
- (void)getAddressWithParentId:(NSString *)parentID{
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    if (parentID.length) {
        [param setObject:parentID forKey:@"parentId"];
    }
    
    [[HYHttp sharedHYHttp] POST:GetAddressLinkUrl parameters:param success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            NSDictionary *obj = [responseObject objectForKey:@"obj"];
            NSArray *rows = [obj objectForKey:@"rows"];
            kLog(@"%@",rows);
            ///清空下一级所有数组
            if (_flag == 1) {
                [_cityArray removeAllObjects];
                [_areaArray removeAllObjects];
                [_commArray removeAllObjects];
                [_buildArray removeAllObjects];
            }else if (_flag == 2){
                [_areaArray removeAllObjects];
                [_commArray removeAllObjects];
                [_buildArray removeAllObjects];
            }
//            else if (_flag == 3){
//                [_commArray removeAllObjects];
//                [_buildArray removeAllObjects];
//            }
            
            for (NSDictionary *subDic in rows) {
                HHAddressInfoModel *model = [HHAddressInfoModel new];
                [model setValuesForKeysWithDictionary:subDic];
                switch (_flag) {
                    case 0://获取省列表
                    {
                        [_proArray addObject:model];
                    }
                        break;
                    case 1://市
                    {
                        [_cityArray addObject:model];
                    }
                        break;
                    case 2://区
                    {
                        [_areaArray addObject:model];
                    }
                        break;
                        
                    default:
                        break;
                }
            }
        }
        
    } failure:^(NSError * _Nonnull error) {
        kLog(@"fail");
    }];
    
}


#pragma mark ---获取小区---======================================
- (void)getCommunityWithID:(NSString *)IDString{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:IDString forKey:@"areaInfo"];
    [[HYHttp sharedHYHttp]POST:GetCommunityListUrl parameters:param success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            
            [_commArray removeAllObjects];
            [_buildArray removeAllObjects];
            
            NSDictionary *obj = [responseObject objectForKey:@"obj"];
            NSArray *rows = [obj objectForKey:@"rows"];
            kLog(@"%@",rows);
            for (NSDictionary *dic in rows) {
                
                HHCommunityInfoModel *model = [HHCommunityInfoModel new];
                [model setValuesForKeysWithDictionary:dic];
                [_commArray addObject:model];

            }
        }
    } failure:^(NSError * _Nonnull error) {
        kLog(@"error");
    }];
}

#pragma mark ---获取楼栋---======================================
- (void)getBuildingInfoWithID:(NSString *)IDString{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:IDString forKey:@"residentialInfoId"];
    [[HYHttp sharedHYHttp]POST:GetBuildingInfoListUrl parameters:param success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            
            [_buildArray removeAllObjects];
            
            NSDictionary *obj = [responseObject objectForKey:@"obj"];
            NSArray *rows = [obj objectForKey:@"rows"];
            kLog(@"%@",rows);
            for (NSDictionary *dic in rows) {
                
                HHBuildingInfoModel *model = [HHBuildingInfoModel new];
                [model setValuesForKeysWithDictionary:dic];
                [_buildArray addObject:model];
                
            }
        }
    } failure:^(NSError * _Nonnull error) {
        kLog(@"error");
    }];
}

#pragma mark ---添加小区---======================================
- (void)setAddRequest{
    if (![self isAvailableInfo]) {
        return;
    }else{
        
        [ShowMessage showLoadingData:self.view strMessage:@"提交中，稍等"];

        NSMutableDictionary *param = [NSMutableDictionary new];
        [param setObject:[userDefault objectForKey:HHUser_info_userID] forKey:@"userId"];
        [param setObject:buildID forKey:@"buildingInfoId"];
        if (_dataID) {
            [param setObject:_dataID forKey:@"id"];
        }
        [param setObject:@"2" forKey:@"authentication"];
        [param setObject:_TFFloor.text forKey:@"floor"];
        [param setObject:_TFDoorplate.text forKey:@"houseNum"];
        

        HYPicModel *model = [[HYPicModel alloc]init];
        model.pic     = _tempImage;
        model.picData = _imgData;
        model.picName = @"userHouseInfoImg";
        model.url     = _fullPath;
        
        
        
        [[HYHttp sharedHYHttp]POST:CheckUserHouseInfoUrl parameters:param andPicUrl:model progress:nil success:^(id  _Nonnull responseObject) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

            responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            kLog(@"%@",responseObject);
            if ([[responseObject objectForKey:@"success"]integerValue] == 1) {
                
                [ShowMessage showTextOnly:[responseObject objectForKey:@"obj"] messageView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });

            }else{
                [ShowMessage showTextOnly:[responseObject objectForKey:@"errorMessage"] messageView:self.view];

            }

        } failure:^(NSError * _Nonnull error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [ShowMessage showTextOnly:@"提交失败，请重试" messageView:self.view];

        }];

    }
}

#pragma mark ---验证信息---======================================
- (BOOL)isAvailableInfo{
    if ([_labProvence.text isEqualToString:@"请选择省"]) {
        [ShowMessage showTextOnly:@"请选择省份" messageView:self.view];
        return NO;
    }
    if ([_labCity.text isEqualToString:@"请选择市"]) {
        [ShowMessage showTextOnly:@"请选择市" messageView:self.view];
        return NO;
    }
    if ([_labArea.text isEqualToString:@"请选择区"]) {
        [ShowMessage showTextOnly:@"请选择区" messageView:self.view];
        return NO;
    }
    if ([_TFCommunity.text isEqualToString:@""]||_TFCommunity.text.length == 0) {
        [ShowMessage showTextOnly:@"请选择小区" messageView:self.view];
        return NO;
    }
    if ([_TFBuilding.text isEqualToString:@""]||_TFBuilding.text.length == 0) {
        [ShowMessage showTextOnly:@"请选择楼栋" messageView:self.view];
        return NO;
    }
    if ([_TFFloor.text isEqualToString:@""]||_TFFloor.text.length ==0) {
        [ShowMessage showTextOnly:@"请输入楼层" messageView:self.view];
        return NO;
    }
    if ([_TFDoorplate.text isEqualToString:@""]||_TFDoorplate.text.length == 0) {
        [ShowMessage showTextOnly:@"请输入门牌号" messageView:self.view];
        return NO;
    }
    if (!_imgData) {
        [ShowMessage showTextOnly:@"请选择房产证" messageView:self.view];
        return NO;
    }
    
    return YES;
}

#pragma mark ---添加图片---=====================================
- (IBAction)addImg:(UIButton *)sender {
    UIAlertController *changeAlert = [UIAlertController alertControllerWithTitle:@"请选择图片" message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType               = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.delegate                 = self;
        picker.allowsEditing            = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"手机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.delegate                 = self;
            picker.allowsEditing            = YES;
            picker.sourceType               = sourceType;
            [self presentViewController:picker animated:YES completion:nil];
        }else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"此设备无拍照功能" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action    = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [changeAlert addAction:photoAction];
    [changeAlert addAction:cameraAction];
    [changeAlert addAction:cancel];
    
    [self presentViewController:changeAlert animated:YES completion:nil];

}

#pragma mark --- UIImagePickerView Delegate --------------------------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //当图片不为空时显示图片并保存图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    //保存图片到本地
    //    [self saveImage:image withName:@"currentImage.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    //    UIImage *savedImage = [UIImage imageWithContentsOfFile:fullPath];
    [_btnAddImg setImage:image forState:UIControlStateNormal];
    _tempImage = image;
    _fullPath  = fullPath;
    _imgData = [[NSData alloc]initWithData:UIImageJPEGRepresentation(image, 0.5)];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerAction:(UIButton *)sender {
    [self setAddRequest];
}


- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
