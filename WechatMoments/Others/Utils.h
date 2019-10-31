//
//  Utils.h
//  WechatMoments
//
//  Created by chen guo on 2018/11/10.
//  Copyright © 2018年 chen guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

- (void)image_webCache:(NSString *)urlStr placeholderImg_:(UIImage *)placeholderImg sender_:(id)sender;

/**
 获取单张图片的实际size
 
 @param singleSize 原始
 @return 结果
 */
+ (CGSize)getSingleSize:(CGSize)singleSize;

@end
