//
//  MyOrderDetailPageCell2.h
//  Personal
//
//  Created by xlh on 15/11/9.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderDetailPageCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *headType;
@property (weak, nonatomic) IBOutlet UIImageView *tradeHeadImage;
@property (weak, nonatomic) IBOutlet UILabel *tradeName;
@property (weak, nonatomic) IBOutlet UILabel *tradePrice;
@property (weak, nonatomic) IBOutlet UILabel *tradeCount;
@property (weak, nonatomic) IBOutlet UILabel *tradeTotalCount;
@property (weak, nonatomic) IBOutlet UIButton *getTradeButton;


@end
