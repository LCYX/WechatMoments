//
//  CommentModel.h
//  WechatMoments
//
//  Created by chen guo on 2018/11/11.
//  Copyright © 2018年 chen guo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CommentModel;
@interface CommentModel : NSObject
proStr(content)
proStr(nick)
- (void)setCommentModel:(CommentModel *)model withDic_:(NSDictionary *)dic;
@end
