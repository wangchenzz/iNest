//
//  RepeatViewController.m
//  Personal
//
//  Created by 薛立恒 on 15/10/15.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "RepeatViewController.h"
#import "repeatCell.h"

@interface RepeatViewController ()
@property (nonatomic, retain) NSArray *repeatArray;
@property (nonatomic, assign) NSString *selectRepeatStr;

@end

@implementation RepeatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    self.repeatArray = @[@"仅一次",@"每年"];
    self.selectRepeatStr = self.getRepeat;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - tableviewdelegate
//有多少个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//每个分组里面有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

//设置cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    repeatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"repeatCell" forIndexPath:indexPath];
    cell.repeatLabel.text = self.repeatArray[indexPath.row];
    if ([cell.repeatLabel.text isEqualToString:@"每年"]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    //设置cell选中之后不会显示成灰色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


//点击cell之后就会在后面打钩
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    NSIndexPath *index1 = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *index2 = [NSIndexPath indexPathForRow:1 inSection:0];
    repeatCell *cell1 = [tableView cellForRowAtIndexPath:index1];
    repeatCell *cell2 = [tableView cellForRowAtIndexPath:index2];
    
    
    if (indexPath.row == 0) {
        if (cell1.accessoryType == UITableViewCellAccessoryCheckmark) {
            cell1.accessoryType = UITableViewCellAccessoryNone;
            cell2.accessoryType = UITableViewCellAccessoryCheckmark;
            
        } else {
            cell1.accessoryType = UITableViewCellAccessoryCheckmark;
            cell2.accessoryType = UITableViewCellAccessoryNone;
        
        }
    } else {
        if (cell2.accessoryType == UITableViewCellAccessoryCheckmark) {
            cell2.accessoryType = UITableViewCellAccessoryNone;
            cell1.accessoryType = UITableViewCellAccessoryCheckmark;
            
        } else {
            cell2.accessoryType = UITableViewCellAccessoryCheckmark;
            cell1.accessoryType = UITableViewCellAccessoryNone;
            
        }
    
    }
    
}


//界面消失之前
- (void)dealloc {
    
    for (int i =0; i<2; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        repeatCell *cell = [self.repeatTableView cellForRowAtIndexPath:indexPath];
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
//            [self.selectRepeatArray addObject:[NSString stringWithFormat:@"%@",cell.repeatLabel.text]];
            self.selectRepeatStr = cell.repeatLabel.text;
        }
    }
    //    NSLog(@"selectTimeArray = %@",self.selectTimeArray);
    //运用代理传值
    [self.delegate updateRepeatSelect:self.selectRepeatStr];
}


//- (void)viewWillDisappear:(BOOL)animated {
//    
//    
//}
@end
