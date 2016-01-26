//
//  MyIdentityDetail.m
//  Personal
//
//  Created by 薛立恒 on 15/10/19.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "MyIdentityDetail.h"
#import "IdentityDetailCell.h"

@interface MyIdentityDetail ()

@property (nonatomic ,retain) NSArray *IdentityDetailArray1;
@property (nonatomic ,retain) NSArray *IdentityDetailArray2;

@end

@implementation MyIdentityDetail

- (void)viewDidLoad {
    [super viewDidLoad];
  //  NSLog(@"%d",self.selectCount);
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];

    self.IdentityDetailArray1 = @[@"男孩",@"女孩"];
    self.IdentityDetailArray2 = @[@"初中生",@"高中生",@"大学生",@"职场新人",@"资深工作党"];
    
    if (self.selectCount == 0) {
        self.title = @"性别";
    } else {
        self.title = @"角色";
    }
    
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.leftBarButtonItem.title = @"< 返回";
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - tableviewdelegate
//有1个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


//每个分组里面有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.selectCount == 0) {
        return 2;
    } else {
        return 5;
    }
    
}

//设置TableviewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IdentityDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identityDetailCell"];
    
    
    if (self.selectCount == 0) {
        cell.detailName.text = self.IdentityDetailArray1[indexPath.row];
        if (indexPath.row == [self.IdentityDetailArray1 indexOfObject:self.identityDetailStr]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
 
    } else {
        cell.detailName.text = self.IdentityDetailArray2[indexPath.row];
        if (indexPath.row == [self.IdentityDetailArray2 indexOfObject:self.identityDetailStr]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectCount == 0) {
        [self.delegate updateGenderInfo:self.IdentityDetailArray1[indexPath.row] and:0];

    } else {
    
        [self.delegate updateWorkInfo:self.IdentityDetailArray2[indexPath.row] and:1];
    }
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    IdentityDetailCell *cell = [self.identityDetailTableView cellForRowAtIndexPath:index];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (void) viewWillAppear:(BOOL)animated {

}
@end
