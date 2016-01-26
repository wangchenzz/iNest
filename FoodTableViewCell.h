//
//  FoodTableViewCell.h
//  Liwushuo
//
//  Created by administrator on 15/10/14.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *beijing;

@property(nonatomic,weak) IBOutlet UILabel*likecout;


@property(nonatomic,weak) IBOutlet UIImageView*like;


@property (weak, nonatomic) IBOutlet UILabel *miaoshu;
@property (weak, nonatomic) IBOutlet UIImageView *tuceng;

@end
