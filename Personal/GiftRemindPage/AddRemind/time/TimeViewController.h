//
//  TimeViewController.h
//  Personal
//
//  Created by 薛立恒 on 15/10/15.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddRemindPage.h"

@interface TimeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *timeTableView;
@property (nonatomic, strong) NSString *getTime;

@property (nonatomic, weak) id<TransSelectArrayInfo> delegate;

@end
