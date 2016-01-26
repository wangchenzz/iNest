//
//  PersonInfo.h
//  LeeNote
//
//  Created by administrator on 15/10/26.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonInfo : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, retain) NSDictionary *dic;
@end
