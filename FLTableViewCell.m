//
//  FLTableViewCell.m
//  Liwushuo
//
//  Created by administrator on 15/10/29.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "FLTableViewCell.h"

@implementation FLTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.like.layer.cornerRadius = 6;
    self.like.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
