//
//  GiftRemindPage.m
//  Personal
//
//  Created by 薛立恒 on 15/10/14.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "GiftRemindPage.h"
#import "GIftRemindPageCell.h"
#import "AddRemindPage.h"
#import "GiftRemindInfo.h"
@interface GiftRemindPage ()


@property (nonatomic, retain) NSMutableArray *remindListArray;


@end

@implementation GiftRemindPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    
    [self readRemindInfo];
    
    //调用取消多余分割线的函数
    [self setExtraCellLineHidden:self.remindList];
    
    

    
    
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


//将信息写入沙盒
- (void)writeRemindInfo{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];   //获取沙盒中的路径
    NSString *plistPath =[NSString stringWithFormat:@"%@/remindList.plist",path];
    [self.remindListArray writeToFile:plistPath atomically:YES];



}

//在沙盒里面读取信息
- (void)readRemindInfo{

    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];   //获取沙盒中的路径
    NSString *plistPath =[NSString stringWithFormat:@"%@/remindList.plist",path];
 //   NSLog(@"%@",plistPath);
    
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm fileExistsAtPath:plistPath]) {
            self.remindListArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
   
        } else {
   
            self.remindListArray = [NSMutableArray new];
        }
}


- (void)viewWillAppear:(BOOL)animated {

        
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
        
        //显示导航栏
        self.navigationController.navigationBarHidden = NO;
        
        //设置导航栏颜色
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1]];
        
        self.title = @"送礼提醒";
        
        //设置标题字体大小和颜色
        [self.navigationController.navigationBar setTitleTextAttributes:
         
         @{NSFontAttributeName:[UIFont systemFontOfSize:18],
           
           NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        self.navigationItem.leftBarButtonItem.title = @"< 返回";
        
        self.tabBarController.tabBar.hidden = YES;
        
    
    
    GiftRemindInfo *remindInfo = [GiftRemindInfo share];
    
    
    NSDictionary *dic = @{@"time":remindInfo.time,@"title":remindInfo.title,@"repeatStr":remindInfo.repeatStr,@"timeStr":remindInfo.timeStr,@"remark":remindInfo.remark};
 //   NSLog(@"dic = %@",dic);
    if (remindInfo.isSave == YES) {
        [self.remindListArray addObject:dic];

    } else if (remindInfo.isUpdate == YES){
        [self.remindListArray replaceObjectAtIndex:remindInfo.remindIndexPath.row withObject:dic];

        
    }else if (remindInfo.isDelete == YES) {
        [self.remindListArray removeObjectAtIndex:remindInfo.remindIndexPath.row];
 
    }
    [self writeRemindInfo];
    
    [self readRemindInfo];
    
  //  NSLog(@"self.remindListArray:%@",self.remindListArray);
    [self.remindList reloadData];
}


#pragma mark - tableviewdelegate
//有多少个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//每个分组里面有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.remindListArray.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    GIftRemindPageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"giftRemindCell" forIndexPath:indexPath];
    //设置cell选中之后不会显示成灰色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = self.remindListArray[indexPath.row];
    cell.dateNameLabel.text = dic[@"title"];

    NSString *timeStr = dic[@"time"];

    cell.timelabel.text = [timeStr substringToIndex:10];
    return cell;
}


//准备选择走哪个segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"checkRemind"]) {
        AddRemindPage *arp = segue.destinationViewController;

        arp.isSelecttrs = YES;
  
    } else {
        AddRemindPage *arp = segue.destinationViewController;
        arp.isSelecttrs = NO;


    }

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    GiftRemindInfo *remindInfo = [GiftRemindInfo share];
    
    NSDictionary *dic = self.remindListArray[indexPath.row];
    remindInfo.time = dic[@"time"];
    remindInfo.title = dic[@"title"];
    remindInfo.repeatStr = dic[@"repeatStr"];
    remindInfo.timeStr = dic[@"timeStr"];
    remindInfo.remark = dic[@"remark"];
    remindInfo.remindIndexPath = indexPath;
    
    
    
    

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
GiftRemindInfo *remindInfo = [GiftRemindInfo share];
    remindInfo.isSave = NO;
    remindInfo.isDelete = NO;
    remindInfo.isUpdate = NO;

}



@end
