//
//  AddressTableViewCell.h
//  BlueToothGate
//
//  Created by guobao on 16/9/26.
//  Copyright © 2016年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditorAddressDelegate <NSObject>

-(void)addressEditor:(NSString *)name num:(NSString *)num address:(NSString *)address addressID:(NSString *)addressID;
-(void)deleteAddress:(NSString *)ID;

@end


@interface AddressTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *addresslabel;
@property (nonatomic, strong) NSString *addressId;



@property (weak, nonatomic) IBOutlet UIImageView *addressImg;

@property (weak, nonatomic) IBOutlet UIButton *addressBtn;

@property (weak, nonatomic) IBOutlet UIButton *ADDBtn;

@property (nonatomic, assign)id <EditorAddressDelegate> delegate;


@end
