//
//  PersonNamePage.m
//  Personal
//
//  Created by 薛立恒 on 15/10/26.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "PersonNamePage.h"
#import "PersonalInfo.h"
#import "InterviewPHPMethod.h"
@interface PersonNamePage ()

//@property (nonatomic, retain) NSMutableDictionary *dic;

@end

@implementation PersonNamePage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.dic = [NSMutableDictionary new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//在界面准备出现的时候
- (void)viewWillAppear:(BOOL)animated {
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    //显示导航栏
    self.navigationController.navigationBarHidden = NO;
    
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1]];
    
    
    self.title = @"我的昵称";
    
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.leftBarButtonItem.title = @"< 返回";
    
    self.tabBarController.tabBar.hidden = YES;
    
    self.finishButton.layer.cornerRadius = 3.0;
    PersonalInfo *personInfo = [PersonalInfo share];
    
    if (personInfo.UserName.length > 0) {
        self.nameText.text = personInfo.UserName;
    } else {
        self.nameText.text = personInfo.UserID;
        
    }
    
    
}


- (IBAction)finishChangeName:(UIButton *)sender {
    
    
    
    PersonalInfo *personInfo = [PersonalInfo share];
    personInfo.UserName = self.nameText.text;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    

    
}
@end
