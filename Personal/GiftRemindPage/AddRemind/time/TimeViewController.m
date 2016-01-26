//
//  TimeViewController.m
//  Personal
//
//  Created by 薛立恒 on 15/10/15.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "TimeViewController.h"
#import "timeCell.h"

@interface TimeViewController ()

@property (nonatomic, retain) NSArray *timeArray;
@property (nonatomic, retain) NSMutableArray *selectTimeArray;

@end

@implementation TimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    self.timeArray = @[@"当前",@"提前1天",@"提前2天",@"提前3天",@"提前4天",@"提前5天",@"提前6天",@"提前1周"];
    
    self.selectTimeArray = [NSMutableArray new];
    
    self.selectTimeArray = [[self.getTime componentsSeparatedByString:@"、"]mutableCopy];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (void)getTime:(NSNotification *)notification{
//    NSString *gettime = [notification object];
//    self.selectTimeArray = [[gettime componentsSeparatedByString:@"、"]mutableCopy];
//    NSLog(@"%@",self.selectTimeArray);
//}


//将多余的cell的线条
- (void)setExtraCellLineHidden: (UITableView *)tableView {
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
    
}


#pragma mark - tableviewdelegate
//有多少个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


//每个分组里面有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}


//设置cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    timeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"timeCell" forIndexPath:indexPath];
    cell.timeLabel.text = self.timeArray[indexPath.row];
    if ([cell.timeLabel.text isEqualToString:@"当前"]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if ([self.selectTimeArray containsObject:[NSString stringWithFormat:@"%@",cell.timeLabel.text]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } 

    
    //设置点击cell的时候cell不变颜色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}


//点击cell之后就会在后面打钩
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    timeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;

    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;

    }

}


//界面消失之前
- (void)dealloc {
    [self.selectTimeArray removeAllObjects];
    for (int i =0; i<8; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        timeCell *cell = [self.timeTableView cellForRowAtIndexPath:indexPath];
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            [self.selectTimeArray addObject:[NSString stringWithFormat:@"%@",cell.timeLabel.text]];
            
        }
    }
//    NSLog(@"selectTimeArray = %@",self.selectTimeArray);
    
    //运用代理传值
    [self.delegate updateTimeSelect:[self.selectTimeArray componentsJoinedByString:@"、"]];
    
}

//从上一个页面传时间到这个页面的代理方法
- (void)selectTimeInfo:(NSString *)selectTimeStr {
    self.selectTimeArray = [[selectTimeStr componentsSeparatedByString:@"、"]mutableCopy];
}


//- (void)viewWillDisappear:(BOOL)animated {
//    
//    
//}

@end
