//
//  IntroduceCell.h
//  LeeNote
//
//  Created by administrator on 15/10/15.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroduceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsimage;
@property (weak, nonatomic) IBOutlet UILabel *namelable;

@property (weak, nonatomic) IBOutlet UILabel *pricelabel;
@property (weak, nonatomic) IBOutlet UILabel *introducelabel;

+(CGFloat)heigtwithlabelNSString:(NSString*)string andWideth:(CGFloat )width;


-(void)setLabelNsstirng:(NSString*)string;
@end
