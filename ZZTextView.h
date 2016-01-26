//
//  ZZTextView.h
//  Personal
//
//  Created by administrator on 15/11/28.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZTextView : UITextView

//字数的限制
@property (nonatomic,assign) NSInteger numLimited;


//提示文字

@property (nonatomic,copy) NSString * Placeholder;

//label的颜色

@property (nonatomic,retain) UIColor *LmiteLabelBackroundColor;

+(instancetype)text:(CGRect)frame;


-(void)showIn:(UIView*)superview;

@end
