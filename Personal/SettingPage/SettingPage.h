//
//  SettingPage.h
//  Personal
//
//  Created by 薛立恒 on 15/10/17.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingPage : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *settingListTableView;

@end
