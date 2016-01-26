//
//  AddRemindPage.h
//  Personal
//
//  Created by 薛立恒 on 15/10/14.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TransSelectArrayInfo <NSObject>

- (void)updateTimeSelect:(NSString *)SelectArrayStr;
- (void)updateRepeatSelect:(NSString *)SelectArrayStr;

@end

@interface AddRemindPage : UIViewController<UITableViewDataSource,UITableViewDelegate,TransSelectArrayInfo,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *AddRemindTableView;
@property (nonatomic,assign) BOOL isSelecttrs;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)deleteRemind:(UIButton *)sender;

@end
