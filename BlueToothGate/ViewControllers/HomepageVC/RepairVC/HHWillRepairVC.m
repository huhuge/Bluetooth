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

@interface HHWillRepairVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>{
    long _currentAddBtnTag;
    long _currentDelBtnTag;
    NSMutableArray *_imageArray;
    ///类型
    NSArray *_typeArray;

}

@end

@implementation HHWillRepairVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLayers];
    
    [self setData];
}

#pragma mark ---setData---======================================
- (void)setData{
    _imageArray = [[NSMutableArray alloc]initWithObjects:@"",@"", nil];
    _typeArray = [[NSArray alloc]initWithObjects:@"水管维修",@"网络维修", nil];

}

#pragma mark ---setLayers---======================================
- (void)setLayers{
    _TFRepairType.layer.borderColor = kRGBColor(228, 228, 228).CGColor;
    _TFRepairType.layer.borderWidth = 0.5;
    _TVContent.layer.borderColor    = kRGBColor(228, 228, 228).CGColor;
    _TVContent.layer.borderWidth    = 0.5;
    _btnEnsure.layer.masksToBounds  = YES;
    _btnEnsure.layer.cornerRadius   = 5;
    
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
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(_TFRepairType.frame.origin.x, _TFRepairType.frame.origin.y+30+64, _TFRepairType.frame.size.width, 60) selectData:@[@"水管维修",@"网络维修"] action:^(NSInteger index) {
        
        kLog(@"%d",index);
        _TFRepairType.text = _typeArray[index];
        
    } animated:YES];
}

#pragma mark ---ensure---=====================================
- (IBAction)ensureAction:(UIButton *)sender {
    HHEnsureRepairVC *nextVC =  [[HHEnsureRepairVC alloc]init];
    nextVC.repairType = _TFRepairType.text;
    nextVC.content    = _TVContent.text;
    nextVC.imgArray   = _imageArray;
    [self.navigationController pushViewController:nextVC animated:YES];
    
}

#pragma mark ---repairRecord---=====================================
- (IBAction)RepairRecord:(UIButton *)sender {
    HHRepairListVC *nextVC = [HHRepairListVC new];
    [self.navigationController pushViewController:nextVC animated:YES];
}

#pragma mark ---back---=====================================
- (IBAction)BackAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
