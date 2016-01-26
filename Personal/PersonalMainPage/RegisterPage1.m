//
//  RegisterPage1.m
//  Personal
//
//  Created by 薛立恒 on 15/10/22.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "RegisterPage1.h"
#import "RegisterPage2.h"
#import "InterviewPHPMethod.h"
#import "RegisterMessagePage.h"
#import "MBProgressHUD+MJ.h"

@interface RegisterPage1 ()

@property (nonatomic, retain) NSMutableDictionary *dic;

@end

@implementation RegisterPage1

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
    
    self.title = @"注册手机号";
    
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //    self.navigationItem.leftBarButtonItem.title = @"< 返回";
    
    self.tabBarController.tabBar.hidden = YES;

    
    self.nextButton.layer.cornerRadius = 3.0;
    self.nextButton.clipsToBounds =  YES;
    self.nextButton.enabled = YES;
    
}

- (IBAction)next:(UIButton *)sender {
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|81|8[09])[0-9]|349)\\d{7}$";


    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:self.numberText.text] == YES)
        || ([regextestcm evaluateWithObject:self.numberText.text] == YES)
        || ([regextestct evaluateWithObject:self.numberText.text] == YES)
        || ([regextestcu evaluateWithObject:self.numberText.text] == YES)){
        
            NSMutableURLRequest *request = [InterviewPHPMethod interviewPHP:@"Search.php" and:[NSString stringWithFormat:@"UserID=%@",self.numberText.text]];
        
        
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD showError:@"网络加载失败"];
                    });
                    return ;
                } else {
                self.dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                if ([self.dic[@"result"] isEqualToString:self.numberText.text]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"警告" message:@"该用户已经被注册" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        //    NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
                            return ;
                        }];
                        [ac addAction:cancelAction];
                        [self presentViewController:ac animated:YES completion:nil];
                    });
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
                        RegisterMessagePage *rmp = [sb instantiateViewControllerWithIdentifier:@"registerMessagePage"];
                        rmp.number = self.numberText.text;
                        self.nextButton.enabled = NO;
                        
                        [self.navigationController pushViewController:rmp animated:YES];
                    });
                }
                }
            }];
            [task resume];
        
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"警告" message:@"请输入正确的手机号" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [ac addAction:returnAction];
            [self presentViewController:ac animated:YES completion:nil];
        });
    
    }
}
@end
