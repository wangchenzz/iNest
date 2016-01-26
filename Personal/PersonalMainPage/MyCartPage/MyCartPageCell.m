//
//  MyCartPageCell.m
//  Personal
//
//  Created by 薛立恒 on 15/10/21.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "MyCartPageCell.h"

@implementation MyCartPageCell

- (instancetype)init {
//    self.isSelected = NO;
    self.tickImage.layer.cornerRadius = 11.0;
    self.tickImage.clipsToBounds = YES;
    return self;
    
}



@end
