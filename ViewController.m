//
//  ViewController.m
//  Liwushuo
//
//  Created by administrator on 15/10/15.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "ViewController.h"
#import "HTHorizontalSelectionList.h"
#import "ScanViewController.h"

@interface ViewController ()<HTHorizontalSelectionListDelegate, HTHorizontalSelectionListDataSource>

@property(nonatomic,strong)NSDictionary*dic;

@property (nonatomic, strong) HTHorizontalSelectionList *selectionList;

@property (nonatomic, strong) NSArray *carMakes;

@property (nonatomic,assign)NSUInteger dd;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"返回";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = returnButtonItem;


    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.selectionList = [[HTHorizontalSelectionList alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width, 30)];
    [self.selectionList setTitleColor:[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:1] forState:UIControlStateNormal];
    self.selectionList.delegate = self;
    self.selectionList.dataSource = self;
    
    self.carMakes = @[@"礼物",
                      @"美物",
                      @"运动",
                      @"娱乐",
                      @"美食",
                      @"数码"];
    
    [self.view addSubview:self.selectionList];

    
    
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1]];
    
    
    self.title = @"礼记";
    
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    //设置状态栏为白色
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
    
    
//    self.imageArray=@[@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4"];
    
    self.pageViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource=self;
    self.pageViewController.delegate=self;
    
    FoodViewController*startingViewController=[self viewControllerAtIndex:0];
    
    
    NSArray*viewControllers=@[startingViewController];
    
    
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    
    self.pageViewController.view.frame=CGRectMake(0, 35, self.view.frame.size.width, self.view.frame.size.height+100);
    
    
    
    [self addChildViewController:self.pageViewController];
    
    
    [self.view addSubview:self.pageViewController.view];
    
//    [self.pageViewController didMoveToParentViewController:self];
    

    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(FoodViewController*)viewControllerAtIndex:(NSUInteger)index{
        FoodViewController*pageContentViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"PageContentController"];
    
     pageContentViewController.pageIndex=index;
    
    pageContentViewController.imagename=self.imageArray[index];
    
    self.dd=index;
   // NSLog(@"current page index:%ld", index);
    [self performSelector:@selector(changeSelectButton)  withObject:nil afterDelay:0.5f];
        return pageContentViewController;
}

#pragma mark-------PageView Delegate--------------------------
//-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
//
//    NSUInteger index=((FoodViewController*)viewController).pageIndex;
//    
//    if ((index==0)||(index==NSNotFound)) {
//        
//        return nil;
//    }
//    
//    index--;
//    
//    NSLog(@"右划：%ld", index);
//  
////    [self performSelector:@selector(changeSelectButton)  withObject:nil afterDelay:0.5f];
//    
//    
//      NSLog(@"左");
//
//    return [self viewControllerAtIndex:index];
//}

- (void)changeSelectButton {

  //  NSLog(@"开始划动：%ld", self.dd);
    
    [self.selectionList changeSelectButton:self.dd];
}


//-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
//    
//    
//    NSUInteger index=((FoodViewController*)viewController).pageIndex;
//    
//  
//   
//    if(index==NSNotFound||index>=5){
//        
//        return nil;
//    }
//    
//    index++;
//    
//    NSLog(@"左划：%ld", index);
//    
////    [self performSelector:@selector(changeSelectButton)  withObject:nil afterDelay:0.5f];
//  
//   // [NSThread detachNewThreadSelector:@selector(change) toTarget:self withObject:nil];
//    
//
//    
////    
////    dispatch_async(dispatch_get_main_queue() , ^{
////        
////        HTHorizontalSelectionList*hth=(HTHorizontalSelectionList*)[self.view viewWithTag:1];
////        
////        
////        [hth changeSelectButton:index];
////       
////        
////        
////        
////    });
////    
////    HTHorizontalSelectionList*hth=(HTHorizontalSelectionList*)[self.view viewWithTag:1];
////    
////    
////    [hth changeSelectButton:index];
//  
//     return [self viewControllerAtIndex:index];
//    
//   
//}

#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    
    return self.carMakes.count;
    
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
    
    
    
    
    return self.carMakes[index];

  
}

#pragma mark - HTHorizontalSelectionListDelegate Protocol Methods

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    
    FoodViewController*startingViewController=[self viewControllerAtIndex:index];
    
    NSArray*viewControllers=@[startingViewController];
    
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    

}

-(NSInteger)index:(HTHorizontalSelectionList*)selectionList withviewcontorell:(UIViewController *)viewController{
    
   
    
  NSUInteger index=((FoodViewController*)viewController).pageIndex;
    
    
    return index;
    

}
-(IBAction)erweima:(id)sender{
  
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"scan" bundle:nil];
    ScanViewController *nc = [sb instantiateViewControllerWithIdentifier:@"scan"];
    [self.navigationController pushViewController:nc animated:YES];

}





@end
