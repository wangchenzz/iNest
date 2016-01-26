//
//  BuyView.m
//  LeeNote
//
//  Created by administrator on 15/10/21.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import "BuyView.h"

@implementation BuyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init{

    self.likebutton.layer.cornerRadius = 40;
    
    self.likebutton.layer.borderWidth = 4.0;
    
    self.likebutton.layer.borderColor = [UIColor redColor].CGColor;
    
   // self.likebutton.clipsToBounds = YES;
    
    self.likebutton.layer.masksToBounds = YES;
    
    self.buybutton.layer.cornerRadius = 40;

    return self;
}


@end
