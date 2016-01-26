//
//  WriteYourIntroduceController.m
//  Personal
//
//  Created by administrator on 15/11/28.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "WriteYourIntroduceController.h"

#import "ZZTextView.h"

@interface WriteYourIntroduceController ()

@property (nonatomic,retain) ZZTextView *zz;

@end

@implementation WriteYourIntroduceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view setBackgroundColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1]];
    
    [self.zz showIn:self.view];
    
    
    UIBarButtonItem *rightbutton = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(sureUp:)];
    
    self.navigationItem.rightBarButtonItem = rightbutton;
    
    ZZLog(@"%@",self.zz.subviews);

    
}

-(void)setEditString:(NSString *)EditString{

    _EditString = EditString;
    
    self.zz.text = _EditString;
    
    self.zz.Placeholder = nil;
}


-(ZZTextView *)zz{

    if (!_zz) {
        _zz = [ZZTextView text:CGRectMake(0, 86, 320, 200)];
        
        _zz.numLimited = 50;
        
        _zz.Placeholder = @"添加你的描述吧~";
    }

    return _zz;

}


-(void)sureUp:(UIBarButtonItem*)item{
    
    if (self.zz.text.length <= self.zz.numLimited && self.zz.text.length != 0) {
        NSArray *valus = @[self.zz.text,@(4)];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"chosevalue" object:valus];
        
        [self.navigationController popViewControllerAnimated:YES];
        
      //  [self.navigationController popViewControllerAnimated:YES];

    }else{
    
        [MBProgressHUD showError:@"文字不符合要求"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
