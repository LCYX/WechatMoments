//
//  Utils.m
//  WechatMoments
//
//  Created by chen guo on 2018/11/10.
//  Copyright © 2018年 chen guo. All rights reserved.
//

#import "Utils.h"
@interface Utils()
@property (nonatomic,strong) NSMutableDictionary *imageDicM;
@property (nonatomic,strong) NSMutableDictionary *operationDicM;
@property (nonatomic,strong) NSOperationQueue *queue;
@end



@implementation Utils

- (NSMutableDictionary *)imageDicM{
    if (_imageDicM == nil) {
        _imageDicM = [NSMutableDictionary dictionary];
    }
    return _imageDicM;
}

- (NSMutableDictionary *)operationDics
{
    
    if (_operationDicM == nil) {
        _operationDicM= [[NSMutableDictionary alloc] init];
        
    }
    return _operationDicM;
}

- (NSOperationQueue *)queue
{
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 5 ;
    }
    return _queue;
}

- (void)image_webCache:(NSString *)urlStr placeholderImg_:(UIImage *)placeholderImg sender_:(id)sender{
     UIImageView * imgV = (UIImageView *)sender;
     UIImage * Img = self.imageDicM[urlStr];
    if (Img) {
        imgV.image = Img;
    }else{
        NSString *caches= [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        NSString *fileName = [urlStr lastPathComponent];
        NSString *fullPath = [caches  stringByAppendingPathComponent:fileName];
        NSData *imageData =[NSData dataWithContentsOfFile:fullPath];
        if (imageData) {
            UIImage *image= [UIImage imageWithData:imageData];
            imgV.image = image;
            [self.imageDicM setValue:image forKey:urlStr];
            
        }else{
            NSBlockOperation *opration = self.operationDicM[urlStr];
            if (opration) {
                
            }else{
               
               imgV.image = placeholderImg;
                NSBlockOperation *downOperation = [NSBlockOperation blockOperationWithBlock:^{
                    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
                    UIImage *image = [UIImage imageWithData:imageData];
                    NSLog(@"download -----%@",[NSThread currentThread]);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        imgV.image = image;
                    });
                    if (image == nil) {
                        //操作缓存移除
                        [self.operationDicM removeObjectForKey:urlStr];
                        return ;
                    }
                    [self.imageDicM setObject:image forKey:urlStr];
                    
                    [imageData writeToFile:fullPath atomically:YES];
                    [self.operationDicM removeObjectForKey:urlStr];
                }];
                
                [self.operationDicM setObject:downOperation forKey:urlStr];
                [self.queue addOperation:downOperation];
            }
        }
    }
}

#pragma mark - 获取单张图片的实际size
+ (CGSize)getSingleSize:(CGSize)singleSize
{
    CGFloat max_width = screen_width - 150;
    CGFloat max_height = screen_width - 130;
    CGFloat image_width = singleSize.width;
    CGFloat image_height = singleSize.height;
    
    CGFloat result_width = 0;
    CGFloat result_height = 0;
    if (image_height/image_width > 3.0) {
        result_height = max_height;
        result_width = result_height/2;
    }  else  {
        result_width = max_width;
        result_height = max_width*image_height/image_width;
        if (result_height > max_height) {
            result_height = max_height;
            result_width = max_height*image_width/image_height;
        }
    }
    return CGSizeMake(result_width, result_height);
}
@end
