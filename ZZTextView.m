//
//  ZZTextView.m
//  Personal
//
//  Created by administrator on 15/11/28.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "ZZTextView.h"

@interface ZZTextView ()

//显示字数限制的label
@property (nonatomic,weak)UILabel *numLmitedLabel;


//显示提示文字的label
@property (nonatomic,strong) UILabel *placeholderLabel;


//@property (nonatomic,assign) CGSize limitLabelSize;

@end

@implementation ZZTextView

-(void)setNumLimited:(NSInteger)numLimited{

    _numLimited = numLimited;
    
   // self.limitLabelSize = [self.numLmitedLabel.text sizeWithFont:self.numLmitedLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, self.numLmitedLabel.frame.size.height)];
    
//    self.limitLabelSize = [self.numLmitedLabel.text boundingRectWithSize:<#(CGSize)#> options:<#(NSStringDrawingOptions)#> attributes:<#(nullable NSDictionary<NSString *,id> *)#> context:<#(nullable NSStringDrawingContext *)#>]
    [self.numLmitedLabel setText:[NSString stringWithFormat:@"%lu/%ld",(unsigned long)self.text.length,numLimited]];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nowEdit:) name:UITextViewTextDidChangeNotification object:nil];

}

//-(void)setLimitLabelSize:(CGSize)limitLabelSize{

  //  _limitLabelSize = limitLabelSize;
    
//    [self.numLmitedLabel setFrame:CGRectMake(self.frame.size.width-_limitLabelSize.width, self.frame.size.height -20, _limitLabelSize.width, 20)];

//}

-(void)setPlaceholder:(NSString *)Placeholder{

    _Placeholder = Placeholder;
    self.placeholderLabel.text = _Placeholder;
   
//   [self addSubview:_placeholderLabel];
    
}

-(UILabel *)placeholderLabel{

    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 3, 320, 20)];
      //  newlabel.font = [UIFont systemFontOfSize:15];
        _placeholderLabel.font = [UIFont boldSystemFontOfSize:15];
        _placeholderLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1];
        //[_placeholderLabel setFrame:CGRectMake(0, 3, 320, 20)];
//        _placeholderLabel.text =@"123123123";
// [_placeholderLabel setBackgroundColor:[UIColor redColor]];
        [self addSubview:_placeholderLabel];
       // _placeholderLabel = newlabel;
//        ZZLog(@"label_______%@",_placeholderLabel.font);
//        ZZLog(@"textview_________%@",self.font);
    }
    return _placeholderLabel;
    

}

-(void)setLmiteLabelBackroundColor:(UIColor *)LmiteLabelBackroundColor{

    _LmiteLabelBackroundColor = LmiteLabelBackroundColor;
    
    [self.numLmitedLabel setBackgroundColor:_LmiteLabelBackroundColor];

}


-(UILabel *)numLmitedLabel{

    if (!_numLmitedLabel) {
    
        UILabel *numlabel = [[UILabel alloc]init];
        
       // [_numLmitedLabel setBackgroundColor:[UIColor grayColor]];
        
        [self addSubview:numlabel];
        
        
        [numlabel setFrame:CGRectMake(self.frame.size.width-100, self.frame.size.height-20, 100, 20)];
        
        [numlabel setTextAlignment:NSTextAlignmentRight];

        
        _numLmitedLabel = numlabel;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(beganEdit:) name:UITextViewTextDidBeginEditingNotification object:nil];
   
    }

    return _numLmitedLabel;
}


-(void)beganEdit:(NSNotification*)notifc{
    
    if (_placeholderLabel) {
        
        [self.placeholderLabel removeFromSuperview];
    }
}



-(void)nowEdit:(NSNotification*)notifc
{
    if (self.text.length > _numLimited) {
        self.text = [self.text substringToIndex:_numLimited];
        return;
    }
    if (!_numLmitedLabel) {
        return;
    }
    
    
    [_numLmitedLabel setFrame:CGRectMake(self.frame.size.width-100, self.frame.size.height-20+self.contentOffset.y, 100, 20)];

    [self.numLmitedLabel setText:[NSString stringWithFormat:@"%lu/%ld",(unsigned long)self.text.length,_numLimited]];

    ZZLog(@"我在打字为什么过不来？");
    
}

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setFont:[UIFont systemFontOfSize:20]];
        
    }

    return self;

}


+(instancetype)text:(CGRect)frame{

    return [[self alloc]initWithFrame:frame];

}

-(void)showIn:(UIView*)superview
{

    [superview addSubview:self];
    
    if (self.text.length != 0) {
        if (_numLmitedLabel) {
            
            [self.numLmitedLabel setText:[NSString stringWithFormat:@"%lu/%ld",(unsigned long)self.text.length,_numLimited]];
    
        }
        if (_placeholderLabel) {
            
        
            [_placeholderLabel removeFromSuperview];
    
        }
        
    }
    
}

-(void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextViewTextDidBeginEditingNotification object:nil];

}
@end
