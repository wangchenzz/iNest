//
//  FoodTableViewCell.m
//  Liwushuo
//
//  Created by administrator on 15/10/14.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "FoodTableViewCell.h"

@implementation FoodTableViewCell

- (void)awakeFromNib {
    // Initialization code
//    self.like.layer.cornerRadius = 9;
//    self.like.clipsToBounds = YES;
//    self.like.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:0.95];
//    self.like.textAlignment = NSTextAlignmentCenter;
    
    
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    
   if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
       
       self.likecout =[[UILabel alloc]initWithFrame:CGRectMake(266, 8, 100, 21)];
       [self.likecout setTextColor:[UIColor redColor]];
       
       

       self.like=[[UIImageView alloc]initWithFrame:CGRectMake(250, 11, 15, 15)];
       
        [self.contentView addSubview:self.like];
       [self.contentView addSubview:self.likecout];
    }
 


    return self;
    

}

@end
