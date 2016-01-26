//
//  PersonInfo.m
//  LeeNote
//
//  Created by administrator on 15/10/26.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import "PersonInfo.h"

#import "personinfoCell.h"

#import "MBProgressHUD+MJ.h"




@interface PersonInfo ()

@property (nonatomic,retain) NSArray *valueary;

@end


@implementation PersonInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    self.title = @"填写个人信息";
    //设置标题字体大小和颜色

    
    self.valueary = @[@"姓名:",@"地址:",@"联系方式:"];
    

    UIBarButtonItem *sureButton = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(sureBuT:)];
    

    
    self.navigationItem.rightBarButtonItem = sureButton;
   
    
}


-(void)sureBuT:(UIBarButtonItem*)button{
    
    NSIndexPath *index1 = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *index2 = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *index3 = [NSIndexPath indexPathForRow:2 inSection:0];
    personinfoCell *cell1 = [self.tableview cellForRowAtIndexPath:index1];
    personinfoCell *cell2 = [self.tableview cellForRowAtIndexPath:index2];
    personinfoCell *cell3 = [self.tableview cellForRowAtIndexPath:index3];
    
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|81|8[09])[0-9]|349)\\d{7}$";
    
    

    
    
    if ([cell1.valuetextfile.text isEqualToString:@""] || [cell2.valuetextfile.text isEqualToString:@""] || [cell3.valuetextfile.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请完成您的详细信息"];
    } else {
    
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
        NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
        if (([regextestmobile evaluateWithObject:cell3.valuetextfile.text] == YES)
            || ([regextestcm evaluateWithObject:cell3.valuetextfile.text] == YES)
            || ([regextestct evaluateWithObject:cell3.valuetextfile.text] == YES)
            || ([regextestcu evaluateWithObject:cell3.valuetextfile.text] == YES)){
    
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i < 3; i ++) {
        personinfoCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        NSString *str = cell.valuetextfile.text;

        [array addObject:str];
        
 
    }

    NSDictionary *dic = @{@"array":array};
    NSNotification *notification = [NSNotification notificationWithName:@"dizhi" object:nil userInfo:dic];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBProgressHUD showError:@"请输入正确的手机号"];
        
        }
    
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
        return 3;

}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    personinfoCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"personinfocell" forIndexPath:indexPath];
    
    
    if (indexPath.row == 0) {
        cell.valuetextfile.placeholder = @"请输入收货人姓名";
        cell.valuetextfile.text = self.dic[@"name"];
    } else if (indexPath.row == 1) {
        cell.valuetextfile.placeholder = @"请输入收货人详细地址";
        cell.valuetextfile.text = self.dic[@"address"];
    } else {
    
        cell.valuetextfile.placeholder = @"请输入收货人联系方式";
        cell.valuetextfile.keyboardType = UIKeyboardTypeNumberPad;
        cell.valuetextfile.text = self.dic[@"ponenumer"];
    }
    
//    cell.valuetextfile.placeholder = @"wtire in here ~";
    
    cell.infolabel.text = [self.valueary objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        
    [cell.valuetextfile becomeFirstResponder];
    
    }

   return cell;


}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;

}

@end
