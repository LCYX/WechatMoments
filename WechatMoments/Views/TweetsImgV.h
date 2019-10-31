//
//  TweetsImgV.h
//  WechatMoments
//
//  Created by chen guo on 2018/11/11.
//  Copyright © 2018年 chen guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetModel.h"

@interface TweetsImgV : UIView
- (void)configTweetModel:(TweetModel *)model;
@property (nonatomic,strong) TweetModel *tmodel;
@end


@interface MMImageView : UIImageView
@end
