//
//  WellcomeView.h
//  Wellcome
//
//  Created by administrator on 15/10/21.
//  Copyright © 2015年 lyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WellcomeViewDelegate <NSObject>

- (void)onDoneButtonPressed;

@end

@interface WellcomeView : UIView

@property id<WellcomeViewDelegate>delegate;

@end
