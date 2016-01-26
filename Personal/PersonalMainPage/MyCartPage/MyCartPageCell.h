//
//  MyCartPageCell.h
//  Personal
//
//  Created by 薛立恒 on 15/10/21.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCartPageCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cartImage;
@property (weak, nonatomic) IBOutlet UILabel *cartNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cartPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *cartLikeCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tickImage;
@property (nonatomic, assign) BOOL isSelected;
@end
