//
//  WaitSearchViewController.m
//  Liwushuo
//
//  Created by why on 15/10/31.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "WaitSearchViewController.h"

#import "MBProgressHUD+MJ.h"

@interface WaitSearchViewController ()

@end

@implementation WaitSearchViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initial];
    
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
-(void)initial{
    
    
    self.pageViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"Search"];
    
    
    SearchLWViewController*pageContentViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"SearchLw"];
    
    
    NSArray*viewControllers=@[pageContentViewController];
    
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame=CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:self.pageViewController];
    
    [self.view addSubview:self.pageViewController.view];
    
    
}
- (IBAction)lw:(id)sender {
    
    SearchLWViewController*pageContentViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"SearchLw"];
    
    
    NSArray*viewControllers=@[pageContentViewController];
    
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    
}

- (IBAction)gl:(id)sender {
    
    
    FoodViewController*pageContentViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"PageContentController"];
    pageContentViewController.imagename=@"1";
    
    NSArray*viewControllers=@[pageContentViewController];
    
    int a=1;
    
    pageContentViewController.A=a;
    

    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    
}
@end
