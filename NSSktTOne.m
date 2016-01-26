//
//  NSSktTOne.m
//  LeeNote
//
//  Created by administrator on 15/10/26.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import "NSSktTOne.h"
#define inurl @"http://114.215.126.243/Lee/MyApache-PHP/"
#import "MBProgressHUD+MJ.h"

#import "MBProgressHUD+MJ.h"

@implementation NSSktTOne

static NSSktTOne *skt1;



+(instancetype)shareskt{
    if (skt1 == nil) {
        
        @synchronized(self) {
            
            skt1 = [[NSSktTOne alloc]init];
            
            skt1.ipstr = [inurl mutableCopy];
        }
        
    }
    
    
    
    return skt1;
    
}

    

//first dor;

- (void)fina:(void (^)(NSString *one ,NSString *b))myblock{

    NSString *a1 = @"jojo, 我不要做人了";
    
    NSString *a2 = @"来吧 普奇神父";
    myblock(a1,a2);
    
}


//通过已知的request得知data.error.dic;
-(void)requeset:(NSMutableURLRequest*)reqest :(void (^)(NSData*dat,NSError*er,NSDictionary *ary))myblockd{

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:reqest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
        
         NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        myblockd(data,error,dic);
            
        }else{
            
//            [MBProgressHUD hideHUD];
//            
//            
//        
//            [MBProgressHUD showMessage:@"连接失败"];
//            
//            [MBProgressHUD hideHUD];

        }
        
    }];
    
    [task resume];
    
}


//将字符串变为data;

-(NSData*)encodingStr:(NSString*)str{


    
    return [str dataUsingEncoding:NSUTF8StringEncoding];

    
}


//这里是上传图片和参数的方法;
- (void)uploadImage:(NSString *)name filename:(NSString *)filename mimeType:(NSString *)mimeType data:(NSData *)data parmas:(NSDictionary *)params block:(void (^)())myblockd{
    // 文件上传
    NSURL *url = [NSURL URLWithString:[inurl stringByAppendingString:@"load.php"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    
    request.HTTPMethod = @"POST";
    
    // 设置请求体
    NSMutableData *body = [NSMutableData data];
    
    /*文件参数*/
    // 参数开始的标志
    [body appendData:[self encodingStr:@"--YY\r\n"]];
 
    // name : 指定参数名(必须跟服务器端保持一致)
    
    //name = @"abc";
    
    // filename : 文件名
    NSString *disposition = [NSString stringWithFormat:@"Content-Disposition:form-data;name=\"%@\";filename=\"%@\"\r\n", name, filename];
    [body appendData:[self encodingStr:disposition]];
    
    
    //  mimeType = @"image/jpg"
    
    NSString *type = [NSString stringWithFormat:@"Content-Type:%@\r\n", mimeType];
    [body appendData:[self encodingStr:type]];
    [body appendData:[self encodingStr:@"\r\n"]];
    
    [body appendData:data];
    
    [body appendData:[self encodingStr:@"\r\n"]];
    
    /*普通参数*/
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 参数开始的标志
    [body appendData:[self encodingStr:@"--YY\r\n"]];
    NSString *disposition = [NSString stringWithFormat:@"Content-Disposition:form-data;name=\"%@\"\r\n", key];
    [body appendData:[self encodingStr:disposition]];
    [body appendData:[self encodingStr:@"\r\n"]];
    [body appendData:[self encodingStr:obj]];
    [body appendData:[self encodingStr:@"\r\n"]];

    }];
    
    /*参数结束*/
    // YY--\r\n
    [body appendData:[self encodingStr:@"--YY\r\n"]];
    request.HTTPBody = body;
    
    // 设置请求头
    // 请求体的长度
    [request setValue:[NSString stringWithFormat:@"%zd", body.length] forHTTPHeaderField:@"Content-Length"];
    // 声明这个POST请求是个文件上传
    [request setValue:@"multipart/form-data; boundary=YY" forHTTPHeaderField:@"Content-Type"];
    
     //发送请求
    [self requeset:request :^(NSData *dat, NSError *er, NSDictionary *ary) {
        
        myblockd();
    }];


}


//通过传入目的php名称和需要添加的bady
-(NSMutableURLRequest*)requestForObject:(NSString*)badystring somePhpFile:(NSString*)phpStr{

    NSURL *url = [NSURL URLWithString:[inurl stringByAppendingString:phpStr]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *str = [NSString stringWithString:badystring];
    request.HTTPBody = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    request.timeoutInterval = 10;
    
    return request;

}


-(NSURLRequest*)requestforPhpfile:(NSString*)phpstr{
    
    NSURL *url = [NSURL URLWithString:[inurl stringByAppendingString:phpstr]];
    
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    return request;
}


-(void)getRequeset:(NSURLRequest *)reqest :(void (^)(NSData *data, NSError *error, NSDictionary *dic))myblockd{
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:reqest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            
        
        
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        myblockd(data,error,dic);
        }else{
        
//            [MBProgressHUD hideHUD];
            
            ZZFunc;
           
//            [MBProgressHUD showMessage:@"连接失败"];
//        
//            [MBProgressHUD hideHUD];
        }
    }];
    [task resume];

}




@end

