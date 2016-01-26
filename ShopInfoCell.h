//
//  ShopInfoCell.h
//  LeeNote
//
//  Created by administrator on 15/10/24.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *saleimage;
@property (weak, nonatomic) IBOutlet UILabel *salename;
@property (weak, nonatomic) IBOutlet UILabel *saleprice;
@property (weak, nonatomic) IBOutlet UILabel *salevalue;

@end
