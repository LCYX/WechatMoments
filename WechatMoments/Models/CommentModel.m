//
//  CommentModel.m
//  WechatMoments
//
//  Created by chen guo on 2018/11/11.
//  Copyright © 2018年 chen guo. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
 
- (void)setCommentModel:(CommentModel *)model withDic_:(NSDictionary *)dic{
    if (dic[@"content"]!= nil && [dic[@"content"] length]>0) {
        _content = dic[@"content"];
    }
    
    if (dic[@"sender"][@"nick"]!=nil && [dic[@"sender"][@"nick"] length]>0) {
         _nick = dic[@"sender"][@"nick"];
    }
}

@end
