//
//  AppableViewCell.h
//  LPWebImageCache
//
//  Created by QFWangLP on 15/11/18.
//  Copyright © 2015年 QFWang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LPApp;

@interface AppableViewCell : UITableViewCell

/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

/**
 *  app名字
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/**
 *  app下载次数
 */
@property (weak, nonatomic) IBOutlet UILabel *downloadLabel;

/**
 *  模型赋值
 */
@property (nonatomic, strong) LPApp *model;

/**
 *  复用标签
 *  @return indetifire
 */
+ (NSString *)cellIdentifire;

/**
 *  cell 高度
 *
 *  @return
 */
+ (CGFloat)cellDefaultHeight;

@end
