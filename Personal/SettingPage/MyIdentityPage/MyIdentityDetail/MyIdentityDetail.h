//
//  MyIdentityDetail.h
//  Personal
//
//  Created by 薛立恒 on 15/10/19.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyIdentityPage.h"

@interface MyIdentityDetail : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) int selectCount;

@property (nonatomic, weak) id<identityMessage> delegate;
@property (weak, nonatomic) IBOutlet UITableView *identityDetailTableView;

@property (nonatomic, strong) NSString *identityDetailStr;

@end
