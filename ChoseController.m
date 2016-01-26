//
//  ChoseController.m
//  LeeNote
//
//  Created by administrator on 15/10/15.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import "ChoseController.h"

#import "UpSaleCell.h"

@interface ChoseController ()



@property (nonatomic)NSArray *choseary;

@end

@implementation ChoseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    switch (self.CoreIndexPath.row) {
        case 2:
            self.title = @"种类选择";
            self.choseary = @[@"饰品挂件",@"手工纺织品",@"手工装饰",@"其他"];
            break;
        case 4:
            self.title = @"是否包邮";
            self.choseary = @[@"是",@"否"];
            break;
        case 5:
            self.title = @"是否可以定制";
            self.choseary = @[@"是",@"否"];
            break;
        default:
            break;
    }
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
     self.navigationItem.leftBarButtonItem.title = @"< 返回";
    
    //[self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.choseary.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
       
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if ([self.choseary containsObject:self.whatChose]) {
        if (indexPath.row == [self.choseary indexOfObject:self.whatChose]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    cell.textLabel.text = [self.choseary objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
   
    for (int i = 0; i <self.choseary.count; i ++) {
        NSIndexPath *ifasd = [NSIndexPath indexPathForRow:i inSection:0];
        
        UITableViewCell *cell = [self.tableview cellForRowAtIndexPath:ifasd];
        
        if (ifasd.row == indexPath.row) {
            
        
    if (cell.accessoryType == UITableViewCellAccessoryNone ) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
        }else{
        
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    
    }
    //发送通知 传一个 点击数值,行数数值;
    
    NSString *valustring = [self.choseary objectAtIndex:indexPath.row];

    NSArray *sendary = @[valustring,@(self.CoreIndexPath.row)];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"chosevalue" object:sendary];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
