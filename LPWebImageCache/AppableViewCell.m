//
//  AppableViewCell.m
//  LPWebImageCache
//
//  Created by QFWangLP on 15/11/18.
//  Copyright © 2015年 QFWang. All rights reserved.
//

#import "AppableViewCell.h"
#import "UIImageView+webCache.h"
#import "LPApp.h"

@implementation AppableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 *  复用标签
 *  @return indetifire
 */
+ (NSString *)cellIdentifire
{
    return @"AppableViewCell";
}

/**
 *  cell 高度
 *
 *  @return
 */
+ (CGFloat)cellDefaultHeight
{
    return 50.0f;
}

- (void)setModel:(LPApp *)model
{
    _model = model;
    self.nameLabel.text = _model.name;
    self.downloadLabel.text = _model.download;
    [self.iconImage lp_setImageWithURL:_model.icon];
    
}
@end
