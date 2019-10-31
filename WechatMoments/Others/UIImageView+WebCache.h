//
//  UIImageView+ImgV_WebCache.h
//  testC
//
//  Created by chen guo on 2018/11/10.
//  Copyright © 2018年 chen guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebCache)
/*@function image_webCache
 *@param urlStr
 *@param placeholderImg
 *@return void
 */
- (void)image_webCache:(NSString *)urlStr placeholderImg_:(UIImage *)placeholderImg;
@end
