//
//  coujiangViewController.m
//  Personal
//
//  Created by why on 15/11/7.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "coujiangViewController.h"

#import "guajiang.h"

#import "FoodViewController.h"

#import "PersonalInfo.h"

#import "NSSktTOne.h"

@interface coujiangViewController ()

@property(nonatomic)NSMutableString*str;

@property(nonatomic)NSString*name;

@property(nonatomic)int x;
@end

@implementation coujiangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.retarin=NO;
    
    [self.view setFrame:CGRectMake(0, 100, 320, 568)];
  
    self.str=[NSMutableString string];
    
  //  NSLog(@"%d",self.count);
    
    guajiang *scratchView=[[guajiang alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    

    UIImageView *hideView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
 
    [hideView setImage:[UIImage imageNamed:@"gua"]];
    
    [scratchView setSizeBrush:50.0f];
    
    [scratchView setHideView:hideView];
    
    
    [self.view addSubview:scratchView];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    

    self.x = arc4random() % 2;
  
    if (self.x==1) {
   
        self.name=@"zhongjiang";
 
         PersonalInfo *personalInfo =[PersonalInfo share];
        
        NSSktTOne*skt1=[NSSktTOne shareskt];
        
        int x=38;
        
        NSString*urlstr=[NSString stringWithFormat:@"id=%@&cou=%d",personalInfo.UserID,x];
        
        
        [skt1 requeset:[skt1 requestForObject:urlstr somePhpFile:@"InsertCoupon.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
  
        }];
    
    }

    else
    
    {
        
        
        self.name=@"zhongjiang";

        
    }
    

    
    
    
    [imageView setImage:[UIImage imageNamed:self.name]];
    
    [self.view addSubview:imageView];
    
    [self.view sendSubviewToBack:imageView];
    
   

}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    

    
     NSSktTOne *skt1 = [NSSktTOne shareskt];
    
    
    [skt1 requeset:[skt1 requestForObject:[NSString stringWithFormat:@"UserID=%@",[PersonalInfo share].UserID] somePhpFile:@"updataWinner.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
        
       
    }];
    
    
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

@end
