//
//  WebViewController.m
//  Liwushuo
//
//  Created by administrator on 15/10/20.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "WebViewController.h"
#import "MBProgressHUD+MJ.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString*str=@"https://detail.tmall.com/item.htm?id=521327380985&ali_refid=a3_420841_1006:1109486246:N:%E6%97%A9%E7%A7%8B%E6%96%B0%E6%AC%BE%E5%A5%97%E8%A3%85:d2797ee91371096cba1683c182ad8bb1&ali_trackid=1_d2797ee91371096cba1683c182ad8bb1&spm=a231k.7746419.1998587621.27.hrcLVe";
 
    NSURL*url=[NSURL URLWithString:str];
    
    NSURLRequest*request=[NSURLRequest requestWithURL:url];
    
  //  NSLog(@"加载页面");

    self.webview.delegate=self;
    
    [self.webview loadRequest:request];
    

    
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"加载中.."];
    

}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];

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
