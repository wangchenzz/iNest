//
//  AdvicePage.m
//  Personal
//
//  Created by 薛立恒 on 15/10/17.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "AdvicePage.h"
#import "ContactCell.h"
#import "ContentCell.h"

@interface AdvicePage ()

@end

@implementation AdvicePage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableviewdelegate
//有3个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


//每个分组里面有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

//设置TableviewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentCell"];
        //设置cell选中之后不会显示成灰色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        return cell;
    } else {
        ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactCell"];
        //设置cell选中之后不会显示成灰色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        
        return cell;
    
    }

}

//设置头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"反馈内容";
    } else {
        return @"联系方式";
    }
}


//设置cell的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 127.5;
    } else {
        return 50;
    }
}

- (IBAction)returnButton:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

//- (void)viewWillDisappear:(BOOL)animated {
//    
//    
//}
@end
