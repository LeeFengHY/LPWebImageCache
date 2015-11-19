//
//  NetDownloadOperation.h
//  LPWebImageCache
//
//  Created by QFWangLP on 15/11/18.
//  Copyright © 2015年 QFWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

@interface NetDownloadOperation : NSObject

- (void)lp_netDownloadImage:(NSString *)urlString finishBlock:(void(^)(UIImage *image))block;

@end
