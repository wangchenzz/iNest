//
//  NewVersionController.m
//  Personal
//
//  Created by administrator on 15/12/2.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "NewVersionController.h"

@interface NewVersionController ()<UIScrollViewDelegate>

@property (nonatomic,weak) UIScrollView *scrollview;


@property (nonatomic,weak) UIPageControl *pagecontrol;


@property (nonatomic,retain) NSArray * imageAry;

@end

#define LEE_WIDTH [[UIScreen mainScreen]bounds].size.width
#define LEE_HEIGHT [[UIScreen mainScreen]bounds].size.height

@implementation NewVersionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageAry = @[@"pho",@"0-0",@"3-3",@"4-4"];
    
    UIScrollView *scrollview = [[UIScrollView alloc]init];
    
    scrollview.frame = CGRectMake(0, 0, LEE_WIDTH, LEE_HEIGHT);
    
    scrollview.pagingEnabled = YES;
    
    scrollview.alwaysBounceHorizontal = NO;
    
    self.view.backgroundColor = [UIColor redColor];
    
    scrollview.delegate = self;
    
    scrollview.contentSize = CGSizeMake(LEE_WIDTH*self.imageAry.count, 0);
    
    scrollview.bounces = NO;
    
    [self.view addSubview:scrollview];
    
    self.scrollview = scrollview;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [pageControl setFrame:CGRectMake(LEE_WIDTH*.5-30, LEE_HEIGHT*0.93, 60, 0)];
    pageControl.numberOfPages = self.imageAry.count;
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1];
    pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
//    pageControl.centerX = scrollW * 0.5;
//    pageControl.centerY = scrollH - 50;
    [self.view addSubview:pageControl];
    
    self.pagecontrol = pageControl;

    for (int i = 0; i < self.imageAry.count; i++) {
        UIImageView *inImage = [[UIImageView alloc]initWithFrame:CGRectMake(LEE_WIDTH*i, 0, LEE_WIDTH, LEE_HEIGHT)];
        
        inImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imageAry[i]]];
        
        if (i == self.imageAry.count - 1) {
    
            [self addButton:inImage];
        }
        
        [self.scrollview addSubview:inImage];
    }
}

-(void)addButton:(UIImageView*)imageView{
    
    imageView.userInteractionEnabled = YES;
    
    UIButton*button = [[UIButton alloc]init];
    
    [button setFrame:CGRectMake(LEE_WIDTH*.5-75, LEE_HEIGHT*0.78, 150, 40)];

    [button setBackgroundColor:[UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1]];
    
    button.layer.cornerRadius = 9;
    
    button.layer.masksToBounds = YES;
    
    [button setTitle:@"开始使用礼记吧" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(beginLeeNote:) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:button];

}

-(void)beginLeeNote:(UIButton*)button{

    [[NSNotificationCenter defaultCenter]postNotificationName:@"beganLeeNote" object:nil];


}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.frame.size.width;
    // 四舍五入计算出页码
    self.pagecontrol.currentPage = (int)(page + 0.5);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{

    ZZLog(@"newVersionController dealloc");

}

@end
