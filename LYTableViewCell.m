//
//  LYTableViewCell.m
//  Liwushuo
//
//  Created by administrator on 15/10/23.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "LYTableViewCell.h"

@implementation LYTableViewCell

- (void)awakeFromNib {
    // Initialization code
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        

        self.image=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        
        self.name=[[UILabel alloc]initWithFrame:CGRectMake(90, 0, 130, 30)];
        
        [self.name setFont:[UIFont systemFontOfSize:14]];
        
        [self.name setTextColor:[UIColor blackColor]];
        
        self.pinglun=[[UILabel alloc]initWithFrame:CGRectMake(90, 25, 220, 60)];
        
        [self.pinglun setFont:[UIFont systemFontOfSize:15.0]];
        
        [self.pinglun setTextColor:[UIColor blackColor]];
        
        [self.pinglun setNumberOfLines:0];
        
        self.image.layer.cornerRadius = 25;
        self.image.layer.masksToBounds = YES;
        
        
        self.date=[[UILabel alloc]initWithFrame:CGRectMake(200, 0, 170, 30)];
        
        
           [self.date setFont:[UIFont systemFontOfSize:14]];
        [self.date setTextColor:[UIColor grayColor]];

        
        
        [self.contentView addSubview:self.image];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.pinglun];
        [self.contentView addSubview:self.date];
        
        
    }
    
    return self;

}

@end
