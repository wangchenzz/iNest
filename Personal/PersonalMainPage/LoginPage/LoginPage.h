//
//  LoginPage.h
//  Personal
//
//  Created by 薛立恒 on 15/10/22.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginPage : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITableView *loginTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *returnButton;


- (IBAction)Register:(UIBarButtonItem *)sender;
- (IBAction)Return:(UIBarButtonItem *)sender;
- (IBAction)login:(UIButton *)sender;
@end
