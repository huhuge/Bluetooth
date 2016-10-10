//
//  MyCountViewController.m
//  BlueToothGate
//
//  Created by guobao on 16/8/23.
//  Copyright © 2016年 hu. All rights reserved.
//
#import "HYHttp.h"
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
    NSDictionary *ProtraitDic;
    NSDictionary *BasicDic;
}
@end

@implementation MyCountViewController

- (void)viewWillAppear:(BOOL)animated{
     [self getPersonInfo];
}

- (void)viewDidLoad {
    BasicDic = [NSDictionary new];
    ProtraitDic = [NSDictionary new];
    [super viewDidLoad];
    [self getPersonInfo];

    
}

- (void)CreatUI{
    NSString *ProtraitStr = [NSString stringWithFormat:@"%@%@/%@",API_URL_BASE,ProtraitDic[@"path"], ProtraitDic[@"name"]];
    NSURL *url = [NSURL URLWithString:ProtraitStr];
    UIImage * imgP = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    if (imgP) {
        [self.protraitBtn setImage:imgP forState:UIControlStateNormal];
    }else{
        [self.protraitBtn setImage:[UIImage imageNamed:@"ic_account"] forState:UIControlStateNormal];
    }
    
    
    self.nickLabel.text = BasicDic[@"userName"];
    if (BasicDic[@"sex"]) {
        self.sexLabel.text = @"男";
    }else{
        self.sexLabel.text = @"女";
    }
    if ([BasicDic[@"birthday"] length]>10) {
        NSString *birStr =[BasicDic[@"birthday"] substringToIndex:10];
        self.dateLabel.text = birStr;
    }else{
        self.dateLabel.text = BasicDic[@"birthday"];
        
    }
    
    self.IDCardLabel.text = BasicDic[@"id_card"];

}


- (void)getPersonInfo{
    NSUserDefaults *Defau = [NSUserDefaults standardUserDefaults];
    NSString *userID = [Defau stringForKey:HHUser_info_userID];
    NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
    [mudic setObject:userID forKey:@"userId"];
    [[HYHttp sharedHYHttp] GET:GetUserInfoUrl parameters:mudic success:^(id  _Nonnull responseObject) {
        //    NSLog(@"8888%@", responseObject);
        if ([responseObject[@"success"] integerValue]) {
            NSDictionary *dic = responseObject[@"obj"];
            NSArray *baseArr = dic[@"userBase"];
            BasicDic = baseArr[0];
//            self.nameLabel.text = baseDic[@"userName"];
            
            NSArray *ProArr = dic[@"userPhoto"];
            ProtraitDic = ProArr[0];
//            NSString *ProtraitStr = [NSString stringWithFormat:@"%@%@/%@",API_URL_BASE,ProtraitDic[@"path"], ProtraitDic[@"name"]];
            [self CreatUI];
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"8888%@", error);
    }];
    
    
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
    _selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *imgData = UIImageJPEGRepresentation(_selectedImage, 0.5);
     NSMutableDictionary *mudic = [NSMutableDictionary new];
      [mudic setObject:[[NSUserDefaults standardUserDefaults]objectForKey:HHUser_info_userID] forKey:@"userId"];
    
        //[self saveImage:_selectedImage withName:@"currentImage.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    HYPicModel *model = [[HYPicModel alloc]init];
    model.pic     = _selectedImage;
    model.picData = imgData;
    model.picName = @"appfile";
    model.url     = fullPath;
    
    [[HYHttp sharedHYHttp]POST:UploadImageUrl parameters:nil andPic:model progress:nil success:^(id  _Nonnull responseObject) {
        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        kLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"success"] integerValue] == 1) {
            NSDictionary *DIC = [responseObject objectForKey:@"obj"];
            NSString *idStr = DIC[@"id"];
            [mudic setObject:idStr forKey:@"saccId"];
     [[HYHttp sharedHYHttp] POST:UpdateMyProtrait parameters:mudic success:^(id  _Nonnull responseObject) {
//      kLog(@"333%@",responseObject);
         [ShowMessage showTextOnly:[responseObject objectForKey:@"obj"] messageView:self.view];
         
         [self.protraitBtn setImage:_selectedImage forState:UIControlStateNormal];
} failure:^(NSError * _Nonnull error) {
    kLog(@"5555%@",error);
}];
        }else{
            [ShowMessage showTextOnly:[responseObject objectForKey:@"errorMessage"] messageView:self.view];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [ShowMessage showTextOnly:@"提交失败，请重试" messageView:self.view];
        
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
