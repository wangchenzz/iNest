//
//  MyOrderPage.h
//  Personal
//
//  Created by 薛立恒 on 15/10/20.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderPage : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myOrderPageTableView;

@end
