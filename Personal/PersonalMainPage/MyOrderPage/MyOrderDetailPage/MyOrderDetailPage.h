//
//  MyOrderDetailPage.h
//  Personal
//
//  Created by xlh on 15/11/9.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderDetailPage : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myOrderDetailPage;

@property (nonatomic, assign) int whichType;

@end
