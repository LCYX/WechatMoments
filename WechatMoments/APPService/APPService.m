//
//  APPService.m
//  WechatMoments
//
//  Created by chen guo on 2018/11/9.
//  Copyright © 2018年 chen guo. All rights reserved.
//

#import "APPService.h"
@interface APPService(){
    AFHTTPSessionManager *manager;
}
@end

@implementation APPService

- (instancetype)init{
    if (self = [super init]) {
        manager =[AFHTTPSessionManager manager];
        manager.securityPolicy.allowInvalidCertificates = YES;
        manager.securityPolicy.validatesDomainName = NO;
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}


- (void)getUserInfo_info:(NSDictionary *)paramDic handle_:(getUserInfo)handle{
    if (manager != nil) {
        [manager GET:[NSString stringWithFormat:@"%@/user/jsmith",url_dis] parameters:paramDic progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            id jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            handle(jsonDic,REQUEST_SUCESS);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            handle(nil,REQUEST_FAIL);
        }];
    }
    
}


- (void)getTweetsInfo_info:(NSDictionary *)paramDic handle_:(getTweetsInfo)handle{
    if (manager !=nil) {
        [manager GET:[NSString stringWithFormat:@"%@/user/jsmith/tweets",url_dis] parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            id jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            handle(jsonDic,REQUEST_SUCESS);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            handle(nil,REQUEST_FAIL);
        }];
    }
}


@end
