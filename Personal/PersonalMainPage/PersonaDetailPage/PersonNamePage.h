//
//  PersonNamePage.h
//  Personal
//
//  Created by 薛立恒 on 15/10/26.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonNamePage : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
- (IBAction)finishChangeName:(UIButton *)sender;

@end
