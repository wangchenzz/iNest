//
//  MyIdentityPage.h
//  Personal
//
//  Created by 薛立恒 on 15/10/19.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol identityMessage <NSObject>

- (void)updateGenderInfo:(NSString *)genderStr and:(int)whichCell;
- (void)updateWorkInfo:(NSString *)workStr and:(int)whichCell;

@end

@interface MyIdentityPage : UIViewController<UITableViewDataSource,UITableViewDelegate,identityMessage>
@property (weak, nonatomic) IBOutlet UITableView *myIdentitytTableView;

@end
