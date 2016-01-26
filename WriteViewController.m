//
//  WriteViewController.m
//  LeeNote
//
//  Created by administrator on 15/10/15.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import "WriteViewController.h"

@interface WriteViewController ()

@end

@implementation WriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.writefile resignFirstResponder];
    
    self.finishbutton.layer.cornerRadius = 5;
    
    self.writefile.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self.writefile setReturnKeyType:UIReturnKeyDone];
    
    [self.writefile setDelegate:self];
    
    if (self.writecoreindexpath.row == 0) {
        [self.writefile setKeyboardType:UIKeyboardTypeDefault];
        self.title = @"商品名字";
    }
    else if (self.writecoreindexpath.row == 1){
       self.title = @"商品数量";
        [self.writefile setKeyboardType:UIKeyboardTypeDecimalPad];
    }
    else if (self.writecoreindexpath.row == 3){
        self.title = @"价格";
        [self.writefile setKeyboardType:UIKeyboardTypeDecimalPad];
        self.writefile.placeholder = @"人民币-￥";
    }


    self.writefile.text = self.filestring;
    [self.finishbutton addTarget:self action:@selector(finis:) forControlEvents:UIControlEventTouchUpInside];
    

    
}

-(void)finis:(UIButton*)sender{
   //完成时间在这里完成;
    
    if (self.writefile.text.length == 0){
    UIAlertController *uc =[UIAlertController alertControllerWithTitle:@"警告!" message:@"所填值不能为空!" preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *ac = [UIAlertAction actionWithTitle:@"返回再填写." style:UIAlertActionStyleCancel handler:nil];
    
    [uc addAction:ac];
        
    [self presentViewController:uc animated:YES completion:nil];
    }else{
   
    NSArray *valus = @[self.writefile.text,@(self.writecoreindexpath.row)];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"chosevalue" object:valus];
    
    [self.navigationController popViewControllerAnimated:YES];
        
}
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //设置输入文本长度为14,
    NSString*currentext = textField.text;
    
    if (self.writecoreindexpath.row !=4) {
        
    
    
    if(currentext.length +string.length >10){
        return NO;
    }else{
        return  YES;
    }
    }else{
    
        return YES;
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
 
    //主动弹出键盘
    //[textField becomeFirstResponder];
    //收回键盘
   [textField resignFirstResponder];
    return YES;
}


@end
