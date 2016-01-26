//
//  RegisterPage1.h
//  Personal
//
//  Created by 薛立恒 on 15/10/22.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterPage1 : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *numberText;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
- (IBAction)next:(UIButton *)sender;

@end
