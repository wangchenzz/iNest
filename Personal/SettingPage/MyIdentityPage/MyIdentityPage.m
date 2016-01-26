//
//  MyIdentityPage.m
//  Personal
//
//  Created by 薛立恒 on 15/10/19.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "MyIdentityPage.h"
#import "MyIdentityCell.h"
#import "MyIdentityDetail.h"

@interface MyIdentityPage ()

@property (nonatomic, retain) NSArray *myIdentityArray;

@end

@implementation MyIdentityPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    self.myIdentityArray = @[@"性别",@"角色"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableviewdelegate
//有3个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


//每个分组里面有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

//设置TableviewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyIdentityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myIdentityCell"];
    cell.myIdentityName.text = self.myIdentityArray[indexPath.row];
    //设置cell选中之后不会显示成灰色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.myIdentityAddition.text = @"男孩";
        
    } else {
        cell.myIdentityAddition.text = @"大学生";
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *sb = [UIStoryboard storyboardWithName: @"PersonalMainPage" bundle:nil];
    MyIdentityDetail *mid = [sb instantiateViewControllerWithIdentifier:@"myIdentityDetail"];
    if (indexPath.row == 0) {

        mid.selectCount = 0;
    } else {
        mid.selectCount = 1;
    }
    NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    MyIdentityCell *cell = [self.myIdentitytTableView cellForRowAtIndexPath:index];
    mid.identityDetailStr = cell.myIdentityAddition.text;
    mid.delegate = self;
    [self.navigationController pushViewController:mid animated:YES];

}


//下个页面传值的代理方法
- (void)updateGenderInfo:(NSString *)genderStr and:(int)whichCell{
    NSIndexPath *index = [NSIndexPath indexPathForRow:whichCell inSection:0];
    MyIdentityCell *cell = [self.myIdentitytTableView cellForRowAtIndexPath:index];
    cell.myIdentityAddition.text = genderStr;

}


- (void)updateWorkInfo:(NSString *)workStr and:(int)whichCell{

    NSIndexPath *index = [NSIndexPath indexPathForRow:whichCell inSection:0];
    MyIdentityCell *cell = [self.myIdentitytTableView cellForRowAtIndexPath:index];
    cell.myIdentityAddition.text = workStr;

}



@end
