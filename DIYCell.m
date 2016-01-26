//
//  DIYCell.m
//  LeeNote
//
//  Created by administrator on 15/10/13.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import "DIYCell.h"

#define SCRREN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCRREN_HEIGHT [[UIScreen mainScreen] bounds].size.height
@implementation DIYCell

- (void)awakeFromNib {
  

    
    // [self.jslabel setBackgroundColor:[UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:0.4]];
    
    //NSDictionary *dict1 = NSDictionaryOfVariableBindings(_isLikeView,_sclabel,_numlabel,_imagep,_jslabel,_blackimage);
   // NSDictionary *metrics = @{@"hPadding":@0,@"vPadding":@5,@"imageEdge":@150.0};
 //   NSString *vfl = @"|-hPadding-[_blackimageV]-hPadding-|";
   // NSString *vfl0 = @"V:|-[_blackimage]-|";
  //  NSString *vfl3 = @"V:|-vPadding-[_headerL]-vPadding-[_imageV(imageEdge)]-vPadding-[_backBtn]-vPadding-|";
    
   // [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl0 options:0 metrics:metrics views:dict1]];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
   

   
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.isLikeView = [[UIImageView alloc]initWithFrame:CGRectMake(250, 11, 15, 15)];
        
        self.sclabel = [[UILabel alloc]initWithFrame:CGRectMake(244, 8, 59, 21)];
        
        self.numlabel = [[UILabel alloc]initWithFrame:CGRectMake(266, 8, 45, 21)];
    
        self.imagep = [[UIImageView alloc]initWithFrame:CGRectMake(3, 3, 314
                                                                   , 136)];
        
        self.jslabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 112, 254, 27)];
        
        self.blackimage = [[UIImageView alloc]initWithFrame:CGRectMake(3, 92, 314, 47)];
        
        [self.sclabel setTextColor:[UIColor whiteColor]];
        
        [self.numlabel setTextColor:[UIColor whiteColor]];
        
        [self.jslabel setTextColor:[UIColor whiteColor]];
        
        [self.jslabel setFont:[UIFont systemFontOfSize:15]];
        
        [self.sclabel setFont:[UIFont systemFontOfSize:15]];
        
        self.sclabel.layer.cornerRadius = 10;
        self.sclabel.clipsToBounds = YES;
        
      
        //self.jslabel.layer.cornerRadius = 10;
        self.jslabel.clipsToBounds = YES;
        
        self.jslabel.shadowColor = [UIColor blackColor];
        self.jslabel.shadowOffset = CGSizeMake(0.2, 0.2);
        self.jslabel.highlighted =YES;
        self.jslabel.highlightedTextColor = [UIColor whiteColor];
        
        self.sclabel.textAlignment = NSTextAlignmentRight;
        
        self.imagep.layer.cornerRadius = 7;
        
        self.imagep.clipsToBounds = YES;
        
        
        
        [self.sclabel setBackgroundColor:[UIColor colorWithRed:79/255.0 green:79/255.0 blue:79/255.0 alpha:0.75]];
        
        self.blackimage.layer.cornerRadius = 7;
        
        self.blackimage.clipsToBounds = YES;
        
         self.blackimage.alpha = 0.7;
        
        self.isLikeView.layer.cornerRadius = 7.5;
        
        self.isLikeView.clipsToBounds = YES;
        
      // [self.isLikeView setBackgroundColor:[UIColor redColor]];
        
        [self.numlabel setTextAlignment:NSTextAlignmentLeft];
        
        [self.numlabel setFont:[UIFont systemFontOfSize:15]];
        
        [self.contentView addSubview:self.imagep];
        
        [self.contentView addSubview:self.sclabel];
        
        [self.contentView addSubview:self.blackimage];
        
        [self.contentView addSubview:self.jslabel];
        
        [self.contentView addSubview:self.isLikeView];

        [self.contentView addSubview:self.numlabel];
    }
    return self;


}




@end
