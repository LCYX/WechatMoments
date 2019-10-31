//
//  TweetModel.h
//  WechatMoments
//
//  Created by chen guo on 2018/11/9.
//  Copyright © 2018年 chen guo. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TweetModel : NSObject

proStr(content);
proArr(images);
proArr(comments);
proStr(nick);
proStr(avatar);

//the height for cell
@property (nonatomic,assign) CGFloat rowHeight;
// 单张图片的宽度
@property (nonatomic,assign) CGFloat singleWidth;
// 单张图片的高度
@property (nonatomic,assign) CGFloat singleHeight;

- (void)setModel:(TweetModel *)model withDic_:(NSDictionary *)dic;
@end
