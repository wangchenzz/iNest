//
//  SPXQViewController.h
//  Liwushuo
//
//  Created by administrator on 15/10/19.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD+MJ.h"
//#import "PinglunViewController.h"
//#import "PinglunViewController.h"
@interface SPXQViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) NSMutableArray *commentsary;
@property (weak, nonatomic) IBOutlet UINavigationBar *bar;
@property (nonatomic,copy) NSString *selectDIYno;
@property(nonatomic,copy)NSString*write;
@property (weak, nonatomic) IBOutlet UIButton *like;
@property (weak, nonatomic) IBOutlet UIButton *go;
@property(nonatomic,copy)NSString*number;
@property(nonatomic)NSInteger BH;
@property (weak, nonatomic) IBOutlet UIImageView *love;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)GO:(id)sender;

- (IBAction)back:(id)sender;



@end
