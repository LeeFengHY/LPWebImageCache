//
//  UIImageView+webCache.h
//  LPWebImageCache
//
//  Created by QFWangLP on 15/11/18.
//  Copyright © 2015年 QFWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (webCache)

@property (nonatomic, copy) NSString *urlString;

/**
 *  设置缓存照片
 *
 *  @param urlString 图片Path
 */
- (void)lp_setImageWithURL:(NSString *)urlString;

@end
