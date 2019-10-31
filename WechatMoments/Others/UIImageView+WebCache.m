//
//  UIImageView+ImgV_WebCache.m
//  testC
//
//  Created by chen guo on 2018/11/10.
//  Copyright © 2018年 chen guo. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "Utils.h"

 

@implementation UIImageView (WebCache)

- (void)image_webCache:(NSString *)urlStr placeholderImg_:(UIImage *)placeholderImg{
    Utils * util = [Utils new];
    [util image_webCache:urlStr placeholderImg_:placeholderImg sender_:self];
}

@end
