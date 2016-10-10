//
//  HHWillRepairVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/23.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHWillRepairVC.h"
#import "HHEnsureRepairVC.h"
#import "HHRepairListVC.h"
#import "HHRepairTypeModel.h"
#import "HHSelectCommunityModel.h"

@interface HHWillRepairVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>{
    HHEnsureRepairVC *nextVC;
    
    long _currentAddBtnTag;
    long _currentDelBtnTag;
    NSMutableArray *_imageArray;
    
    ///类型
    NSMutableArray *_typeArray;
    NSMutableArray *_displayArray;
    NSString *_typeID;
    NSString *_path;
    
    
    
    NSMutableArray *_communityOriginArray;
    NSMutableArray *_communityNameArray;
    NSString *_houseID;
    
}

@end

@implementation HHWillRepairVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLayers];
    
    [self setData];
    
    [self getRepairTypeList];
    
    [self getCommunity];
}

#pragma mark ---setData---======================================
- (void)setData{
    
    nextVC = [[HHEnsureRepairVC alloc]init];

    _imageArray           = [[NSMutableArray alloc]initWithObjects:@"",@"", nil];
    _typeArray            = [NSMutableArray new];
    _displayArray         = [NSMutableArray new];
    _communityNameArray   = [NSMutableArray new];
    _communityOriginArray = [NSMutableArray new];

}

#pragma mark ---setLayers---======================================
- (void)setLayers{
    _TFRepairType.layer.borderColor = kRGBColor(228, 228, 228).CGColor;
    _TFRepairType.layer.borderWidth = 0.5;
    _TFHouse.layer.borderColor      = kRGBColor(228, 228, 228).CGColor;
    _TFHouse.layer.borderWidth      = 0.5;
    _TVContent.layer.borderColor    = kRGBColor(228, 228, 228).CGColor;
    _TVContent.layer.borderWidth    = 0.5;
    _btnEnsure.layer.masksToBounds  = YES;
    _btnEnsure.layer.cornerRadius   = 5;
    
}

#pragma mark ---获取类型列表---======================================
- (void)getRepairTypeList{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [[HYHttp sharedHYHttp]POST:GetRepairTypeUrl parameters:dic success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            NSDictionary *obj = [responseObject objectForKey:@"obj"];
            NSArray *rows     = [obj objectForKey:@"rows"];
            for (NSDictionary *dic in rows) {
                HHRepairTypeModel *model = [HHRepairTypeModel new];
                [model setValuesForKeysWithDictionary:dic];
                [_typeArray addObject:model];
                [_displayArray addObject:[dic objectForKey:@"repairTypeName"]];
            }
            _TFRepairType.text = _displayArray[0];
            _typeID = [rows[0] objectForKey:@"id"];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark ---deleteImage---=====================================
- (IBAction)deleteImage:(UIButton *)sender {
    kLog(@"%ld",(long)sender.tag);
    _currentDelBtnTag = sender.tag;
    if (_currentDelBtnTag == 0) {
        [_btnAddImage_one setBackgroundImage:[UIImage imageNamed:@"add_image"] forState:UIControlStateNormal];
        
    }else{
         [_btnAddImage_two setBackgroundImage:[UIImage imageNamed:@"add_image"] forState:UIControlStateNormal];
        
    }
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
//    [self saveImage:image withName:@"currentImage.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
//    UIImage *savedImage = [UIImage imageWithContentsOfFile:fullPath];
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    nextVC.imageData = data;
    
    _path = fullPath;
    
    if (_currentAddBtnTag == 0) {
        [_btnAddImage_one setBackgroundImage:image forState:UIControlStateNormal];
        [_imageArray replaceObjectAtIndex:0 withObject:image];
    }else{
        [_btnAddImage_two setBackgroundImage:image forState:UIControlStateNormal];
        [_imageArray replaceObjectAtIndex:1 withObject:image];

    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark ---textField delegate---=====================================
-(void)textViewDidChange:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        _labPlacehoder.hidden = NO;
    }else{
        _labPlacehoder.hidden = YES;
    }
}

#pragma mark ---报修分类---=====================================
- (IBAction)selectType:(UIButton *)sender {
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(_TFRepairType.frame.origin.x, _TFRepairType.frame.origin.y+30+64, _TFRepairType.frame.size.width, 120) selectData:_displayArray action:^(NSInteger index) {
        
        kLog(@"%f",_TFRepairType.frame.origin.y);
        _TFRepairType.text = _displayArray[index];
        HHRepairTypeModel *model = _typeArray[index];
        _typeID = model.myID;
    } animated:YES];
}

#pragma mark ---选择房屋---=====================================
- (IBAction)selectBuilding:(UIButton *)sender {
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(_TFHouse.frame.origin.x, _TFHouse.frame.origin.y+30+64+58, _TFHouse.frame.size.width, 120) selectData:_communityOriginArray action:^(NSInteger index) {
        
        kLog(@"%f",_TFHouse.frame.origin.y);
        _TFHouse.text = _communityOriginArray[index];
        HHSelectCommunityModel *model = _communityNameArray[index];
        _houseID = model.myID;
    } animated:YES];
}

#pragma mark ---获取小区---======================================
- (void)getCommunity{
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
                    
                    [_communityNameArray addObject:model];
                    [_communityOriginArray addObject:nameStr];
                }
            }
            HHSelectCommunityModel *model = _communityNameArray[0];
            _TFHouse.text = [NSString stringWithFormat:@"%@-%@-%@-%@",model.residentialName,model.buildingName,model.floor,model.houseNum];
            _houseID = model.myID;
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


#pragma mark ---ensure---=====================================
- (IBAction)ensureAction:(UIButton *)sender {
    
    nextVC.repairType   = _TFRepairType.text;
    nextVC.content      = _TVContent.text;
    nextVC.imgArray     = _imageArray;
    nextVC.repairTypeID = _typeID;
    nextVC.house        = _TFHouse.text;
    nextVC.houseID      = _houseID;
    nextVC.fullPath     = _path;
    [self.navigationController pushViewController:nextVC animated:YES];
    
}

#pragma mark ---repairRecord---=====================================
- (IBAction)RepairRecord:(UIButton *)sender {
    HHRepairListVC *next = [HHRepairListVC new];
    next.displayArray    = _displayArray;
    next.typeArray       = _typeArray;
    [self.navigationController pushViewController:next animated:YES];
}

#pragma mark ---back---=====================================
- (IBAction)BackAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
