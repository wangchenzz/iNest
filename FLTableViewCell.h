//
//  FLTableViewCell.h
//  Liwushuo
//
//  Created by administrator on 15/10/29.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *like;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *love;
@property (weak, nonatomic) IBOutlet UILabel *beijing;

@end
