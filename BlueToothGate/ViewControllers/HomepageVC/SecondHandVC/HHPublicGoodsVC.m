//
//  HHPublicGoodsVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/26.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHPublicGoodsVC.h"

@interface HHPublicGoodsVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>{
    NSMutableArray *_subTypeArray;
    NSMutableArray *_newDegreeArray;
    long _currentAddBtnTag;
    NSMutableArray *_imageArray;

}

@end

@implementation HHPublicGoodsVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setData];
    
    [self setUI];
    
}

#pragma mark ---Data---======================================
- (void)setData{
    _subTypeArray = [[NSMutableArray alloc]initWithObjects:@"男女服装",@"婴儿用品",@"DIY用品",@"电器",@"家居",@"电脑", nil];
    _newDegreeArray = [[NSMutableArray alloc]initWithObjects:@"全新",@"九成新",@"八成新",@"七成新",@"六成新",@"其他", nil];
    _imageArray = [[NSMutableArray alloc]initWithObjects:@"",@"", nil];
}

#pragma mark ---setUI---======================================
- (void)setUI{
    _tableView.tableHeaderView = _headerView;
    _tableView.tableFooterView = _footerView;
    _TVDescription.layer.borderColor = HHBackGroundColor.CGColor;
    _TVDescription.layer.borderWidth = 0.5;
    
}

#pragma mark ---发布分类---======================================
- (IBAction)selectType:(UIButton *)sender {
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(_TFType.frame.origin.x, _TFType.frame.origin.y + 64+30, _TFType.frame.size.width, 60) selectData:@[@"闲置物品",@"房屋租售"] action:^(NSInteger index){
        _TFType.text = @[@"闲置物品",@"房屋租售"][index];
        if (index==0) {
            [UIView animateWithDuration:0.2 animations:^{
                _headerHeight.constant = 457;//457
                [self.view layoutIfNeeded];
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                _headerHeight.constant = 415;//457
                [self.view layoutIfNeeded];
            }];

        }
    } animated:YES];
}

#pragma mark ---分类---======================================
- (IBAction)selectSubType:(UIButton *)sender {
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(_TFSubType.frame.origin.x, _TFSubType.frame.origin.y+64+30+50-_tableView.contentOffset.y, _TFSubType.frame.size.width, 100) selectData:_subTypeArray action:^(NSInteger index) {
        _TFSubType.text = _subTypeArray[index];
    } animated:YES];
}

#pragma mark ---新旧---======================================
- (IBAction)selectNewOrOld:(UIButton *)sender {
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(_TFNewOrOld.frame.origin.x, _TFNewOrOld.frame.origin.y + 64+30+50-_tableView.contentOffset.y, _TFNewOrOld.frame.size.width, 100) selectData:_newDegreeArray action:^(NSInteger index) {
        _TFNewOrOld.text = _newDegreeArray[index];
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


#pragma mark ---发布---=====================================
- (IBAction)publicAction:(UIButton *)sender {
    

}

#pragma mark ---返回---=====================================
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ---面议---=====================================
- (IBAction)definePrice:(UIButton *)sender {
    sender.selected = !sender.selected;

    
}

@end
