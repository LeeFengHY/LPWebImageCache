
//
//  DownloadOperationManger.m
//  LPWebImageCache
//
//  Created by QFWangLP on 15/11/18.
//  Copyright © 2015年 QFWang. All rights reserved.
//

#import "DownloadOperationManger.h"
#import "NSString+PathCache.h"
#import "DownloadOperation.h"

@interface DownloadOperationManger ()

// 线程队列
@property (nonatomic, strong) NSOperationQueue *queue;

//缓存图片存储容器
@property (nonatomic, strong) NSMutableDictionary *cacheImage;

//缓存线程存储容器
@property (nonatomic, strong) NSMutableDictionary *cacheOperation;

@end

@implementation DownloadOperationManger

+ (instancetype)shareInstance
{
    static DownloadOperationManger *manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DownloadOperationManger alloc] init];
    });
    
    return manager;
}

/**
 *  下载操作
 *
 *  @param urlString 图片路径
 *  @param block     回调
 */
- (void)downloadImage:(NSString *)urlString finishBlock:(void(^)(UIImage *))block
{
    NSAssert(block != nil, @"回调代码必不可少");
    
    //检查是否有相同的操作存在
    if ([self.cacheOperation valueForKey:urlString] != nil) {
        //正缓存
        NSLog(@"正在加载中...🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲");
        return;
    }
    
    //检查缓存
    if ([self.cacheImage objectForKey:urlString]) {
        NSLog(@"从内存中读取!");
        //从内存中读取
        block([self.cacheImage objectForKey:urlString]);
        return;
    }
    else
    {
        //缓存中不存在的时候用placeholder image
        block([UIImage imageNamed:@"placeholder_image"]);
    }
    
    UIImage *img = [UIImage imageNamed:[urlString appendCachePath]];
    if (img) {
        //添加到内存缓存
        NSLog(@"从沙盒中读取!");
        [self.cacheImage setObject:img forKey:urlString];
        block(img);
        return;
    }
    
    //创建下载操作
    __weak typeof(self) weakSelf = self;
    DownloadOperation *Operation = [DownloadOperation initDownloadWithURL:urlString finishedBlock:^(UIImage *image) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        block(image);
        [strongSelf.cacheOperation removeObjectForKey:urlString];
    }];
    
    //将操作添加到缓冲池中
    [self.cacheOperation setObject:Operation forKey:urlString];
    
    //将操作添加到操作队列中
    [self.queue addOperation:Operation];
    
}

/**
 *  取消对应的下载图片-线程
 *
 *  @param urlString 取消对应的下载图片路径
 */
- (void)cancelOperation:(NSString *)urlString
{
    //当下载操作为空的时候，直接返回
    NSOperation *operation = [self.cacheOperation objectForKey:urlString];
    
    if (operation == nil) {
        NSLog(@"❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️操作已经被移除..........❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️");
        
        return;
    }
    
    [operation cancel];
    
    [self.cacheOperation removeObjectForKey:urlString];
}

#pragma mark - 懒加载
- (NSOperationQueue *)queue
{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        //设置最大操作队列
        [_queue setMaxConcurrentOperationCount:6];
    }
    return _queue;
}

- (NSMutableDictionary *)cacheImage
{
    if (!_cacheImage) {
        _cacheImage = [[NSMutableDictionary alloc] init];
    }
    return _cacheImage;
}

- (NSMutableDictionary *)cacheOperation
{
    if (!_cacheOperation) {
        _cacheOperation = [[NSMutableDictionary alloc] init];
    }
    return _cacheOperation;
}
@end
