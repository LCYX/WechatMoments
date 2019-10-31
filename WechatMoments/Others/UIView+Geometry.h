//
//  Utils.h
//  WechatMoments
//
//  Created by chen guo on 2018/11/10.
//  Copyright © 2018年 chen guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Geometry)

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGPoint origin;
@property CGSize size;

@property CGFloat height;
@property CGFloat width;
@property CGFloat top;
@property CGFloat left;
@property CGFloat bottom;
@property CGFloat right;

@end
