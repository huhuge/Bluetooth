//
//  MyCountViewController.m
//  BlueToothGate
//
//  Created by guobao on 16/8/23.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "MyCountViewController.h"
#import "NickViewController.h"
#import "SexViewController.h"
#import "DateViewController.h"
#import "IDCardViewController.h"
#import "changePSWViewController.h"
#import "addressManagerViewController.h"
@interface MyCountViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImage *_selectedImage;
}
@end

@implementation MyCountViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
}


- (IBAction)MyAccountBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nickBtnClick:(UIButton *)sender {
    NickViewController *nickVC = [[NickViewController alloc] init];
    [self.navigationController pushViewController:nickVC animated:YES];
}
- (IBAction)sexBtnClick:(UIButton *)sender {
    SexViewController *sexVC = [[SexViewController alloc] init];
    [self.navigationController pushViewController:sexVC animated:YES];
}

- (IBAction)dateBtnClick:(UIButton *)sender {
    DateViewController *dateVC = [[DateViewController alloc] init];
    [self.navigationController pushViewController:dateVC animated:YES];
}
- (IBAction)IDCardClick:(UIButton *)sender {
    IDCardViewController *IDCardVC = [[IDCardViewController alloc] init];
    [self.navigationController pushViewController:IDCardVC animated:YES];
}
- (IBAction)exchangePSWBtnClick:(UIButton *)sender {
    changePSWViewController *chanePSWVC = [[changePSWViewController alloc] init];
    [self.navigationController pushViewController:chanePSWVC animated:YES];
}
- (IBAction)addressBtnClick:(UIButton *)sender {
    addressManagerViewController *addressVC = [[addressManagerViewController alloc] init];
    [self.navigationController pushViewController:addressVC animated:YES];
}


- (IBAction)protraitBtn:(UIButton *)sender {
    
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = NO;
        [self presentViewController:picker animated:YES completion:nil];
  
   }

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
 
        [picker dismissViewControllerAnimated:YES completion:^() {
            _selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            
            [self.protraitBtn setImage:_selectedImage forState:UIControlStateNormal];
            
//            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//            [manager.requestSerializer setValue:@"image/png/jpeg/jpg"forHTTPHeaderField:@"Content-Type"];
//            manager.requestSerializer = [AFJSONRequestSerializer serializer];
//            manager.responseSerializer = [AFJSONResponseSerializer serializer];
//            [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"application/x-javascript", nil]];
//            
//            NSData *imageData = UIImageJPEGRepresentation(_selectedImage, 1);
//            
//            NSUserDefaults *userDeault = [NSUserDefaults standardUserDefaults];
//            NSString *strId = [userDeault stringForKey:@"myId"];
//            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//            [dic setObject:strId forKey:@"userId"];
//            //    NSLog(@"456%@", str);
//            
//            NSString *URLStr = [NSString stringWithFormat:@"%@headImage.action",kNetwork];
//            [manager POST:URLStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//                
//                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//                formatter.dateFormat = @"yyyyMMddHHmmss";
//                NSString *str = [formatter stringFromDate:[NSDate date]];
//                NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
//                
//                [formData appendPartWithFileData:imageData name:@"attachments" fileName:fileName mimeType:@"image/jpeg/file/png/jpg"];
//                
//            } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//                //                NSLog(@"344%@", responseObject);
//                [self showHint:@"头像修改成功"];
//            } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//                NSLog(@"227%@",error);
//            }];
//            
        }];
    
        [self dismissViewControllerAnimated:YES completion:nil];
   
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
