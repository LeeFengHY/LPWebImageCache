//
//  LPApp.h
//  LPWebImageCache
//
//  Created by QFWangLP on 15/11/18.
//  Copyright © 2015年 QFWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPApp : NSObject

//APP名字
@property (nonatomic, copy) NSString *name;

//APP头像
@property (nonatomic, copy) NSString *icon;

//APP下载次数
@property (nonatomic, copy) NSString *download;

//加载APP信息-从plist文件
+ (NSArray *)arrayApp;

- (instancetype) initWithDict:(NSDictionary *)dict;

@end
