//
//  HHPublicGoodsVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/26.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHPublicGoodsVC.h"
#import "HYPicModel.h"

@interface HHPublicGoodsVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>{
    
    NSMutableArray *_subTypeArray;
    ///新旧相关
    NSMutableArray *_newDegreeArray;
    NSString *_newOrOld;
    
    long _currentAddBtnTag;
    
    NSMutableArray *_imageArray;
    ///图片路径
    NSMutableArray *_imagePathArray;
    ///类型两数组
    NSMutableArray *_typeNameArray;
    NSMutableArray *_typeIDarray;
    NSString *_currentTypeID;
    ///小区相关
    NSMutableArray *_communityIDArray;
    NSMutableArray *_communityNameArray;
    NSString *_currentCommunityID;
}

@end

@implementation HHPublicGoodsVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setData];
    
    [self setUI];
    
    [self getTypeList];
    
    [self getCommuity];
    
}

#pragma mark ---Data---======================================
- (void)setData{
    _subTypeArray   = [[NSMutableArray alloc]initWithObjects:@"男女服装",@"婴儿用品",@"DIY用品",@"电器",@"家居",@"电脑", nil];
    _newDegreeArray = [[NSMutableArray alloc]initWithObjects:@"全新",@"9成新",@"8成新",@"7成新",@"6成新",@"5成新",@"4成新",@"3成新",@"2成新",@"1成新", nil];
    _imageArray     = [[NSMutableArray alloc]initWithObjects:@"",@"", nil];
    _imagePathArray = [[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil];
    _typeNameArray  = [NSMutableArray new];
    _typeIDarray    = [NSMutableArray new];
    _newOrOld       = @"10";
    _communityIDArray    = [NSMutableArray new];
    _communityNameArray  = [NSMutableArray new];
}

#pragma mark ---set UI---======================================
- (void)setUI{
    _tableView.tableHeaderView = _headerView;
    _tableView.tableFooterView = _footerView;
    _TVDescription.layer.borderColor = HHBackGroundColor.CGColor;
    _TVDescription.layer.borderWidth = 0.5;
    
    if ([self.MyFreeGoodsId intValue]) {
        self.titleName.text = self.titleNameStr;
    }
    _TFType.text = self.GoodsClass;
}

#pragma mark ---发布分类---======================================
- (IBAction)selectType:(UIButton *)sender {
    if ([self.MyFreeGoodsId intValue]) {
        return;
    }else{
        
    }
    
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(_TFType.frame.origin.x, _TFType.frame.origin.y + 64+30, _TFType.frame.size.width, 60) selectData:@[@"闲置物品",@"房屋租售"] action:^(NSInteger index){
        _TFType.text = @[@"闲置物品",@"房屋租售"][index];
        if (index==0) {
            [UIView animateWithDuration:0.2 animations:^{
                _headerHeight.constant = 457;//457
                [self.view layoutIfNeeded];
                _TFSubType.text = _typeNameArray[0];
                _currentTypeID = _typeIDarray[0];
                _btnFace.hidden = NO;
                _labFace.hidden = NO;
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                _headerHeight.constant = 415;//457
                [self.view layoutIfNeeded];
                _TFSubType.text = @"出租";
                _currentTypeID = @"0";
                _btnFace.hidden = YES;
                _labFace.hidden = YES;

            }];

        }
    } animated:YES];
}

#pragma mark ---分类---======================================
- (IBAction)selectSubType:(UIButton *)sender {
    if ([_TFType.text isEqualToString:@"闲置物品"]) {
        [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(_TFSubType.frame.origin.x, _TFSubType.frame.origin.y+64+30+50-_tableView.contentOffset.y, _TFSubType.frame.size.width, 100) selectData:_typeNameArray action:^(NSInteger index) {
            _TFSubType.text = _typeNameArray[index];
            _currentTypeID = _typeIDarray[index];
        } animated:YES];
    }else{
        [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(_TFSubType.frame.origin.x, _TFSubType.frame.origin.y+64+30+50-_tableView.contentOffset.y, _TFSubType.frame.size.width, 100) selectData:@[@"出租",@"出售"] action:^(NSInteger index) {
            _TFSubType.text = @[@"出租",@"出售"][index];
            _currentTypeID = [NSString stringWithFormat:@"%ld",index];
        } animated:YES];

    }
    
}

#pragma mark ---小区---=====================================
- (IBAction)小区:(UIButton *)sender {
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(_TFCommunity.frame.origin.x, _TFCommunity.frame.origin.y+64+30+50-_tableView.contentOffset.y, _TFCommunity.frame.size.width, 100) selectData:_communityNameArray action:^(NSInteger index) {
        _TFCommunity.text = _communityNameArray[index];
        _currentCommunityID = _communityIDArray[index];
    } animated:YES];

}

#pragma mark ---新旧---======================================
- (IBAction)selectNewOrOld:(UIButton *)sender {
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(_TFNewOrOld.frame.origin.x, _TFNewOrOld.frame.origin.y + 64+30+50-_tableView.contentOffset.y, _TFNewOrOld.frame.size.width, 100) selectData:_newDegreeArray action:^(NSInteger index) {
        _TFNewOrOld.text = _newDegreeArray[index];
        _newOrOld = [NSString stringWithFormat:@"%ld",10-index];
    } animated:YES];
}

#pragma mark ---addImage---=====================================
- (IBAction)addImage:(UIButton *)sender {
    kLog(@"%ld",(long)sender.tag);
    _currentAddBtnTag = sender.tag;
    
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
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    if (_currentAddBtnTag == 0) {
        [_btnAddImage_one setBackgroundImage:image forState:UIControlStateNormal];
        [_imageArray replaceObjectAtIndex:0 withObject:image];
    }else if(_currentAddBtnTag == 1){
        [_btnAddImage_two setBackgroundImage:image forState:UIControlStateNormal];
        [_imageArray replaceObjectAtIndex:1 withObject:image];
    }else{
        [_btnAddImage_thr setBackgroundImage:image forState:UIControlStateNormal];
    }
    
    [self UploadImageWithImage:image andPath:fullPath];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ---获取类型列表---======================================
- (void)getTypeList{
    NSDictionary *dic = [NSDictionary new];
    [[HYHttp sharedHYHttp]POST:SecondHandGoodsTypeUrl parameters:dic success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"]integerValue] == 1) {
            NSDictionary *obj = [responseObject objectForKey:@"obj"];
            NSArray *rows =  [obj objectForKey:@"rows"];
            for (NSDictionary *dic in rows) {
                [_typeIDarray addObject:[dic objectForKey:@"id"]];
                [_typeNameArray addObject:[dic objectForKey:@"className"]];
            }
            if (_typeNameArray.count) {
                _TFSubType.text = _typeNameArray[0];
                _currentTypeID = _typeIDarray[0];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark ---获取小区---======================================
- (void)getCommuity{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[[NSUserDefaults standardUserDefaults] objectForKey:HHUser_info_userID] forKey:@"userId"];
    [[HYHttp sharedHYHttp]POST:GetUserHouseInfoUrl parameters:param success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            [_communityIDArray removeAllObjects];
            
            NSDictionary *obj     = [responseObject objectForKey:@"obj"];
            NSArray *rows         = [obj objectForKey:@"rows"];
            for (NSDictionary *dic in rows) {
                [_communityIDArray addObject:[dic objectForKey:@"residentialInfoId"]];
                [_communityNameArray addObject:[dic objectForKey:@"residentialName"]];
            }
            _TFCommunity.text   = _communityNameArray[0];
            _currentCommunityID = _communityIDArray[0];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark ---校验---======================================
- (BOOL)isAvailableInfo{
    if (kStringIsEmpty(_TFTitle.text)) {
        [ShowMessage showTextOnly:@"请输入标题" messageView:self.view];
        return NO;
    }
    if ([_imagePathArray[0]length]==0||[_imagePathArray[1] length]==0||[_imagePathArray[2] length]==0) {
        [ShowMessage showTextOnly:@"请选择三张图片" messageView:self.view];
        return NO;
    }
    
    return YES;
    
}


#pragma mark ---上传图片---======================================
- (void)UploadImageWithImage:(UIImage *)image andPath:(NSString *)path{
    
    NSData *imgData = UIImageJPEGRepresentation(image, 0.5);
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[[NSUserDefaults standardUserDefaults]objectForKey:HHUser_info_userID] forKey:@"userId"];
    
    HYPicModel *model = [[HYPicModel alloc]init];
    model.pic     = image;
    model.picData = imgData;
    model.picName = @"appfile";
    model.url     = path;
    
    
    [[HYHttp sharedHYHttp]POST:UploadImageUrl parameters:param andPic:model progress:nil success:^(id  _Nonnull responseObject) {
        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"]integerValue] == 1) {
            NSDictionary *obj = [responseObject objectForKey:@"obj"];
            NSString *imageID = [NSString stringWithFormat:@"%@",[obj objectForKey:@"id"]];
            [_imagePathArray replaceObjectAtIndex:_currentAddBtnTag withObject:imageID];
        }else{
            [ShowMessage showTextOnly:[responseObject objectForKey:@"errorMessage"] messageView:self.view];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [ShowMessage showTextOnly:@"提交失败，请重试" messageView:self.view];
        
    }];

}

#pragma mark ---发布---=====================================
- (IBAction)publicAction:(UIButton *)sender {
    
    if (![self isAvailableInfo]) {
        return;
    }
    
    [ShowMessage showLoadingData:self.view strMessage:@"提交中，稍等"];
    NSString *requestUrl = [_TFType.text isEqualToString:@"闲置物品"]?SecondHandGoodsPublicUrl:HouseLeasePublishUrl;
    NSMutableDictionary *param = [NSMutableDictionary new];
    
    
    if ([self.MyFreeGoodsId intValue]) {
        [param setObject:self.MyFreeGoodsId forKey:@"id"];
    }else{
        
    }
    
    [param setObject:_currentTypeID forKey:@"goodsId"];
    [param setObject:_currentCommunityID forKey:@"residentialInfoId"];
    [param setObject:[[NSUserDefaults standardUserDefaults]objectForKey:HHUser_info_userID] forKey:@"userId"];
    [param setObject:_TFTitle.text forKey:@"title"];
    [param setObject:_TVDescription.text forKey:@"goodsDescribe"];
    [param setObject:_newOrOld forKey:@"oldAndNew"];
    [param setObject:_currentTypeID forKey:@"type"];
    [param setObject:_btnFace.selected?@"1":@"0" forKey:@"isNegotiable"];
    [param setObject:_TFPrice.text forKey:@"price"];
    [param setObject:_TFSubType.text forKey:@"goodsName"];
    [param setObject:[_imagePathArray componentsJoinedByString:@","] forKey:@"imgs"];
    [param setObject:_TFPhoneNum.text forKey:@"telephone"];
    
    [[HYHttp sharedHYHttp]POST:requestUrl parameters:param success:^(id  _Nonnull responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            [ShowMessage showTextOnly:[responseObject objectForKey:@"obj"] messageView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

            [ShowMessage showTextOnly:[responseObject objectForKey:@"errorMessage"] messageView:self.view];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        [ShowMessage showTextOnly:@"保存失败，请重试" messageView:self.view];

    }];
}

#pragma mark ---返回---=====================================
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ---面议---=====================================
- (IBAction)definePrice:(UIButton *)sender {
    _btnFace.selected = !_btnFace.selected;
    if (_btnFace.selected) {
        _TFPrice.enabled = NO;
    }else{
        _TFPrice.enabled = YES;
    }
    
}

@end
