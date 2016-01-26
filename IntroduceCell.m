//
//  IntroduceCell.m
//  LeeNote
//
//  Created by administrator on 15/10/15.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import "IntroduceCell.h"

@implementation IntroduceCell

- (void)awakeFromNib {
// Initialization code
    
// self.goodsimage.contentMode = UIViewContentModeScaleAspectFit;
    
// self.goodsimage.clipsToBounds = YES;
    

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    
    [super layoutSubviews];

    CGRect frame = self.introducelabel.frame;
    
   // if (iphone5) {
        
    frame.size.height = [IntroduceCell heigtwithlabelNSString:self.introducelabel.text andWideth:304];
    
    //}
 
    [self.introducelabel setFrame:frame];
    
}

-(void)setLabelNsstirng:(NSString*)string{
 
    
    self.introducelabel.text = string;
    
   // [self setNeedsLayout];
    

}


+(CGFloat)heigtwithlabelNSString:(NSString*)string andWideth:(CGFloat )width{
    CGRect rect = [string boundingRectWithSize:(CGSize){width,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    
    return rect.size.height;
}


@end
