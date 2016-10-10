//
//  HHStatusDetailVC.m
//  BlueToothGate
//
//  Created by JeroMac on 2016/9/28.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "HHStatusDetailVC.h"
#import "HHCircleCommentsCell.h"
#import "HHCircleModel.h"


extern BOOL isExercise;

@interface HHStatusDetailVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    HHCircleModel *_model;
    NSString *_tempReplyID;
    NSString *_tempSendID;
    BOOL _isReplyPerson;
    BOOL _isScrollToBottom;
}

@end

@implementation HHStatusDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    
    [self initTabView];
    
    [self getStatusDetail];
}

#pragma mark ---Data---======================================
- (void)setData{
    
    _imgDistance.constant = (ScreenW-300)/2;
    if (_contentStr) {
        self.contentHeight.constant = [self getStringRect_:_contentStr].height+10;
    }
    _headerView.frame = CGRectMake(_headerView.frame.origin.x, _headerView.frame.origin.y, _headerView.frame.size.width, _headerView.frame.size.height + [self getStringRect_:_contentStr].height-8);
    _labTime.adjustsFontSizeToFitWidth = YES;
    _model = [HHCircleModel new];
}

#pragma mark ---刷新数据---======================================
- (void)getStatusDetail{
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:@"0" forKey:@"currentPage"];
    [param setObject:_statusID forKey:@"id"];
    [[HYHttp sharedHYHttp]POST:CircleListUrl parameters:param success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        NSDictionary *obj = [responseObject objectForKey:@"obj"];
        NSArray *rows = [obj objectForKey:@"rows"];
        
        [_model setValuesForKeysWithDictionary:rows[0]];
        
        [_tableView reloadData];
        
        [self setUI];
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark ---UI---======================================
- (void)setUI{
    self.labName.text = [NSString stringWithFormat:@"%@",_model.title];
    self.labTime.text = [NSString stringWithFormat:@"%@",_model.addTime];
    self.labThing.text = [NSString stringWithFormat:@"%@",_model.contents];
    
    NSInteger likeCount = _model.favorAll.count;
    if (likeCount) {
        self.labLikeCount.text = [NSString stringWithFormat:@"%ld人",(long)likeCount];
    }
    
    NSMutableArray *nameArr = [NSMutableArray new];
    for (NSDictionary *dic in _model.favorAll) {
        [nameArr addObject:[dic objectForKey:@"trueName"]];
    }
    self.labLikeName.text = [nameArr componentsJoinedByString:@","];
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@",API_URL_BASE,_model.headPath,_model.headNsme]] placeholderImage:GetImage(@"placeholder")];
    
    NSArray *imageArr = [_model.imgs componentsSeparatedByString:@","];
    if (imageArr.count >= 3) {
        [self.contengImage_one sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",API_URL_BASE,@"app/load_app_imgFle.htm?imgId=",imageArr[0]]] placeholderImage:GetImage(@"placeholder")];
        [self.contentImage_two sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",API_URL_BASE,@"app/load_app_imgFle.htm?imgId=",imageArr[1]]] placeholderImage:GetImage(@"placeholder")];
        [self.contentImage_three sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",API_URL_BASE,@"app/load_app_imgFle.htm?imgId=",imageArr[2]]] placeholderImage:GetImage(@"placeholder")];
    }
    if (!_isScrollToBottom||_tableView.contentSize.height < ScreenH-114) {
        _isScrollToBottom = YES;
    }else{
        _tableView.contentOffset = CGPointMake(0, _tableView.contentSize.height-(ScreenH-114));
    }

}

#pragma mark ---initTab---======================================
- (void)initTabView{
    _tableView.delegate         = self;
    _tableView.dataSource       = self;
    _tableView.tableHeaderView  = _headerView;
    _tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HHCircleCommentsCell class]) bundle:nil] forCellReuseIdentifier:@"myCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.00001;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _model.listFavorsReply.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = _model.listFavorsReply[indexPath.row];
    CGFloat sendNameWidth = [self getStringRect_:[dic objectForKey:@"sendName"] andWidth:0 Height:20].width;
    CGFloat trueNameWidth = [self getStringRect_:[dic objectForKey:@"trueName"] andWidth:0 Height:20].width;
    CGFloat lab_height;
    
    if ([[dic objectForKey:@"type"] longValue] == 1) {
        lab_height = [self getStringRect_:[dic objectForKey:@"contents"] andWidth:ScreenW-95-sendNameWidth Height:0].height;
    }else{
        lab_height = [self getStringRect_:[dic objectForKey:@"contents"] andWidth:ScreenW-90-sendNameWidth-trueNameWidth-50 Height:0].height;
    }
    
    
    return  lab_height/15*16 +6;
//    return 90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HHCircleCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[HHCircleCommentsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    
    NSDictionary *dic = _model.listFavorsReply[indexPath.row];
    
    [cell setCellDataWithDic:dic];
    
    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
    [cell.btnSendName addTarget:self action:@selector(clickName:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnTrueName addTarget:self action:@selector(clickName:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kLog(@"%ld",(long)indexPath.section);
//    HHStatusDetailVC *nextVC = [HHStatusDetailVC new];
//    [self.navigationController pushViewController:nextVC animated:YES];
}

#pragma mark ---点击人名---======================================
- (void)clickName:(UIButton *)sender{
    _TFContnet.text = @"";
    _TFContnet.placeholder = [NSString stringWithFormat:@"回复%@",sender.titleLabel.text];
    NSString *idStr = [sender titleForState:UIControlStateSelected];
    NSArray *idArr = [idStr componentsSeparatedByString:@","];
    _tempSendID = idArr[0];
    _tempReplyID = idArr[1];
    _isReplyPerson = YES;
    
}

- (IBAction)backAction:(UIButton *)sender {
    isExercise = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ---评论---=====================================
- (IBAction)commentsAction:(UIButton *)sender {
    _TFContnet.text = @"";
    _TFContnet.placeholder = @"发表评论";
    _isReplyPerson = NO;
}

#pragma mark ---点赞---=====================================
- (IBAction)likeAction:(UIButton *)sender {
    kLog(@"点赞");
    NSArray *arr          = _model.favorAll;
    NSMutableArray *idArr = [NSMutableArray new];
    
    for (NSDictionary *dic in arr) {
        [idArr addObject:[dic objectForKey:@"clickFavor_id"]];
    }
    
    if ([idArr containsObject:[userDefault objectForKey:HHUser_info_userID]]) {
        [ShowMessage showTextOnly:@"你已经点过赞了" messageView:self.view];
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[userDefault objectForKey:HHUser_info_userID] forKey:@"userId"];
    [param setObject:_model.myID forKey:@"communityCircleId"];
    [[HYHttp sharedHYHttp]POST:SetLikeUrl parameters:param success:^(id  _Nonnull responseObject) {
        kLog(@"%@",responseObject);
        [self getStatusDetail];
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}

#pragma mark ---提交回复---=====================================
- (IBAction)makeComments:(UIButton *)sender {
    
    if (kStringIsEmpty(_TFContnet.text)) {
        [ShowMessage showTextOnly:@"请输入你要发表的内容" messageView:self.view];
        return;
    }
    
    if (_isReplyPerson) {
        NSMutableDictionary *param = [NSMutableDictionary new];
        [param setObject:_tempSendID forKey:@"userId"];
        [param setObject:_tempReplyID forKey:@"communityCircleReplyId"];
        [param setObject:[userDefault objectForKey:HHUser_info_userID] forKey:@"sendUserId"];
        [param setObject:_TFContnet.text forKey:@"contents"];
        [[HYHttp sharedHYHttp]POST:CommentReplyUrl parameters:param success:^(id  _Nonnull responseObject) {
            kLog(@"%@",responseObject);
            [self getStatusDetail];
            _TFContnet.text = @"";
        } failure:^(NSError * _Nonnull error) {
            [ShowMessage showTextOnly:@"回复失败，请重试" messageView:self.view];
        }];
    }else{
        NSMutableDictionary *param = [NSMutableDictionary new];
        [param setObject:[userDefault objectForKey:HHUser_info_userID] forKey:@"userId"];
        [param setObject:_model.myID forKey:@"communityCircleId"];
        [param setObject:_TFContnet.text forKey:@"contents"];
        [[HYHttp sharedHYHttp]POST:CircleCommentUrl parameters:param success:^(id  _Nonnull responseObject) {
            kLog(@"%@",responseObject);
            [self getStatusDetail];
            _TFContnet.text = @"";
            
        } failure:^(NSError * _Nonnull error) {
            [ShowMessage showTextOnly:@"回复失败，请重试" messageView:self.view];

        }];
    }
    
    
    
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark ---获取字符串的大小  ios6---======================================
- (CGSize)getStringRect_:(NSString*)aString
{
    CGSize size = CGSizeMake(ScreenW-90,2000); //设置一个行高上限
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
    CGSize labelsize = [aString boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return  labelsize;
}

#pragma mark ---获取字符串的大小cell专用---======================================
- (CGSize)getStringRect_:(NSString*)aString andWidth:(CGFloat )width Height:(CGFloat )height{
    if (width>0) {
        CGSize size = CGSizeMake(width,2000); //设置一个行高上限
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
        CGSize labelsize = [aString boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
        return  labelsize;
        
    }else{
        CGSize size = CGSizeMake(300,height); //设置一个宽度上限
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
        CGSize labelsize = [aString boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
        return  labelsize;
        
    }
}



@end
