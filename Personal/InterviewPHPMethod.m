//
//  InterviewPHPMethod.m
//  Personal
//
//  Created by 薛立恒 on 15/10/26.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "InterviewPHPMethod.h"

@implementation InterviewPHPMethod

//- (instancetype)init:(NSString *)PHPName and:(NSString *)objectSt {
//    if (self = [super init]) {
//        _PHPName = self.PHPName;
//        _objectStr = self.objectStr;
//    }
//    return self;
//}

//head图片的地址
//http://192.168.1.120:8888/upload/head/1.png



+ (NSMutableURLRequest *)interviewPHP:(NSString *)PHPName and:(NSString *)objectSt{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://114.215.126.243/Lee/MyApache-PHP/%@",PHPName]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 10;
    request.HTTPMethod = @"POST";
    NSString *str = [NSString stringWithFormat:@"%@",objectSt];
    request.HTTPBody = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    return request;
}


@end
