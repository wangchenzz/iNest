//
//  SettingPage.m
//  Personal
//
//  Created by 薛立恒 on 15/10/17.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "SettingPage.h"
#import "SettingPageCell.h"
#import "AdvicePage.h"
#import "MyIdentityPage.h"
#import "UMSocial.h"
#import "DescriptionPage.h"
#import "MBProgressHUD+MJ.h"

@interface SettingPage ()

@property (nonatomic ,retain) NSArray *SettingPageArray;

@end

@implementation SettingPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    //读取plist文件
    NSString *path = [[NSBundle mainBundle]pathForResource:@"SettingPage" ofType:@"plist"];
    self.SettingPageArray = [NSArray arrayWithContentsOfFile:path];
    
    //显示导航栏
    self.navigationController.navigationBarHidden = NO;
    
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1]];
    
    self.title = @"更多";
    
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.leftBarButtonItem.title = @"< 返回";
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableviewdelegate
//有3个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


//每个分组里面有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *array = self.SettingPageArray[section];
    return array.count;
}

//设置TableviewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSArray *array = self.SettingPageArray[indexPath.section];
    NSDictionary *dic = array[indexPath.row];
    static NSString *first = @"SettingPageCell";
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        SettingPageCell *cell = [tableView dequeueReusableCellWithIdentifier:first forIndexPath:indexPath];
        //设置cell选中之后不会显示成灰色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.settingCellImage.image = [UIImage imageNamed:[dic objectForKey:@"image"]];
        //    将图片设成圆形
        cell.settingCellImage.layer.cornerRadius = 15.0;
        cell.settingCellImage.clipsToBounds = YES;
        cell.settingCellName.text = [dic objectForKey:@"name"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    } else {//if (indexPath.section == 1 && indexPath.row == 0)
        
        if (indexPath.section == 1 && indexPath.row == 1) {
            SettingPageCell *cell = [tableView dequeueReusableCellWithIdentifier:first forIndexPath:indexPath];
            //设置cell选中之后不会显示成灰色
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.settingCellImage.image = [UIImage imageNamed:[dic objectForKey:@"image"]];
            //    将图片设成圆形
            cell.settingCellImage.layer.cornerRadius = 15.0;
            cell.settingCellImage.clipsToBounds = YES;
            float cacheCount = [self sizeOfCaches];
            cell.settingCellName.text = [NSString stringWithFormat:@"%@:(%.1fM)",[dic objectForKey:@"name"],cacheCount];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        
        
        
        SettingPageCell *cell = [tableView dequeueReusableCellWithIdentifier:first forIndexPath:indexPath];
        //设置cell选中之后不会显示成灰色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.settingCellImage.image = [UIImage imageNamed:[dic objectForKey:@"image"]];
        //    将图片设成圆形
        cell.settingCellImage.layer.cornerRadius = 15.0;
        cell.settingCellImage.clipsToBounds = YES;
        cell.settingCellName.text = [dic objectForKey:@"name"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    
    }
    
}


//选中其中一个cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//点击"邀请好友使用礼记"的cell
    
    
//    点击"意见反馈"的cell
    if (indexPath.section == 0 && indexPath.row == 1) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
        AdvicePage *ap = [sb instantiateViewControllerWithIdentifier:@"advicePage"];
        
        [self.navigationController pushViewController:ap animated:YES];
    }
//    点击"我的身份"的cell
    else if (indexPath.section == 1 && indexPath.row == 0) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
        MyIdentityPage *mip = [sb instantiateViewControllerWithIdentifier:@"myIdentity"];
        
        [self.navigationController pushViewController:mip animated:YES];
    
    }//点击"邀请好友使用礼记"的cell
    else if (indexPath.section == 0 && indexPath.row == 0) {
        [self inviteFriends];
        
        
    }
    //点击"关于礼记"的cell
    else if (indexPath.section == 2 && indexPath.row == 0) {
    
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
        DescriptionPage *dpp = [sb instantiateViewControllerWithIdentifier:@"descriptionPage"];
        
        
        [self.navigationController pushViewController:dpp animated:YES];
    }
    //点击"清除缓存"的cell
    else {
        [MBProgressHUD showMessage:@"正在清除..."];
        [self clearCache];
        [self.settingListTableView reloadData];
        [MBProgressHUD hideHUD];
    }
    
    

}

- (void)inviteFriends {
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"5636c41be0f55a34fc0019d4" shareText:@"我最近用的一款线上购买礼物的APP简直太棒了!大家都来看看吧~" shareImage:[UIImage imageNamed:@"lijiHeadImage"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToQzone,UMShareToQQ,UMShareToWechatSession,nil] delegate:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    //读取plist文件
    NSString *path = [[NSBundle mainBundle]pathForResource:@"SettingPage" ofType:@"plist"];
    self.SettingPageArray = [NSArray arrayWithContentsOfFile:path];
    
    //显示导航栏
    self.navigationController.navigationBarHidden = NO;
    
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1]];
    
    self.title = @"更多";
    
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.leftBarButtonItem.title = @"< 返回";
    
    self.tabBarController.tabBar.hidden = YES;
    
    
    
    
    
    

}



- (void)clearCache {
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
  //  NSLog(@"%@",cachePath);
    NSArray *contents = [NSArray new];
    contents = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
   // NSLog(@"%lu",(unsigned long)contents.count);
    for (NSString *p in contents) {
        NSError *error;
        NSString *a = [cachePath stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:a]) {
            [[NSFileManager defaultManager]removeItemAtPath:a error:&error];
        }
    }
  //  NSLog(@"清除成功！");
    
}

//计算文件夹中的单个文件的
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//计算整个文件夹中文件大小之和
- (float)sizeOfCaches {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    NSArray *contents = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
    float filesize = 0;
    for (NSString *p in contents) {
        NSString *a = [cachePath stringByAppendingPathComponent:p];
        filesize += [self fileSizeAtPath:a];
    }
  //  NSLog(@"%@",cachePath);
   // NSLog(@"%.2f",filesize/(1024*1024));
  
    return filesize/(1024*1024);
}


@end
