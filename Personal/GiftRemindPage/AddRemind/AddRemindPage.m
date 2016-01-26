//
//  AddRemindPage.m
//  Personal
//
//  Created by 薛立恒 on 15/10/14.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "AddRemindPage.h"
#import "AddRemindCell.h"
#import "AddRemindCell1.h"
#import "AddRemindCell2.h"
#import "DeleteRemindCell.h"
#import "TimeViewController.h"
#import "RepeatViewController.h"
#import "GiftRemindInfo.h"
#import "MBProgressHUD+MJ.h"

@interface AddRemindPage ()

@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, strong) NSString *selectedTimeStr;
@property (nonatomic, strong) NSString *selectedRepeatStr;
@property (nonatomic, assign) BOOL timeIsSelected;
@property (nonatomic, assign) BOOL repeatIsSelected;
@property (nonatomic, retain) GiftRemindInfo *remindInfo;

@end

@implementation AddRemindPage

- (void)viewDidLoad {
    
    
    
    [super viewDidLoad];

    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    //先设置他们是有默认值的
    self.timeIsSelected = YES;
    self.repeatIsSelected = YES;
    
    //调用取消多余分割线的函数
    [self setExtraCellLineHidden:self.AddRemindTableView];

    self.isSelect = self.isSelecttrs;
//    NSLog(@"%@",self.isSelecttrs ? @"yes":@"no");
    
    self.remindInfo = [GiftRemindInfo share];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//将多余的cell的线条
- (void)setExtraCellLineHidden: (UITableView *)tableView {
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
    
}



#pragma mark - tableviewdelegate
//有多少个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.isSelect == YES) {
        return 4;
    } else {
        return 3;
    
    }

}

//每个分组里面有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        return 2;
    } else  {
        return 1;
    }
}

//设置每个cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.isSelect == YES) {
        GiftRemindInfo *remindInfo = [GiftRemindInfo share];
        
        //设置用户原来选择的时间
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        df.dateFormat = @"yyyy-MM-dd MMM a hh:mm";
        NSDate *date=[df dateFromString:self.remindInfo.time];
        self.datePicker.date = date;
        
        self.title = @"查询提醒";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(updateRemind:)]; // 要改方法
        if (self.timeIsSelected == NO || self.repeatIsSelected == NO) {
            self.navigationItem.rightBarButtonItem.enabled = NO;
        } else {
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                AddRemindCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"addRemindCell2" forIndexPath:indexPath];
                //设置cell选中之后不会显示成灰色
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.cell2addition.text = remindInfo.repeatStr;
                cell.cell2Name.text = @"重复";
                
                return cell;
                
            } else {
                
                AddRemindCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"addRemindCell2" forIndexPath:indexPath];
                //设置cell选中之后不会显示成灰色
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.cell2addition.text = remindInfo.timeStr;
                cell.cell2Name.text = @"提醒时间";
                
                
                return cell;
            }

        } else if(indexPath.section == 0) {
            AddRemindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addRemindCell1" forIndexPath:indexPath];
            //设置cell选中之后不会显示成灰色
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (remindInfo.title.length == 0) {
                self.navigationItem.rightBarButtonItem.enabled = NO;
            } else {
                
             cell.cell1Text.text = remindInfo.title;
            }
//            [cell.cell1Text resignFirstResponder];
            cell.cell1Text.delegate = self;
            return cell;
        
        } else if (indexPath.section == 3) {
            DeleteRemindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deleteRemindCell" forIndexPath:indexPath];
            //设置cell选中之后不会显示成灰色
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            return cell;
        
        } else {
            AddRemindCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"addRemindCell3" forIndexPath:indexPath];
            //设置cell选中之后不会显示成灰色
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.cell3Text.text = remindInfo.remark;
//            [cell.cell3Text resignFirstResponder];
            cell.cell3Text.delegate = self;
            return cell;
        }
    } else {

        self.title = @"添加提醒";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(addRemind:)];
        if (self.timeIsSelected == NO || self.repeatIsSelected == NO) {
            self.navigationItem.rightBarButtonItem.enabled = NO;
        } else {
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
        
        
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                AddRemindCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"addRemindCell2" forIndexPath:indexPath];
                //设置cell选中之后不会显示成灰色
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.cell2Name.text = @"重复";
                cell.cell2addition.text = @"每年";
                
                return cell;
                
            } else {
                
                AddRemindCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"addRemindCell2" forIndexPath:indexPath];
                //设置cell选中之后不会显示成灰色
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.cell2Name.text = @"提醒时间";
                cell.cell2addition.text = @"当前";
            
                return cell;
            }
            
        } else if(indexPath.section == 0) {
            AddRemindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addRemindCell1" forIndexPath:indexPath];
            //设置cell选中之后不会显示成灰色
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.cell1Text.delegate = self;
            return cell;
            
        } else {
            AddRemindCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"addRemindCell3" forIndexPath:indexPath];
            //设置cell选中之后不会显示成灰色
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.cell3Text.delegate = self;
            return cell;
        }
    
    }
    
    
}

//添加提醒
- (void)addRemind:(UIBarButtonItem *)sender{
    
    
    
    self.remindInfo = [GiftRemindInfo share];

    
    NSIndexPath *index1 = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *index2 = [NSIndexPath indexPathForRow:0 inSection:1];
    NSIndexPath *index3 = [NSIndexPath indexPathForRow:1 inSection:1];
    NSIndexPath *index4 = [NSIndexPath indexPathForRow:0 inSection:2];
    
//    self.datePicker
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.dateFormat = @"yyyy-MM-dd MMM a hh:mm";
    
    
    
    NSDate *date = self.datePicker.date;
    
    AddRemindCell *cell0 = [self.AddRemindTableView cellForRowAtIndexPath:index1];
    if (cell0.cell1Text.text.length == 0) {
        [MBProgressHUD showError:@"请填写提醒标题"];
    } else {
    self.remindInfo.time = [df stringFromDate:date];
    
    
//    AddRemindCell *cell = [self.AddRemindTableView dequeueReusableCellWithIdentifier:@"addRemindCell1" forIndexPath:index1];
    AddRemindCell *cell = [self.AddRemindTableView cellForRowAtIndexPath:index1];
    if (cell == nil) {
        AddRemindCell *cell0 = [self.AddRemindTableView dequeueReusableCellWithIdentifier:@"addRemindCell1" forIndexPath:index1];
        self.remindInfo.title = cell0.cell1Text.text;
    } else {
    
        self.remindInfo.title = cell.cell1Text.text;
    }
    

    
    AddRemindCell1 *cell1 = [self.AddRemindTableView cellForRowAtIndexPath:index2];
    self.remindInfo.repeatStr = cell1.cell2addition.text;
    
    AddRemindCell1 *cell2 = [self.AddRemindTableView cellForRowAtIndexPath:index3];
    self.remindInfo.timeStr = cell2.cell2addition.text;
    
    AddRemindCell2 *cell3 = [self.AddRemindTableView cellForRowAtIndexPath:index4];
    if (cell3.cell3Text.text.length == 0) {
        self.remindInfo.remark = @"无";
    }else {
        self.remindInfo.remark = cell3.cell3Text.text;
    }
    
    
    self.remindInfo.isSave = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
    }
}

//修改提醒
- (void)updateRemind:(UIBarButtonItem *)sender{
    self.remindInfo = [GiftRemindInfo share];
    
    
    NSIndexPath *index1 = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *index2 = [NSIndexPath indexPathForRow:0 inSection:1];
    NSIndexPath *index3 = [NSIndexPath indexPathForRow:1 inSection:1];
    NSIndexPath *index4 = [NSIndexPath indexPathForRow:0 inSection:2];
    
    //    self.datePicker
    NSDateFormatter *df = [[NSDateFormatter alloc]init];

    df.dateFormat = @"yyyy-MM-dd MMM a hh:mm";

    NSDate *date = self.datePicker.date;
//    [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    AddRemindCell *cell0 = [self.AddRemindTableView cellForRowAtIndexPath:index1];
    if (cell0.cell1Text.text.length == 0) {
        [MBProgressHUD showError:@"请填写提醒标题"];
    } else {
    self.remindInfo.time = [df stringFromDate:date];
   // NSLog(@"time = %@",self.remindInfo.time);
    
    AddRemindCell *cell = [self.AddRemindTableView cellForRowAtIndexPath:index1];
    if (cell == nil) {
        AddRemindCell *cell0 = [self.AddRemindTableView dequeueReusableCellWithIdentifier:@"addRemindCell1" forIndexPath:index1];
        self.remindInfo.title = cell0.cell1Text.text;
    } else {
        
        self.remindInfo.title = cell.cell1Text.text;
    }
    
    AddRemindCell1 *cell1 = [self.AddRemindTableView cellForRowAtIndexPath:index2];
    if (cell == nil) {
        AddRemindCell1 *cell0 = [self.AddRemindTableView dequeueReusableCellWithIdentifier:@"addRemindCell2" forIndexPath:index2];
        self.remindInfo.repeatStr = cell0.cell2addition.text;
    } else {
        self.remindInfo.repeatStr = cell1.cell2addition.text;
    }
    AddRemindCell1 *cell2 = [self.AddRemindTableView cellForRowAtIndexPath:index3];
    self.remindInfo.timeStr = cell2.cell2addition.text;

    
    AddRemindCell2 *cell3 = [self.AddRemindTableView cellForRowAtIndexPath:index4];
    
    if (cell3.cell3Text.text.length == 0) {
        self.remindInfo.remark = @"无";
    }else {
        self.remindInfo.remark = cell3.cell3Text.text;
    }
    
    self.remindInfo.isUpdate = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
    }
}

//-(void)dateChanged:(id)sender{
//    UIDatePicker* control = (UIDatePicker*)sender;
//    NSDate *date = control.date;
//    /*添加你自己响应代码*/
//    self.remindInfo.time = []
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
            TimeViewController *tvc = [sb instantiateViewControllerWithIdentifier:@"timeSB"];
            tvc.delegate = self;
            
            
            AddRemindCell1 *cell = [tableView cellForRowAtIndexPath:indexPath];
            tvc.getTime = cell.cell2addition.text;

            [self.navigationController pushViewController:tvc animated:YES];
        } else {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
            RepeatViewController *rvc = [sb instantiateViewControllerWithIdentifier:@"repeatSB"];
            rvc.delegate = self;
            
            
            AddRemindCell1 *cell = [tableView cellForRowAtIndexPath:indexPath];
            rvc.getRepeat = cell.cell2addition.text;

            [self.navigationController pushViewController:rvc animated:YES];
        }
    }

}

//设置cell的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return 100;
    } else {
        return 50;
    }
}


//传时间数组值的时候的代理的方法
- (void)updateTimeSelect:(NSString *)SelectArrayStr {
    
    self.selectedTimeStr = SelectArrayStr;
//    NSLog(@"%@",SelectArrayStr);
    if (SelectArrayStr.length == 0) {
        self.timeIsSelected = NO;
    }
    NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:1];
    AddRemindCell1 *cell = [self.AddRemindTableView cellForRowAtIndexPath:index];
    cell.cell2addition.text = self.selectedTimeStr;

}

//传重复次数的值的时候的代理方法
- (void)updateRepeatSelect:(NSString *)SelectArrayStr{
    self.selectedRepeatStr = SelectArrayStr;
//    NSLog(@"%@",SelectArrayStr);
    if (SelectArrayStr.length == 0) {
        self.repeatIsSelected = NO;
    }
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:1];
    AddRemindCell1 *cell = [self.AddRemindTableView cellForRowAtIndexPath:index];
    cell.cell2addition.text = self.selectedRepeatStr;
}

//设置头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return @"备注:";
    }
    else
        return nil;
}

- (IBAction)deleteRemind:(UIButton *)sender {
    self.remindInfo.isDelete = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;

}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    self.datePicker.hidden = YES;
    [self.AddRemindTableView setFrame:CGRectMake(0, 64, 320, 285)];


}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.datePicker.hidden = NO;
    [self.AddRemindTableView setFrame:CGRectMake(0, 283, 320, 285)];

}

//- (void)viewWillDisappear:(BOOL)animated {
//    
//    
//}
@end
