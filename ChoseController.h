//
//  ChoseController.h
//  LeeNote
//
//  Created by administrator on 15/10/15.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoseController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,retain) NSIndexPath *CoreIndexPath;
@property (nonatomic,copy) NSString *whatChose;

@end
