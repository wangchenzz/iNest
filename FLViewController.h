//
//  FLViewController.h
//  Liwushuo
//
//  Created by administrator on 15/10/29.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD+MJ.h"
@interface FLViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
- (IBAction)return:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *bar;

@property (weak, nonatomic) IBOutlet UINavigationItem *Title;


@property NSInteger cout;
@property (weak, nonatomic) IBOutlet UITableView *tableview;


@end
