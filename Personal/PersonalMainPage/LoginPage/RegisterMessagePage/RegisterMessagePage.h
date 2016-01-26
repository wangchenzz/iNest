//
//  RegisterMessagePage.h
//  Personal
//
//  Created by 薛立恒 on 15/10/27.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterMessagePage : UIViewController

@property (nonatomic,copy) NSString *number;

@property (weak, nonatomic) IBOutlet UITextField *messageInfoText;
@property (weak, nonatomic) IBOutlet UIButton *againButton;
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;
- (IBAction)getMessage:(UIButton *)sender;
- (IBAction)nextStep:(UIButton *)sender;

@end
