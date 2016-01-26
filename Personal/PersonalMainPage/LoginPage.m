//
//  LoginPage.m
//  Personal
//
//  Created by 薛立恒 on 15/10/22.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "LoginPage.h"
#import "LoginPageCell.h"
#import "RegisterPage1.h"
#import "InterviewPHPMethod.h"
#import "PersonalInfo.h"
#import "MBProgressHUD+MJ.h"
#define IP "http://192.168.2.15:8888"

@interface LoginPage ()

@property (nonatomic, retain) NSMutableDictionary *dic;

@end

@implementation LoginPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jieshouzhanghao:) name:@"jieshouzhanghao" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)jieshouzhanghao:(NSNotification *)notification{
    NSIndexPath *index = [NSIndexPath indexPathForItem:0 inSection:0];
    LoginPageCell *cell = [self.loginTableView cellForRowAtIndexPath:index];
    
    cell.loginText.text = notification.object;
    [self.loginTableView reloadData];

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    self.navigationController.navigationBar.hidden = NO;
    //显示导航栏
    self.navigationController.navigationBarHidden = NO;
    
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1]];
    
    self.title = @"登录";
    
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
//    self.navigationItem.leftBarButtonItem.title = @"< 返回";
    
    self.tabBarController.tabBar.hidden = YES;
    
    self.loginButton.layer.cornerRadius = 3.0;
    self.loginButton.clipsToBounds = YES;
    
}



#pragma mark - tableviewdelegate
//有2个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


//每个分组里面有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

//设置TableviewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    LoginPageCell *cell = [self.loginTableView dequeueReusableCellWithIdentifier:@"loginPageCell"];
    
    //设置cell选中之后不会显示成灰色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.loginText.placeholder = @"手机号";
        
        cell.loginText.keyboardType = UIKeyboardTypeNumberPad;
    } else {
        cell.loginText.placeholder = @"密码";
        cell.loginText.secureTextEntry = YES;
    
    }

    return cell;
}





- (IBAction)Register:(UIBarButtonItem *)sender {
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
    RegisterPage1 *rsp = [sb instantiateViewControllerWithIdentifier:@"registerPage1"];
    
    
    [self.navigationController pushViewController:rsp animated:YES];
    
    
    
}

- (IBAction)Return:(UIBarButtonItem *)sender {
    
//    [self transitionPush];
    [self.navigationController popViewControllerAnimated:YES];
    
}


//转场动画
- (void)transitionPush {
    CATransition *tran = [CATransition animation];
    tran.duration = 0.3;
    
    tran.type = @"moveIn";
    tran.subtype = kCATransitionFromBottom;
    
    [self.navigationController.view.layer addAnimation:tran forKey:nil];
    
    
}

- (IBAction)login:(UIButton *)sender {
    
    NSIndexPath *index1 = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *index2 = [NSIndexPath indexPathForRow:1 inSection:0];
    LoginPageCell *cell1 = [self.loginTableView cellForRowAtIndexPath:index1];
    LoginPageCell *cell2 = [self.loginTableView cellForRowAtIndexPath:index2];
    
    
    [cell2.loginText resignFirstResponder];
    
    if (cell1.loginText.text.length == 0 || cell2.loginText.text.length == 0) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"警告" message:@"您所输入的账号或密码不能为空!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
        
        [ac addAction:returnAction];
        [self presentViewController:ac animated:YES completion:nil];
        
    } else {
        NSMutableURLRequest *request = [InterviewPHPMethod interviewPHP:@"Search.php" and:[NSString stringWithFormat:@"UserID=%@",cell1.loginText.text]];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:@"网络加载失败"];
                });
                return ;
            } else {
            self.dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                if ([self.dic[@"result"] isEqualToString:cell1.loginText.text]) {
                    if ([self.dic[@"result1"] isEqualToString:cell2.loginText.text]) {
                        dispatch_async(dispatch_get_main_queue(), ^{

//                                
                                PersonalInfo *personInfo = [PersonalInfo share];
                                personInfo.UserID = cell1.loginText.text;
                                personInfo.UserName = self.dic[@"UserName"];
//                                //返回到主界面中去,讲电话号码传到
                                [self.navigationController popViewControllerAnimated:YES];
//
                            [MBProgressHUD showSuccess:@"登录成功"];
//                                
//                            }];
//                            [ac addAction:returnAction];
//                            [self presentViewController:ac animated:YES completion:nil];
                        });
                                                       
                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"警告" message:@"密码错误!" preferredStyle:UIAlertControllerStyleAlert];
                            UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                cell2.loginText.text = nil;
                                
                                
                                
                        
                            }];
                            [ac addAction:returnAction];
                            [self presentViewController:ac animated:YES completion:nil];
                        });
                }
                    
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
//                    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"警告" message:@"账号错误!" preferredStyle:UIAlertControllerStyleAlert];
//                    UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                        cell2.loginText.text = nil;
//                        cell1.loginText.text = nil;
//                        
//                        
//                        
//                    }];
//                    [ac addAction:returnAction];
//                    [self presentViewController:ac animated:YES completion:nil];
                    [MBProgressHUD showError:@"账号或密码错误"];
                });
                
            }
            }
        }];
        [task resume];
    
    }
}
@end
