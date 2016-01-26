//
//  FenlieViewController.m
//  Liwushuo
//
//  Created by administrator on 15/10/20.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "FenlieViewController.h"

@interface FenlieViewController ()

@end

@implementation FenlieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor colorWithRed:240/255.0 green:80/255.0 blue:80/255.0 alpha:1]];
    
    self.pageViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"xixi"];
    
    FenlieLWViewController*lw=[self.storyboard instantiateViewControllerWithIdentifier:@"haha"];

    NSArray*array=@[lw];
    
    
    [self.pageViewController setViewControllers:array direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame=CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:self.pageViewController];
    
    
    [self.view addSubview:self.pageViewController.view];
//
    
    


}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
-(void)index1{


    FenleiGLViewController*lw=[self.storyboard instantiateViewControllerWithIdentifier:@"hehe"];
    
    NSArray*array=@[lw];
    
    
    [self.pageViewController setViewControllers:array direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame=CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height);


}

-(void)index0{
    

    FenlieLWViewController*lw=[self.storyboard instantiateViewControllerWithIdentifier:@"haha"];
    
    NSArray*array=@[lw];
    
    
    [self.pageViewController setViewControllers:array direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame=CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height);


    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)go:(id)sender {
    
    UISegmentedControl*seg=[[UISegmentedControl alloc]init];
    seg=sender;
    NSInteger index=seg.selectedSegmentIndex;
    
    switch (index) {
        case 0:
            [self index0];
          
            break;
            
            case 1:
           [self index1];
            break;
        default:
            break;
    }
    
    
}


@end
