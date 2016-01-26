//
//  MyOrderPage.m
//  Personal
//
//  Created by 薛立恒 on 15/10/20.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "MyOrderPage.h"
#import "MyOrderPageCell.h"
#import "MyOrderDetailPage.h"
#import "MyTaobaoWebViewPage.h"


@interface MyOrderPage ()

@end

@implementation MyOrderPage

- (void)viewDidLoad {
    [super viewDidLoad];



    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - tableviewdelegate
//有2个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


//每个分组里面有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

//设置TableviewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyOrderPageCell *cell = [self.myOrderPageTableView dequeueReusableCellWithIdentifier:@"myOrderPageCell" forIndexPath:indexPath];
    //设置cell选中之后不会显示成灰色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.orderCellLabel.text = @"淘宝订单";
        cell.orderCellImage.image = [UIImage imageNamed:@"orderPage1"];
        cell.orderCellImage.layer.cornerRadius = 12.0;
        cell.orderCellImage.clipsToBounds = YES;
        
    } else {
        cell.orderCellLabel.text = @"DIY订单";
        cell.orderCellImage.image = [UIImage imageNamed:@"orderPage2"];
        cell.orderCellImage.layer.cornerRadius = 12.0;
        cell.orderCellImage.clipsToBounds = YES;
    }

    return cell;
}

- (void)viewWillAppear:(BOOL)animated {
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    //显示导航栏
    self.navigationController.navigationBarHidden = NO;
    
   
    
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1]];
    
    self.title = @"我的订单";
    
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.leftBarButtonItem.title = @"< 返回";
    
    self.tabBarController.tabBar.hidden = YES;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
    MyOrderDetailPage *mdp = [sb instantiateViewControllerWithIdentifier:@"myOrderDetailPage"];
    if (indexPath.section == 0) {

        MyTaobaoWebViewPage *mtp = [sb instantiateViewControllerWithIdentifier:@"myTaobaoWebViewPage"];
        
        [self.navigationController pushViewController:mtp animated:YES];
    } else {
        mdp.whichType = 1;
    
    [self.navigationController pushViewController:mdp animated:YES];
    }

    
}



//设置cell的header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
}

//设置cell的footer的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;

}
@end
