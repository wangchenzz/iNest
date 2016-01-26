//
//  RegisterMessagePage.m
//  Personal
//
//  Created by 薛立恒 on 15/10/27.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "RegisterMessagePage.h"
#import <SMS_SDK/SMSSDK.h> 
#import "RegisterPage2.h"
#import "MBProgressHUD+MJ.h"

@interface RegisterMessagePage ()

@property (nonatomic, assign) int timeCount;
@property (nonatomic, retain) NSTimer *timer;

@end

@implementation RegisterMessagePage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.timeCount = 60;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countAdd:) userInfo:nil repeats:YES];
    
    
    [self.timer fire];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)countAdd:(NSTimer *)timer{
    
    if (self.timeCount == 0) {
        self.againButton.enabled = YES;
        [self.againButton setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        self.againButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [self.againButton setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        
        
        [self.timer setFireDate:[NSDate distantFuture]];
    } else {
        self.againButton.enabled = NO;
        self.againButton.titleLabel.font = [UIFont systemFontOfSize:10.0];
        [self.againButton setTitle:[NSString stringWithFormat:@"%d秒之后重新获取验证码",self.timeCount] forState:UIControlStateNormal];
        [self.againButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    
    

    
    self.timeCount --;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //显示导航栏
    self.navigationController.navigationBarHidden = NO;
    
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1]];
    
    self.title = @"短信验证码";
    
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //    self.navigationItem.leftBarButtonItem.title = @"< 返回";
    
    self.tabBarController.tabBar.hidden = YES;
    
    
    self.nextStepButton.layer.cornerRadius = 3.0;
    self.nextStepButton.clipsToBounds = YES;
    
    //获取验证码
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS
     //这个参数可以选择是通过发送验证码还是语言来获取验证码
                            phoneNumber:self.number
                                   zone:@"86"
                       customIdentifier:nil //自定义短信模板标识
                                 result:^(NSError *error)
    {
        
        if (!error)
        {
           // NSLog(@"block 获取验证码成功");
            [MBProgressHUD showSuccess:@"获取验证码成功"];
            
        }
        else
        {
            
          //  NSLog(@"block 获取验证码失败");
            [MBProgressHUD showError:@"获取验证码失败"];
            
        }
        
    }];

    

    
}
- (IBAction)getMessage:(UIButton *)sender {
    self.messageInfoText.text = nil;
    //获取验证码
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS
     //这个参数可以选择是通过发送验证码还是语言来获取验证码
                            phoneNumber:self.number
                                   zone:@"86"
                       customIdentifier:nil //自定义短信模板标识
                                 result:^(NSError *error)
     {
         
         if (!error)
         {
           //  NSLog(@"block 获取验证码成功");
             [MBProgressHUD showSuccess:@"获取验证码成功"];
             
         }
         else
         {
             
           //  NSLog(@"block 获取验证码失败");
             [MBProgressHUD showError:@"获取验证码失败"];
             
         }
         
     }];
    self.timeCount = 60;
    [self.timer setFireDate:[NSDate distantPast]];

}

- (IBAction)nextStep:(UIButton *)sender {
    [MBProgressHUD showMessage:@"正在验证..."];
    [SMSSDK  commitVerificationCode:self.messageInfoText.text
     //传获取到的区号
                        phoneNumber:self.number
                               zone:@"86"
                             result:^(NSError *error)
     {
         
         if (!error)
         {
           //  NSLog(@"验证成功");
             [MBProgressHUD showSuccess:@"验证成功"];
             UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
             RegisterPage2 *rsp = [sb instantiateViewControllerWithIdentifier:@"registerPage2"];
             rsp.rightNumber = self.number;
             [self.navigationController pushViewController:rsp animated:YES];
             [MBProgressHUD hideHUD];
             
         }
         else
         {
//             UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"错误" message:@"验证码输入错误" preferredStyle:UIAlertControllerStyleAlert];
//             UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
//             
//             
//             [ac addAction:returnAction];
//             [self presentViewController:ac animated:xrYES completion:nil];
             [MBProgressHUD showError:@"验证码错误"];
             [MBProgressHUD hideHUD];
             
         }
         
     }];
}
@end
