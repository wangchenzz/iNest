//
//  PersonalMainPage.h
//  Personal
//
//  Created by 薛立恒 on 15/10/13.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalMainPage : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *PersonalMainPageTableView;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;


@property (nonatomic, weak) IBOutlet NSLayoutConstraint *headImageHeight;

- (IBAction)ClockButton:(UIButton *)sender;
- (IBAction)personalDetail:(UIButton *)sender;

- (IBAction)MessageButton:(UIButton *)sender;
//- (IBAction)settingButton:(UIButton *)sender;

@end
