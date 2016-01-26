//
//  IntegralRulePage.m
//  Personal
//
//  Created by xlh on 15/10/31.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "IntegralRulePage.h"
#import "IntegralRulePageCell1.h"
#import "IntegralRulePageCell2.h"

@interface IntegralRulePage ()

@end

@implementation IntegralRulePage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    //显示导航栏
    self.navigationController.navigationBarHidden = NO;
    
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1]];
    
    
    self.title = @"积分规则";
    
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.leftBarButtonItem.title = @"< 返回";
    
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - tableviewdelegate
//有2个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


//每个分组里面有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

//设置TableviewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        IntegralRulePageCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"IntegralRulePageCell1"];
        //设置cell选中之后不会显示成灰色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        
        return cell;
    } else {
        IntegralRulePageCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"IntegralRulePageCell2"];
        //设置cell选中之后不会显示成灰色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    
    }


}

//设置每个cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 50;
    } else {
    
        return 245;
    }
    
}

@end
