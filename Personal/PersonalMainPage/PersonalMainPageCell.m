//
//  PersonalMainPageCell.m
//  Personal
//
//  Created by 薛立恒 on 15/10/13.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "PersonalMainPageCell.h"

@implementation PersonalMainPageCell

- (void)awakeFromNib {

    
    //设置图片的圆角
    self.MainCellImage.layer.cornerRadius = 30;
    self.MainCellImage.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
