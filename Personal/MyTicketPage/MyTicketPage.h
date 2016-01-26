//
//  MyTicketPage.h
//  Personal
//
//  Created by 薛立恒 on 15/10/21.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTicketPage : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTicketTableView;

@property (nonatomic, assign) int whichPage;

@end
