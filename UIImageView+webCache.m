//
//  UIImageView+webCache.m
//  LPWebImageCache
//
//  Created by QFWangLP on 15/11/18.
//  Copyright © 2015年 QFWang. All rights reserved.
//

#import "UIImageView+webCache.h"
#import <objc/runtime.h>
#import "DownloadOperationManger.h"

@implementation UIImageView (webCache)

const void *imageURLKEY = @"IMGURL";

- (NSString *)urlString
{
    return objc_getAssociatedObject(self, imageURLKEY);
}

/**
 *  原子线程安全-COPY属性
 *
 *  @param urlString 
 */
- (void)setUrlString:(NSString *)urlString
{
    return objc_setAssociatedObject(self, imageURLKEY, urlString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/**
 *  设置缓存照片-方法实现
 *
 *  @param urlString 图片Path
 */
- (void)lp_setImageWithURL:(NSString *)urlString
{
    //在不同的urlString,在重用的时候，cell中的img包含一个urlString,检查此urlString是否已下载，如果还在下载或者下载完了都取消
    DownloadOperationManger *manager = [DownloadOperationManger shareInstance];
    if (![urlString isEqualToString:self.urlString]){
        
        [manager cancelOperation:self.urlString];
        
        self.image = nil;
        
    }
    
    __weak typeof(self) weakSelf = self;
    [manager downloadImage:urlString finishBlock:^(UIImage *image) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.image = image;
    }];
  
    
}
@end
