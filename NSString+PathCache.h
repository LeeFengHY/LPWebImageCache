//
//  NSString+PathCache.h
//  LPWebImageCache
//
//  Created by QFWangLP on 15/11/18.
//  Copyright © 2015年 QFWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PathCache)

//  追加文档目录
- (NSString *)appendDocumentPath;

//  追加缓存目录
- (NSString *)appendCachePath;

//  追加临时目录
- (NSString *)appendTempPath;

@end
