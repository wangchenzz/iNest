//
//  TheController.h
//  LeeNote
//
//  Created by administrator on 15/10/13.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TheController : UIViewController


//主界面
@property (nonatomic,strong)UIView *Mainview;

//左侧栏
@property (nonatomic,strong)UIView *Addview;
//主滑界面
@property (nonatomic,strong)UIScrollView *Mainscroolview;
//主界面上的tableview;
@property (nonatomic,strong)UITableView *MainTableview;
//左侧栏的tableview;
@property (nonatomic,strong)UITableView *AddTableView;


- (IBAction)UpSale:(UIButton *)sender;

@end
