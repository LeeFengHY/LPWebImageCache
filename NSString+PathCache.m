
//
//  NSString+PathCache.m
//  LPWebImageCache
//
//  Created by QFWangLP on 15/11/18.
//  Copyright © 2015年 QFWang. All rights reserved.
//

#import "NSString+PathCache.h"

@implementation NSString (PathCache)

//  追加文档目录
- (NSString *)appendDocumentPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:self.lastPathComponent];
}

//  追加缓存目录
- (NSString *)appendCachePath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:self.lastPathComponent];
}

//  追加临时目录
- (NSString *)appendTempPath
{
    return [NSTemporaryDirectory() stringByAppendingPathComponent:self.lastPathComponent];
}

@end
