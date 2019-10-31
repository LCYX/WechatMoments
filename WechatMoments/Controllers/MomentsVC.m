//
//  Moments.m
//  WechatMoments
//
//  Created by chen guo on 2018/11/10.
//  Copyright © 2018年 chen guo. All rights reserved.
//

#import "MomentsVC.h"
#import "APPService.h"
#import "TweetCell.h"
#import "PersonModel.h"
#import "TweetModel.h"
#import "UIImageView+WebCache.h"

static NSString *reuseID= @"cellID";

@interface MomentsVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    __weak IBOutlet UIImageView *PersonImgV;
    __weak IBOutlet UIImageView *AvatarImgV;
    __weak IBOutlet UILabel *NickL;
    
}

@property (nonatomic,strong) NSMutableArray *TweetsArrM;
@property (nonatomic,strong) NSMutableArray *personInfoArrM;
@property(nonatomic,strong)NSMutableArray * load_New_More_ArrM;
@end

@implementation MomentsVC

//init TweetsArrM
- (NSMutableArray *)TweetsArrM{
    if (_TweetsArrM == nil) {
        _TweetsArrM = [NSMutableArray array];
    }
    return _TweetsArrM;
}

// init personInfoArrM
- (NSMutableArray *)personInfoArrM{
    if (_personInfoArrM == nil) {
        _personInfoArrM = [NSMutableArray array];
    }
    return _personInfoArrM;
}

//init load_New_More_ArrM
- (NSMutableArray *)load_New_More_ArrM{
    if (_load_New_More_ArrM == nil) {
        _load_New_More_ArrM = [NSMutableArray array];
    }
    return _load_New_More_ArrM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //config UI
    [self configUI];
    
    //load data
    
     [self loadData];
}

#pragma mark - configUI
- (void)configUI{
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:reuseID];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.tableFooterView = [UIView new];
    
    __weak __typeof(self) weakSelf = self;
    //refresh
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
        [self.tableView reloadData];
    }];
    
    
    //load more
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
        [self.tableView reloadData];
    }];
}


#pragma mark - loadMoreData
- (void)loadMoreData{
    //Show 5 more while user pulling up the view at the bottom of table view.
    self.load_New_More_ArrM =(NSMutableArray *) [self.TweetsArrM subarrayWithRange:NSMakeRange(0, 10)];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - loadNewData
- (void)loadNewData{
    //Pulling down tableview to refresh, only first 5 items are shown after refreshing
    self.load_New_More_ArrM = (NSMutableArray *) [self.TweetsArrM subarrayWithRange:NSMakeRange(0, 5)];
    [self.tableView.mj_header endRefreshing];
}


#pragma mark - loadData
- (void)loadData{
    //获取用户图像
    APPService * PersonSerive = [[APPService alloc]init];
    [PersonSerive getUserInfo_info:nil handle_:^(id result, int ret) {
        if (ret == REQUEST_SUCESS) {
            PersonModel *pModel = [PersonModel new];
            [pModel setValuesForKeysWithDictionary:result];
            [self.personInfoArrM addObject:pModel];
            [self updateUI];
        }else{
            //网络请求错误
            if (@available(iOS 8.0, *)) {
                UIAlertController *alt = [UIAlertController  alertControllerWithTitle:@"提示" message:@"网络连接错误，请检测网络!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alt addAction:action];
                [self presentViewController:alt animated:YES completion:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            } else {
                UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接失败,请检测网络！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alt show];
            }
        }
    }];
    
    //get very tweet
    APPService *tweetService = [APPService new];
    [tweetService getTweetsInfo_info:nil handle_:^(id result, int ret) {
        if (ret == REQUEST_SUCESS) {
            
            for (NSDictionary * tweetDic in result){
                //数据处理"ignore the tweet which does not contain a content and images"
                if ([tweetDic valueForKey:@"content"] !=nil | [tweetDic valueForKey:@"images"] !=nil) {
                     TweetModel *tModel = [TweetModel new];
                    
                    //如果是单张图片需要设置宽、高
                    if ([[tweetDic valueForKey:@"images"] count] == 1) {
                        tModel.singleWidth = 500;
                        tModel.singleHeight = 315;
                    }
                    
                    
                    [tModel setModel:tModel withDic_:tweetDic];
                    [self.TweetsArrM addObject:tModel];
                }
            }
            
            //Load all tweets in memory at first time and only show first 5 of them at the beginning and after refresh.
            self.load_New_More_ArrM  = (NSMutableArray *)[self.TweetsArrM subarrayWithRange:NSMakeRange(0, 5)];
            [self.tableView reloadData];
        
        }else{
            //网络请求错误
            if (@available(iOS 8.0, *)) {
                UIAlertController *alt = [UIAlertController  alertControllerWithTitle:@"提示" message:@"网络连接错误，请检测网络!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alt addAction:action];
                [self presentViewController:alt animated:YES completion:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            } else {
                UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接失败,请检测网络！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alt show];
            }
        }
    }];
}

#pragma mark - updateUI
- (void)updateUI{
    
    PersonModel *pModel = [self.personInfoArrM firstObject];
    PersonImgV.image = [UIImage imageNamed:@"moment_cover"];
    AvatarImgV.backgroundColor = [UIColor clearColor];
    AvatarImgV.layer.borderColor = [[UIColor whiteColor] CGColor];
    AvatarImgV.layer.borderWidth = 2;
    //图片缓存
    [AvatarImgV image_webCache:pModel.avatar placeholderImg_:[UIImage imageNamed:@"moment_head"]];
    NickL.text = [[_personInfoArrM firstObject] nick];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.load_New_More_ArrM.count;
}


#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TweetModel *model = [self.load_New_More_ArrM objectAtIndex:indexPath.row];
    return model.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
     //config cell
    [cell configCell_model:self.load_New_More_ArrM [indexPath.row]];
    return cell;
}

#pragma mark -
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
