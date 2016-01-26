//
//  WellcomeView.m
//  Wellcome
//
//  Created by administrator on 15/10/21.
//  Copyright © 2015年 lyc. All rights reserved.
//

#import "WellcomeView.h"
#import "ViewController.h"
@interface WellcomeView ()<UIScrollViewDelegate>

@property (strong, nonatomic)UIScrollView *scrollView;
@property (strong, nonatomic)UIPageControl *pageControl;
@property (retain, nonatomic)UIView *holeView;
@property (retain, nonatomic)UIView *circleView;
//@property (assign, nonatomic)UIButton *doneButton;

@end

@implementation WellcomeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:self.frame];
        backgroundImageView.image = [UIImage imageNamed:@"0-0"];
        [self addSubview:backgroundImageView];
        self.scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
        //隐藏水平滚动条
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height * 0.82, self.frame.size.width, 10)];
        self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.0];
        
        self.pageControl.numberOfPages = 4;
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width * 4, self.scrollView.frame.size.height);
        [self addSubview:self.pageControl];
        
        [self createViewOne];
        [self createViewTwo];
        [self createViewThree];
        [self createViewFour];
        
        CGPoint scrollPoint = CGPointMake(0, 0);
        [self.scrollView setContentOffset:scrollPoint animated:YES];

    }
    return self;
}



- (void)createViewOne {
    UIView *view = [[UIView alloc]initWithFrame:self.frame];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:view.frame];
    
    //UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(view.frame.origin.x, self.frame.size.width * 0.3, self.frame.size.width , self.frame.size.height * 0.8)];
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height * 0.15, self.frame.size.width, self.frame.size.height)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:@"1-1"];
    [view addSubview:imageView];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height * 0.05, self.frame.size.width * 0.8, 60)];
    titleLabel.center = CGPointMake(self.center.x, self.frame.size.height * 0.1);
    titleLabel.text = [NSString stringWithFormat:@"Suitable"];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:40.0];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;//居中对齐
    titleLabel.numberOfLines = 0;
    [view addSubview:titleLabel];
    
    UILabel *descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.1, self.frame.size.height * 0.8, self.frame.size.width * 0.8, 60)];
    descriptionLabel.text = [NSString stringWithFormat:@"The Right Present"];
    descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20.0];
    descriptionLabel.textColor = [UIColor whiteColor];
    descriptionLabel.textAlignment = NSTextAlignmentCenter;//居中对齐
    descriptionLabel.numberOfLines = 0;
    [view addSubview:descriptionLabel];
    
    CGPoint labelCenter = CGPointMake(self.center.x, self.frame.size.height * 0.7);
    descriptionLabel.center = labelCenter;
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
}

- (void)createViewTwo {
    
    CGFloat originWidth = self.frame.size.width;
    CGFloat originHeight = self.frame.size.height;
   // NSLog(@"%f",originHeight);

    //UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, originWidth, originHeight)];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(originWidth ,0,originWidth,view.frame.size.height)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height * 0.05, self.frame.size.width * 0.8, 60)];
    titleLabel.center = CGPointMake(self.center.x, self.frame.size.height * 0.1);
    titleLabel.text = [NSString stringWithFormat:@"Object"];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:40.0];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;//居中对齐
    titleLabel.numberOfLines = 0;
    [view addSubview:titleLabel];
    
    //UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 20)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,self.frame.origin.y , self.frame.size.width , self.frame.size.height )];
    //UIImageView *imageView = [[UIImageView alloc]initWithFrame:view.frame];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:@"2-2"];
    [view addSubview:imageView];
  
    UILabel *descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.1, self.frame.size.height * 0.7, self.frame.size.width * 0.8, 60)];
    descriptionLabel.text = [NSString stringWithFormat:@"Whoever,Whatever and Whenever"];
    descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20.0];
    descriptionLabel.textColor = [UIColor whiteColor];
    descriptionLabel.textAlignment = NSTextAlignmentCenter;//居中对齐
    descriptionLabel.numberOfLines = 0;
    [view addSubview:descriptionLabel];
    
    CGPoint labelCenter = CGPointMake(self.center.x, self.frame.size.height * 0.7);
    descriptionLabel.center = labelCenter;
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
}

- (void)createViewThree {
    
    CGFloat originWidth = self.frame.size.width;
    //CGFloat originHeight = self.frame.size.height;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(originWidth * 2, 0, originWidth, originWidth) ];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height * 0.05, self.frame.size.width * 0.8, 60)];
    titleLabel.center = CGPointMake(self.center.x, self.frame.size.height * 0.1);
    titleLabel.text = [NSString stringWithFormat:@"Necessity"];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:40.0];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;//居中对齐
    titleLabel.numberOfLines = 0;
    [view addSubview:titleLabel];
    
    //UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.1, self.frame.size.height * 0.1, self.frame.size.height * 0.8, self.frame.size.width)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,self.frame.origin.y , self.frame.size.width , self.frame.size.height)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:@"3-3"];
    [view addSubview:imageView];
    
    UILabel *descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.1, self.frame.size.height * 0.8, self.frame.size.width * 0.8, 60)];
    descriptionLabel.text = [NSString stringWithFormat:@"You Needments"];
    descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20.0];
    descriptionLabel.textColor = [UIColor whiteColor];
    descriptionLabel.textAlignment = NSTextAlignmentCenter;//居中对齐
    descriptionLabel.numberOfLines = 0;
    [view addSubview:descriptionLabel];
    
    CGPoint labelCenter = CGPointMake(self.center.x, self.frame.size.height * 0.7);
    descriptionLabel.center = labelCenter;
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
}


- (void)createViewFour {
    
    CGFloat originWidth = self.frame.size.width;
    CGFloat originHeight = self.frame.size.height;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(originWidth * 3, 0, originWidth, originHeight) ];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height * 0.05, self.frame.size.width * 0.8, 60)];
    titleLabel.center = CGPointMake(self.center.x, self.frame.size.height * 0.1);
    titleLabel.text = [NSString stringWithFormat:@"Perfect"];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:40.0];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;//居中对齐
    titleLabel.numberOfLines = 0;
    [view addSubview:titleLabel];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,self.frame.origin.y , self.frame.size.width , self.frame.size.height)];
    //UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.1, self.frame.size.height * 0.1, self.frame.size.height * 0.8, self.frame.size.width)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:@"4-4"];
    [view addSubview:imageView];
    
    UILabel *descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.1, self.frame.size.height * 0.7, self.frame.size.width * 0.8, 60)];
    descriptionLabel.text = [NSString stringWithFormat:@"We Can Offer It"];
    descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20.0];
    descriptionLabel.textColor = [UIColor whiteColor];
    descriptionLabel.textAlignment = NSTextAlignmentCenter;//居中对齐
    descriptionLabel.numberOfLines = 0;
    [view addSubview:descriptionLabel];
    
    CGPoint labelCenter = CGPointMake(self.center.x, self.frame.size.height * 0.7);
    descriptionLabel.center = labelCenter;
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
    UIButton *goButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.1, self.frame.size.height * 0.85, self.frame.size.width * 0.8, 60)];
    [goButton setTintColor:[UIColor whiteColor]];
    [goButton setTitle:@"Let's Go!" forState:UIControlStateNormal];
    [goButton.titleLabel setFont:[UIFont fontWithName:@"HeldveticaNeue-Thin" size:18.0]];
    goButton.backgroundColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000];
    goButton.layer.borderColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000].CGColor;
    [goButton addTarget:self action:@selector(onFinishedIntroButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    goButton.layer.borderWidth =.5;
    goButton.layer.cornerRadius = 15;
    [view addSubview:goButton];

    
}


- (void)onFinishedIntroButtonPressed:(id)sender {
    [self.delegate onDoneButtonPressed];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWidth = CGRectGetWidth(self.bounds);
    CGFloat pageFraction = self.scrollView.contentOffset.x / pageWidth;
    self.pageControl.currentPage = roundf(pageFraction);
}



@end
