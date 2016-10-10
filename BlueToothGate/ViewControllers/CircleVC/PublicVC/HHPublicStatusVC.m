//
//  HHPublicStatusVC.m
//  BlueToothGate
//
//  Created by JeroMac on 16/8/31.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHPublicStatusVC.h"

extern BOOL isExercise;
extern NSString *sex;
extern NSArray *testArray;


@interface HHPublicStatusVC ()<QBImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    NSMutableArray *_imgAssetArray;
    NSMutableArray *_imageArray;
    NSMutableArray *_imagePathArray;
    NSInteger _index;
    long _currentAddBtnTag;

}

@end

@implementation HHPublicStatusVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setData];
}

#pragma mark ---setData---======================================
- (void)setData{
    _imageArray     = [[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil];
    _imgAssetArray  = [[NSMutableArray alloc]init];
    _imagePathArray = [[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil];
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
        [_addImg_one setBackgroundImage:image forState:UIControlStateNormal];
        [_imageArray replaceObjectAtIndex:0 withObject:image];
    }else if(_currentAddBtnTag == 1){
        [_addImg_two setBackgroundImage:image forState:UIControlStateNormal];
        [_imageArray replaceObjectAtIndex:1 withObject:image];
    }else{
        [_addImg_three setBackgroundImage:image forState:UIControlStateNormal];
    }
    
    [self UploadImageWithImage:image andPath:fullPath];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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



#pragma mark - QBImagePickerControllerDelegate
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets
{
    [_imgAssetArray removeAllObjects];
    
    for (int i = 0; i<assets.count; i++)
    {
        [_imgAssetArray addObject:[assets objectAtIndex:i]];
    }
    

    [self setImage];

    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    NSLog(@"Canceled.");
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark ---setImg---======================================
- (void)setImage{
    [ShowMessage showLoadingData:self.view strMessage:@"图片上传中，请稍等"];

    for (int i = 0; i < _imgAssetArray.count; i++) {
        PHAsset *asset = _imgAssetArray[i];
        PHImageRequestOptions * options = [[PHImageRequestOptions alloc]init];
        options.deliveryMode = PHImageContentModeAspectFill;
        [[PHImageManager defaultManager]requestImageForAsset:asset targetSize:[UIScreen mainScreen].bounds.size contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info)
         {
             [_imageArray replaceObjectAtIndex:i withObject:result];
             
             if (i == 0) {
                 [_addImg_one setBackgroundImage:result forState:UIControlStateNormal];
             }
             if (i == 1) {
                 [_addImg_two setBackgroundImage:result forState:UIControlStateNormal];
             }
             if (i == 2) {
                 [_addImg_three setBackgroundImage:result forState:UIControlStateNormal];
             }
             kLog(@"%@",_imageArray);
         }];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0; i < _imageArray.count; i++) {
            UIImage *img = _imageArray[i];
            [self UploadImageWithImage:img andIndex:i];
        }
    });

    
}

#pragma mark ---发布---=====================================
- (IBAction)publicAction:(UIButton *)sender {
    
    if (kStringIsEmpty(_TFtitle.text)) {
        [ShowMessage showTextOnly:@"请输入标题" messageView:self.view];
        return;
    }
    if (kStringIsEmpty(_TFcontent.text)) {
        [ShowMessage showTextOnly:@"请输入内容" messageView:self.view];
        return;
    }
    if (kStringIsEmpty(_imagePathArray[0])||kStringIsEmpty(_imagePathArray[1])||kStringIsEmpty(_imagePathArray[2])) {
        [ShowMessage showTextOnly:@"请选择三张图片" messageView:self.view];
        return;
    }
    [ShowMessage showLoadingData:self.view strMessage:@"提交中，请稍等"];

    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[_imagePathArray componentsJoinedByString:@","] forKey:@"imgs"];
    [param setObject:[[userDefault dictionaryForKey:HHUser_info_selectedCommunity_dic] objectForKey:@"residentialInfoId"] forKey:@"residentialInfoId"];
    [param setObject:[userDefault objectForKey:HHUser_info_userID] forKey:@"userId"];
    [param setObject:_TFtitle.text forKey:@"title"];
    [param setObject:_TFcontent.text forKey:@"contents"];
    [[HYHttp sharedHYHttp]POST:PublicCircleUrl parameters:param success:^(id  _Nonnull responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"]integerValue] == 1) {
            [ShowMessage showTextOnly:[responseObject objectForKey:@"obj"] messageView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                isExercise = YES;
                [self.navigationController popViewControllerAnimated:YES];
            });
           }else{
            [ShowMessage showTextOnly:[responseObject objectForKey:@"errorMessage"] messageView:self.view];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    }];
}

#pragma mark ---上传图片---======================================
- (void)UploadImageWithImage:(UIImage *)image andIndex:(int )index{
    
    NSData *imgData = UIImageJPEGRepresentation(image, 0.5);
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[[NSUserDefaults standardUserDefaults]objectForKey:HHUser_info_userID] forKey:@"userId"];
    
    HYPicModel *model = [[HYPicModel alloc]init];
    model.pic     = image;
    model.picData = imgData;
    model.picName = @"appfile";
    model.url     = @"";
    
    
    [[HYHttp sharedHYHttp]POST:UploadImageUrl parameters:param andPic:model progress:nil success:^(id  _Nonnull responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"]integerValue] == 1) {
            NSDictionary *obj = [responseObject objectForKey:@"obj"];
            NSString *imageID = [NSString stringWithFormat:@"%@",[obj objectForKey:@"id"]];
            [_imagePathArray replaceObjectAtIndex:index withObject:imageID];
        }else{
            [ShowMessage showTextOnly:[responseObject objectForKey:@"errorMessage"] messageView:self.view];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [ShowMessage showTextOnly:@"图片上传失败，请重试" messageView:self.view];
        
    }];
    
}



- (IBAction)backAction:(UIButton *)sender {
    
//    isExercise = YES;
//    sex = @"不男不女";
//    testArray = @[@"2B",@"SB"];
//    SharedAppDelegate.testStr = @"test";
//    self.block(@"终于成功了 ");
    
    [self.navigationController popViewControllerAnimated:YES];

}


@end
