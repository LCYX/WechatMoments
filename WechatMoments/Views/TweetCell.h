//
//  TweetCell.h
//  WechatMoments
//
//  Created by chen guo on 2018/11/9.
//  Copyright © 2018年 chen guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetsImgV.h"
#import "CommentModel.h"
#import "TweetModel.h"

@interface TweetCell : UITableViewCell<MLLinkLabelDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avatarL;
@property (weak, nonatomic) IBOutlet UILabel *nickL;
@property (nonatomic, strong) MLLinkLabel *contentLabel;
@property (nonatomic, strong) TweetsImgV *imagesV;
@property (nonatomic, strong) UIView *commentView;
@property (nonatomic, strong) UIImageView *bgImageView;
@property(nonatomic,strong)TweetModel *tmodel;
- (void)configCell_model:(TweetModel *)model;

@end

@interface CommentLabel : UIView <MLLinkLabelDelegate>
// 内容Label
@property (nonatomic,strong) MLLinkLabel *linkLabel;
// 评论
@property (nonatomic,strong) CommentModel *comment;
@end
