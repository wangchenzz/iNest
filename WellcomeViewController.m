//
//  ViewController.m
//  Wellcome
//
//  Created by administrator on 15/10/21.
//  Copyright © 2015年 lyc. All rights reserved.
//

#import "WellcomeViewController.h"
#import "WellcomeView.h"
#import "ViewController.h"
@interface WellcomeViewController () <WellcomeViewDelegate>
@property (nonatomic, retain)WellcomeView *introView;
@end

@implementation WellcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
        
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"intro_screen_viewed"]) {
        self.introView = [[WellcomeView alloc]initWithFrame:self.view.frame];
        self.introView.delegate = self;
        //self.introView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:self.introView];
    }
}

#pragma mark - WellcomeViewDelegate

- (void)onDoneButtonPressed{
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.introView.alpha = 0;
    } completion:^(BOOL finished) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Choiceness" bundle:nil];
        
        ViewController *mc = [sb instantiateViewControllerWithIdentifier:@"well"];
        //[self presentViewController:mc animated:YES completion:nil];
//         UIStoryboard *sb1 = [UIStoryboard storyboardWithName:@"wellcome" bundle:nil];
//        WellcomeViewController *wc = [sb1 instantiateViewControllerWithIdentifier:@"wellcome"];
        
        [self.navigationController pushViewController:mc animated:YES];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
