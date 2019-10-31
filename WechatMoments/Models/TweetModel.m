//
//  TweetModel.m
//  WechatMoments
//
//  Created by chen guo on 2018/11/9.
//  Copyright © 2018年 chen guo. All rights reserved.
//

#import "TweetModel.h"


@implementation TweetModel

- (void)setModel:(TweetModel *)model withDic_:(NSDictionary *)dic{
    if (dic[@"content"] !=nil && [dic[@"content"] length]>0) {
         _content = dic[@"content"];
    }
    
    if (dic[@"images"] != nil && [dic[@"images"] count]>0) {
        _images = dic[@"images"];
    }
    
    if (dic[@"sender"][@"avatar"]!=nil && [dic[@"sender"][@"avatar"] length]>0) {
        _avatar = dic[@"sender"][@"avatar"];
    }
    
    if (dic[@"sender"][@"nick"]!=nil && [dic[@"sender"][@"nick"] length]>0) {
        _nick = dic[@"sender"][@"nick"];
    }
    
    if (dic[@"comments"]!=nil && [dic[@"comments"] count]>0) {
        _comments = dic[@"comments"];
    }
    
}
@end
