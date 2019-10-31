//
//  TweetsImgV.m
//  WechatMoments
//
//  Created by chen guo on 2018/11/11.
//  Copyright © 2018年 chen guo. All rights reserved.
//

#import "TweetsImgV.h"
#import "UIImageView+WebCache.h"

@interface TweetsImgV ()
// 图片视图数组
@property (nonatomic, strong) NSMutableArray *imageViewsArray;
@end

@implementation TweetsImgV

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 小图(九宫格)
        _imageViewsArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 9; i++) {
            MMImageView *imageView = [[MMImageView alloc] initWithFrame:CGRectZero];
            imageView.tag = 1000 + i;
            [_imageViewsArray addObject:imageView];
            [self addSubview:imageView];
        }
    }
    return self;
}

- (void)configTweetModel:(TweetModel *)model
{
    _tmodel = model;
    for (MMImageView *imageView in _imageViewsArray) {
        imageView.hidden = YES;
    }
    // 图片区
    NSInteger count = model.images.count;
    if (count == 0) {
        
        self.size = CGSizeZero;
        return;
    }
    // 添加图片
    MMImageView *imageView = nil;
    for (NSInteger i = 0; i < count; i++)
    {
        if (i > 8) {
            break;
        }
        NSInteger rowNum = i/3;
        NSInteger colNum = i%3;
        if(count == 4) {
            rowNum = i/2;
            colNum = i%2;
        }
        
        CGFloat imageX = colNum * (kImageWidth + kImagePadding);
        CGFloat imageY = rowNum * (kImageWidth + kImagePadding);
        CGRect frame = CGRectMake(imageX, imageY, kImageWidth, kImageWidth);
        
        //单张图片需计算实际显示size
        if (count == 1) {
            CGSize singleSize = [Utils getSingleSize:CGSizeMake(model.singleWidth, model.singleHeight)];
            frame = CGRectMake(0, 0, singleSize.width, singleSize.height);
        }
        imageView = [self viewWithTag:1000+i];
        imageView.hidden = NO;
        imageView.frame = frame;
        [imageView image_webCache:model.images[i][@"url"] placeholderImg_:[UIImage imageNamed:@"moment_head"]];
    }
    self.width = kTextWidth;
    self.height = imageView.bottom;
}

@end

@implementation MMImageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.clipsToBounds  = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.contentScaleFactor = [[UIScreen mainScreen] scale];
        self.userInteractionEnabled = YES;
    }
    return self;
}
@end

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


