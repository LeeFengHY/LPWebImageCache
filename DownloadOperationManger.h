//
//  DownloadOperationManger.h
//  LPWebImageCache
//
//  Created by QFWangLP on 15/11/18.
//  Copyright © 2015年 QFWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

@interface DownloadOperationManger : NSObject

+ (instancetype)shareInstance;

/**
 *  下载操作
 *
 *  @param urlString 图片路径
 *  @param block     回调
 */
- (void)downloadImage:(NSString *)urlString finishBlock:(void(^)(UIImage *image))block;

/**
 *  取消对应的下载图片-线程
 *
 *  @param urlString 取消对应的下载图片路径
 */
- (void)cancelOperation:(NSString *)urlString;

@end
