//
//  PersonModel.m
//  WechatMoments
//
//  Created by chen guo on 2018/11/9.
//  Copyright © 2018年 chen guo. All rights reserved.
//

#import "PersonModel.h"

@implementation PersonModel

//set value for Undefined Key
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"profile-image"]) {
        _profile_image = value;
    }
}
@end
