//
//  oneview.m
//  啊实打实的
//
//  Created by why on 15/11/4.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "oneview.h"


@interface oneview() {

    CGContextRef _contextMask;
    CGImageRef _scratchCGImg;
    CGPoint currPonit;
    CGPoint prePoint;
  
}

@end

@implementation oneview

@synthesize sizeBrush;

-(id)initWithFrame:(CGRect)frame{


    self=[super initWithFrame:frame];
    
    if (self) {
        
        
        [self setOpaque:NO];
        
        self.sizeBrush=10.0;
        
        
    }
    
    return self;
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
  
    [super drawRect:rect];
    UIImage*imageToDraw=[UIImage imageWithCGImage:_scratchCGImg];
    
    [imageToDraw drawInRect:self.frame];
    
    
}

-(void)setHiddeView:(UIView *)hideview{
    
   
    CGColorSpaceRef coloSpace=CGColorSpaceCreateDeviceGray();
    
    CGFloat scale=[UIScreen mainScreen].scale;
    
    //获得当前传入View的CGImage
    UIGraphicsBeginImageContextWithOptions(hideview.bounds.size, NO, 0);
    hideview.layer.contentsScale=scale;
    [hideview.layer renderInContext:UIGraphicsGetCurrentContext()];
    CGImageRef hideCGImg=UIGraphicsGetImageFromCurrentImageContext().CGImage;
    UIGraphicsEndImageContext();
    
    //绘制Bitmap掩码
    size_t width=CGImageGetWidth(hideCGImg);
    size_t height=CGImageGetHeight(hideCGImg);
    
    CFMutableDataRef pixels;
    pixels=CFDataCreateMutable(NULL, width*height);
    
    //创建一个可变的dataRef 用于bitmap存储记录
    _contextMask = CGBitmapContextCreate(CFDataGetMutableBytePtr(pixels), width, height , 8, width, coloSpace, kCGImageAlphaNone);
    
    //数据提供者
    CGDataProviderRef dataProvider=CGDataProviderCreateWithCFData(pixels);
    
    //填充黑色背景 mask中黑色范围为显示内容 白色为不显示
    CGContextSetFillColorWithColor(_contextMask, [UIColor blackColor].CGColor);
    CGContextFillRect(_contextMask, self.frame);
    
    CGContextSetStrokeColorWithColor(_contextMask, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(_contextMask, self.sizeBrush);
    CGContextSetLineCap(_contextMask, kCGLineCapRound);
    
    CGImageRef mask=CGImageMaskCreate(width, height, 8, 8, width, dataProvider, nil, NO);
    _scratchCGImg=CGImageCreateWithMask(hideCGImg, mask);
    
    CGImageRelease(mask);
    CGColorSpaceRelease(coloSpace);

}

-(void)scratchViewFrom:(CGPoint)startPoint toEnd:(CGPoint)endPoint{
    float scale=[UIScreen mainScreen].scale;
    //CG的Y与UI的是反的 UI的y0在左上角 CG在左下
    CGContextMoveToPoint(_contextMask, startPoint.x*scale, (self.frame.size.height-startPoint.y)*scale);
    CGContextAddLineToPoint(_contextMask, endPoint.x*scale,(self.frame.size.height-endPoint.y)*scale);
    CGContextStrokePath(_contextMask);
    [self setNeedsDisplay];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch=[touches anyObject];
    currPonit=[touch locationInView:self];
    prePoint=[touch previousLocationInView:self];
    [self scratchViewFrom:prePoint toEnd:currPonit];
}

-(void)toucheseEnd:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    UITouch *touch=[touches anyObject];
    currPonit=[touch locationInView:self];
    prePoint=[touch previousLocationInView:self];
    [self scratchViewFrom:prePoint toEnd:currPonit];
}


-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
}

@end
