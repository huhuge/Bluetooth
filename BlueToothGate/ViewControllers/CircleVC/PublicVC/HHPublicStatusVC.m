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


@interface HHPublicStatusVC ()<QBImagePickerControllerDelegate>{
    NSMutableArray *_imgAssetArray;
    NSMutableArray *_imageArray;
}

@end

@implementation HHPublicStatusVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setData];
}

#pragma mark ---setData---======================================
- (void)setData{
    _imageArray    = [[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil];
    _imgAssetArray = [[NSMutableArray alloc]init];
}

- (IBAction)addImage:(UIButton *)sender {
    QBImagePickerController *imagePickerController = [QBImagePickerController new];
    imagePickerController.delegate                    = self;
    imagePickerController.mediaType                   = QBImagePickerMediaTypeImage;
    imagePickerController.allowsMultipleSelection     = YES;
    imagePickerController.showsNumberOfSelectedAssets = YES;
    imagePickerController.maximumNumberOfSelection    = 3;
    imagePickerController.minimumNumberOfSelection    = 3;
//    imagePickerController.prompt = @"请选择图像!";//在界面上方显示文字“请选择图像!”

    [self presentViewController:imagePickerController animated:YES completion:NULL];
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
