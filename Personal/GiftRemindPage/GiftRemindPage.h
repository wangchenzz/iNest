//
//  GiftRemindPage.h
//  Personal
//
//  Created by 薛立恒 on 15/10/14.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GiftRemindPage : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *remindList;

@end
