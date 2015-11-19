//
//  LPApp.m
//  LPWebImageCache
//
//  Created by QFWangLP on 15/11/18.
//  Copyright © 2015年 QFWang. All rights reserved.
//

#import "LPApp.h"

@implementation LPApp

+ (NSArray *)arrayApp
{
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"apps" withExtension:@"plist"];
    
    NSArray * array = [NSArray arrayWithContentsOfURL:path];
    
    //断言，当array.count != 0 时才会放行
    NSAssert(array.count != 0, @"AppModel 数据不能为空");
    NSMutableArray *dataArr = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LPApp *app = [[LPApp alloc] initWithDict:obj];
        [dataArr addObject:app];
    }];
    return dataArr;
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
