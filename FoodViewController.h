//
//  FoodViewController.h
//  Liwushuo
//
//  Created by administrator on 15/10/14.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodTableViewCell.h"
#import "ViewController.h"
#import "MBProgressHUD+MJ.h"
#import "PersonalInfo.h"

#import "MJRefresh.h"

@interface FoodViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic)BOOL Choujiang;

@property int A;

@property NSUInteger pageIndex;

@property NSString*imagename;

@property NSString*cc;

@property (weak, nonatomic) IBOutlet UITableView *tableview;




@end
