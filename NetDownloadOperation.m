//
//  NetDownloadOperation.m
//  LPWebImageCache
//
//  Created by QFWangLP on 15/11/18.
//  Copyright © 2015年 QFWang. All rights reserved.
//

#import "NetDownloadOperation.h"
#import "NSString+PathCache.h"

@interface NetDownloadOperation ()<NSURLSessionDelegate>

@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSMutableDictionary *cacheImage;
@property (nonatomic, strong) NSMutableDictionary *cacheOperation;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionConfiguration *config;


@end

@implementation NetDownloadOperation

- (void)lp_netDownloadImage:(NSString *)urlString finishBlock:(void(^)(UIImage *image))block
{
    //检查是否有重复下载操作
    if (self.cacheOperation[urlString]) {
        NSLog(@"正在下载中...");
        return;
    }
#if 0
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    NSURLSessionConfiguration *backgroundConfigObject = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier: @"myBackgroundSessionIdentifier"];
    NSURLSession  *backgroundSession = [NSURLSession sessionWithConfiguration: backgroundConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSURLSessionDownloadTask *downloadTask = [backgroundSession downloadTaskWithRequest:request]; //下载任务
#endif
    //创建下载操作,需要防止循环引用
    __weak typeof(self) weakSelf = self;
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        //网络下载资源(或本地读取照片)
        NSURL *url = [NSURL URLWithString:[urlString appendCachePath]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        [NSThread  sleepForTimeInterval:3.0];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //下载完成移除下载操作
            [weakSelf.cacheOperation removeObjectForKey:urlString];
            
            //设置图片缓存
            [weakSelf.cacheImage setObject:[UIImage imageWithData:data] forKey:urlString];
            //完成回调
            block([UIImage imageWithData:data]);
        }];
       
    }];

     //1.1   将操作添加到操作缓冲池中
    [self.cacheOperation setObject:operation forKey:urlString];
    
    //1.2   将操作添加到队列中
    [self.queue addOperation:operation];
}

#pragma makr --懒加载
- (NSOperationQueue *)queue
{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        [_queue setMaxConcurrentOperationCount:6];
    }
    return _queue;
}

- (NSMutableDictionary *)cacheImage
{
    if (_cacheImage) {
        _cacheImage = [[NSMutableDictionary alloc] init];
    }
    return _cacheImage;
}

- (NSMutableDictionary *)cacheOperation
{
    if (_cacheOperation) {
        _cacheOperation = [[NSMutableDictionary alloc] init];
    }
    return _cacheOperation;
}
@end
