//
//  RegisterPage2.m
//  Personal
//
//  Created by 薛立恒 on 15/10/22.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "RegisterPage2.h"
#import "LoginPage.h"
#import "InterviewPHPMethod.h"
#import "MBProgressHUD+MJ.h"
@interface RegisterPage2 ()

@property (nonatomic, retain) NSMutableDictionary *dic;

@end

@implementation RegisterPage2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //显示导航栏
    self.navigationController.navigationBarHidden = NO;
    
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1]];
    
    self.title = @"注册密码";
    
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //    self.navigationItem.leftBarButtonItem.title = @"< 返回";
    
    self.tabBarController.tabBar.hidden = YES;
    
    
    self.finishButton.layer.cornerRadius = 3.0;
    self.finishButton.clipsToBounds = YES;

    
}

- (IBAction)finishRegister:(UIButton *)sender {
    
    NSMutableURLRequest *request = [InterviewPHPMethod interviewPHP:@"Search.php" and:[NSString stringWithFormat:@"UserID=%@",self.rightNumber]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"网络加载失败"];
            });
            return ;
        } else {
        self.dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (self.passwordText1.text.length == 0 || self.passwordText2.text.length == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"警告" message:@"密码不能为空哦~" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                  //  NSLog(@"The\"Okay/Cancel\" alert's cancel action occured.");
                    return ;
                }];
                [ac addAction:cancelAction];
                [self presentViewController:ac animated:YES completion:nil];
                
            });
        } else if (![self.passwordText1.text isEqualToString:self.passwordText2.text]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"警告" message:@"请确认你输入的密码是一样的哦~" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                  //  NSLog(@"The\"Okay/Cancel\" alert's cancel action occured.");
                    return ;
                }];
                [ac addAction:cancelAction];
                [self presentViewController:ac animated:YES completion:nil];
                
            });
        
        } else if (self.passwordText1.text.length < 6 || self.passwordText2.text.length < 6) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"警告" message:@"密码不能少于6位数哦~" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                //    NSLog(@"The\"Okay/Cancel\" alert's cancel action occured.");
                    return ;
                }];
                [ac addAction:cancelAction];
                [self presentViewController:ac animated:YES completion:nil];
                
            });
        
        }
        
        else {
        
            [self registerPersonCode];
        }
        }
    }];
    
    [task resume];
    
    

  
}


- (void)registerPersonCode{
    
    NSMutableURLRequest *request = [InterviewPHPMethod interviewPHP:@"Register.php" and:[NSString stringWithFormat:@"UserID=%@&UserPassword=%@",self.rightNumber,self.passwordText1.text]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"网络加载失败"];
            });
            return ;
        } else {
        if ([self.dic[@"result"] isEqualToString:@"error"]) {
             dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"恭喜你注册成功哦~点击确定登录吧~" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
              //  NSLog(@"注册成功!");
                
               
                    for (UIViewController *controller in self.navigationController.viewControllers) {
                        if ([controller isKindOfClass:[LoginPage class]]) {
                            [[NSNotificationCenter defaultCenter]postNotificationName:@"jieshouzhanghao" object:self.rightNumber];
                            [self.navigationController popToViewController:controller animated:YES];
                        }
                        
                        
                    }
               
            }];
            [ac addAction:returnAction];
            [self presentViewController:ac animated:YES completion:nil];
           });
        }
        }
        
    }];
    
    [task resume];
    
    



}
@end
