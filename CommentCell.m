//
//  CommentCell.m
//  LeeNote
//
//  Created by administrator on 15/10/20.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
    
        self.headimage = [[UIImageView alloc]initWithFrame:CGRectMake(17, 8, 27, 27)];
        
        self.headimage.layer.cornerRadius = 12;
        
        self.headimage.clipsToBounds = YES;
        
        self.namelabel = [[UILabel alloc]initWithFrame:CGRectMake(52, 3, 102, 16)];
        
        self.datalabel = [[UILabel alloc]initWithFrame:CGRectMake(238, 3, 70, 13)];
        
        self.conmmentlabel = [[UILabel alloc]initWithFrame:CGRectMake(52, 20, 251, 19)];
        
        [self.datalabel setTextColor:[UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1]];
        
        [self.conmmentlabel setTextColor:[UIColor colorWithRed:90/255.0 green:88/255.0 blue:89/255.0 alpha:1]];
        
        self.namelabel.font = [UIFont systemFontOfSize:12];
        
        self.datalabel.font = [UIFont systemFontOfSize:11];
        
        self.conmmentlabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.headimage];
        
        [self.contentView addSubview:self.datalabel];
        
        [self.contentView addSubview:self.namelabel];
        
        [self.contentView addSubview:self.conmmentlabel];
    }
    
    return self;

}
@end
