//
//  WebViewController.h
//  Liwushuo
//
//  Created by administrator on 15/10/20.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD+MJ.h"
@interface WebViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end
