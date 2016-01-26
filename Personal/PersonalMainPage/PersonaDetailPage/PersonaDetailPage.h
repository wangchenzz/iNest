//
//  PersonaDetailPage.h
//  Personal
//
//  Created by 薛立恒 on 15/10/26.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonaDetailPage : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *personDetailTableView;
- (IBAction)deletePersonalDetail:(UIButton *)sender;

@end
