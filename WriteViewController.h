//
//  WriteViewController.h
//  LeeNote
//
//  Created by administrator on 15/10/15.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WriteViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *writefile;
@property (weak, nonatomic) IBOutlet UIButton *finishbutton;
@property (nonatomic) NSIndexPath *writecoreindexpath;
@property (nonatomic)NSString *filestring;
@end
