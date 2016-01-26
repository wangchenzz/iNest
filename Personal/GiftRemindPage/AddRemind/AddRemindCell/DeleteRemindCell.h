//
//  DeleteRemindCell.h
//  Personal
//
//  Created by 薛立恒 on 15/10/14.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeleteRemindCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

- (IBAction)deleteRemind:(UIButton *)sender;

@end
