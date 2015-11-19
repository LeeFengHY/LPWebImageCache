//
//  DownloadOperation.h
//  LPWebImageCache
//
//  Created by QFWangLP on 15/11/18.
//  Copyright © 2015年 QFWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

@interface DownloadOperation : NSOperation

/**
 *  提供一个创建操作对象的类方法
 *
 *  @param urlString
 *  @param block     回调一个UIImage对象
 *
 *  @return 线程
 */
+ (instancetype)initDownloadWithURL:(NSString *)urlString finishedBlock:(void(^)(UIImage *image))block;

@end
