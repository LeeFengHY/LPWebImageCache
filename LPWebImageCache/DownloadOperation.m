//
//  DownloadOperation.m
//  LPWebImageCache
//
//  Created by QFWangLP on 15/11/18.
//  Copyright © 2015年 QFWang. All rights reserved.
//

#import "DownloadOperation.h"
#import "NSString+PathCache.h"

@interface DownloadOperation ()

/**
 *  url
 */
@property (nonatomic, copy) NSString *urlString;

/**
 *  完成的回调
 */
@property (nonatomic, copy) void(^finishBlock)(UIImage *image);

@end

@implementation DownloadOperation

/**
 *  提供一个创建操作对象的类方法
 *
 *  @param urlString
 *  @param block     回调一个UIImage对象
 *
 *  @return 线程
 */
+ (instancetype)initDownloadWithURL:(NSString *)urlString finishedBlock:(void(^)(UIImage *image))block
{
    NSAssert(block != nil, @"没回调函数");
    DownloadOperation *operation = [[DownloadOperation alloc] init]; //开启star
    operation.urlString = urlString;
    operation.finishBlock = block;
    return operation;
}

- (void)main
{
    @autoreleasepool {
         NSLog(@"😄😄😄😄😄😄😄执行%@----->当前任务的线程是----%@",self.urlString,[NSThread currentThread]);
        
        //耗时操作
        NSURL *url = [NSURL URLWithString:_urlString];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        //写入文件
        [data writeToFile:[_urlString appendCachePath] atomically:YES];
        
        //如果耗时操作还没有完成，但是用户取消了操作
        if ([self isCancelled]) {
            NSLog(@"💰💰💰💰💰💰💰💰用户取消了操作，无需回调.....💰💰💰💰💰💰💰💰");
            
            return;
        }
        
        //完成回调--主线程回调
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{

            self.finishBlock([UIImage imageWithData:data]);
            
        }];;
        
    }
}

@end
