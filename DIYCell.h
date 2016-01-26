//
//  DIYCell.h
//  LeeNote
//
//  Created by administrator on 15/10/13.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DIYCell : UITableViewCell

@property (nonatomic)  UIImageView *imagep;

@property (nonatomic)  UILabel *sclabel;

@property (nonatomic)  UILabel *jslabel;

@property (nonatomic) UILabel *numlabel;

@property (nonatomic) BOOL isLike;

@property (nonatomic) UIImageView *isLikeView;

@property (nonatomic,strong) UIImageView *blackimage;

@end
