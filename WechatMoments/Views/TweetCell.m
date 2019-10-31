//
//  TweetCell.m
//  WechatMoments
//
//  Created by chen guo on 2018/11/9.
//  Copyright © 2018年 chen guo. All rights reserved.
//

#import "TweetCell.h"
#import "TweetsImgV.h"


@implementation TweetCell

- (void)configCell_model:(TweetModel *)model{
    //avatar
    [_avatarL image_webCache:model.avatar placeholderImg_:[UIImage imageNamed:@"moment_head"]];
    
    //nick label
    _nickL.text = model.nick;
    
    //contentLabel
    _contentLabel.text =model.content;
    CGFloat bottom = CGRectGetMaxY(_nickL.frame) + kPaddingValue;
    CGSize attrStrSize = [_contentLabel preferredSizeWithMaxWidth:screen_width-_avatarL.frame.size.width -20];
    CGFloat labH = attrStrSize.height;
     _contentLabel.frame = CGRectMake(_nickL.frame.origin.x, bottom, attrStrSize.width, labH);
    bottom = _contentLabel.bottom + kPaddingValue;
    
    //images
    [_imagesV configTweetModel:model];
    if (model.images.count > 0) {
        _imagesV.origin = CGPointMake(_nickL.frame.origin.x, bottom);
        bottom = CGRectGetMaxY(_imagesV.frame) + kPaddingValue;
    }
    
    //comments
     _commentView.frame = CGRectZero;
    _bgImageView.frame = CGRectZero;
    _bgImageView.image = nil;
    [_commentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat top = 0;
    CGFloat width = screen_width-kRightMargin-_nickL.left;
    NSInteger count = [model.comments count];
    NSMutableArray * commentsArrM = [NSMutableArray array];
    for (int i = 0; i<count; i++) {
        CommentModel *cmodel = [CommentModel new];
        [cmodel setCommentModel:cmodel withDic_:model.comments[i]];
        [commentsArrM addObject:cmodel];
    }
    
    if (count > 0) {
        for (NSInteger i = 0; i < count; i ++) {
            CommentLabel *label = [[CommentLabel alloc] initWithFrame:CGRectMake(0, top, width, 0)];
            label.comment = [commentsArrM objectAtIndex:i];
            [_commentView addSubview:label];
            // 更新
            top += label.height;
        }
    }
    // 更新UI
     CGFloat rowHeight = 0;
    if (top > 0) {
        _bgImageView.frame = CGRectMake(_nickL.left, bottom, width, top + kArrowHeight);
        _bgImageView.image = [[UIImage imageNamed:@"comment_bg"] stretchableImageWithLeftCapWidth:40 topCapHeight:30];
        _commentView.frame = CGRectMake(_nickL.left, bottom + kArrowHeight, width, top);
        rowHeight = _commentView.bottom + kBlank;
    } else {
        rowHeight = _imagesV.bottom + kBlank;
    }
    
    // 这样做就是起到缓存行高的作用，省去重复计算
    _tmodel = model;
    _tmodel.rowHeight = rowHeight;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    //contentLabel
    _contentLabel= [MLLinkLabel new];
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.font = [UIFont systemFontOfSize:14.0];
    _contentLabel.numberOfLines = 0;
    _contentLabel.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.28 green:0.35 blue:0.54 alpha:1.0]};
    _contentLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.28 green:0.35 blue:0.54 alpha:1.0],NSBackgroundColorAttributeName:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]};
    _contentLabel.activeLinkToNilDelay = 0.3;
    //    _contentLabel.delegate = self;
    [self.contentView addSubview:_contentLabel];
    
    //images
    _imagesV = [[TweetsImgV alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_imagesV];
    
    // 评论视图
    _bgImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_bgImageView];
    
    //commentView
    _commentView = [[UIView alloc] init];
    [self.contentView addSubview:_commentView];

}

@end

@implementation CommentLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _linkLabel = [MLLinkLabel new];
        _linkLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _linkLabel.textColor = [UIColor blackColor];
        _linkLabel.font = kComTextFont;
        _linkLabel.numberOfLines = 0;
        _linkLabel.linkTextAttributes = @{NSForegroundColorAttributeName:kHLTextColor};
        _linkLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName:kHLTextColor,NSBackgroundColorAttributeName:kHLBgColor};
        _linkLabel.activeLinkToNilDelay = 0.3;
        [self addSubview:_linkLabel];
    }
    return self;
}

#pragma mark - Setter
- (void)setComment:(CommentModel *)comment
{
    _comment = comment;
    NSMutableAttributedString *attributedText = nil;
  

    NSString *likeString  = [NSString stringWithFormat:@"%@：%@",comment.nick,comment.content];
        attributedText = [[NSMutableAttributedString alloc] initWithString:likeString];
    [attributedText setAttributes:@{NSFontAttributeName:kComHLTextFont,NSLinkAttributeName:comment.nick}
                                range:[likeString rangeOfString:comment.nick]];
    
    _linkLabel.attributedText = attributedText;
    CGSize attrStrSize = [_linkLabel preferredSizeWithMaxWidth:kTextWidth];
    _linkLabel.frame = CGRectMake(5, 3, attrStrSize.width, attrStrSize.height);
    self.height = attrStrSize.height + 5;
}


@end
