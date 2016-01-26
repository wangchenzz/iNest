//
//  SaleViewController.h
//  LeeNote
//
//  Created by administrator on 15/10/24.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaleViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic) NSMutableDictionary *valuedictionary;

@property (nonatomic,copy) NSString * price;

@property (nonatomic,copy) NSString *selectDIYno;

@end




@interface mytestClass : NSObject


@property (nonatomic,assign) BOOL isError;


@end


