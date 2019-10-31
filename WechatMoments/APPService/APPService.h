//
//  APPService.h
//  WechatMoments
//
//  Created by chen guo on 2018/11/9.
//  Copyright © 2018年 chen guo. All rights reserved.
//

#import <AFNetworking.h>
#import <Foundation/Foundation.h>

#define  REQUEST_SUCESS 0
#define  REQUEST_FAIL -1

// the url for dis
static const NSString *   url_dis = @"http://thoughtworks-ios.herokuapp.com";

//the url for dev
static const NSString *   url_dev = @"";

//get user info
typedef void(^getUserInfo)(id result,int ret);

//get tweets info
typedef void(^getTweetsInfo)(id result,int ret);

@interface APPService : NSObject

/*@function    getUserInfo_info:get user info
 *@param       paramDic:the param for request
 *@param       handle:return request result
 *@return      void
 */
- (void)getUserInfo_info:(NSDictionary *)paramDic handle_:(getUserInfo)handle;

/*@function    getTweetsInfo_info:get tweets info
 *@param       paramDic:the param for request
 *@param       handle:return request result
 *@return      void
 */
- (void)getTweetsInfo_info:(NSDictionary *)paramDic handle_:(getTweetsInfo)handle;

@end
