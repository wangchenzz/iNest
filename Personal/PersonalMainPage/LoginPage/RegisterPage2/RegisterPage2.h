//
//  RegisterPage2.h
//  Personal
//
//  Created by 薛立恒 on 15/10/22.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterPage2 : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *passwordText1;
@property (weak, nonatomic) IBOutlet UITextField *passwordText2;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;

@property (nonatomic,copy) NSString *rightNumber;

- (IBAction)finishRegister:(UIButton *)sender;

@end
