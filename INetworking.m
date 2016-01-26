//
//  INetworking.m
//  iTestAFNetworking
//
//  Created by administrator on 15/11/23.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import "INetworking.h"
#import "AFNetworking.h"

#import "MBProgressHUD/MBProgressHUD+MJ.h"

#import "MBProgressHUD+MJ.h"



#define IPADDRESS @"http://114.215.126.243/Lee/MyApache-PHP/"


typedef void(^wrong)();
static INetworking *network;

static BOOL isNetWorking = YES;


@implementation INetworking


-(void)setIpstr:(NSString *)ipstr{

    
    _ipstr = ipstr;
    
}


+(INetworking*)shareNet{

    if (!network) {
     
        network = [[self alloc]init];
        
        network.ipstr = IPADDRESS;
        
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
           
            switch (status) {
                    
                case AFNetworkReachabilityStatusNotReachable:{
                    
                    ZZLog(@"无网络");
                    
                    isNetWorking = NO;
                    
                    break;
                    
                }
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:{
                    
                    ZZLog(@"WiFi网络");
                    
                    break;
                    
                }
                    
                case AFNetworkReachabilityStatusReachableViaWWAN:{
                    
                    ZZLog(@"无线网络");
                    
                    break;
                    
                }
                    
                default:
                    
                    break;
                    
            }
            
        }];
        
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    }
    return network;
}

-(void)getRequest:(NSString*)phpStr do:(void(^)(id returnObject,BOOL isSuccess))myblok{

    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    session.requestSerializer.timeoutInterval = 10;
    
    session.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [session GET:[self.ipstr stringByAppendingString:phpStr] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
     
        myblok(responseObject,YES);
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    
        myblok(error,NO);
    }];
}

-(void)postRequest:(NSString*)object parameters:(id)parameters do:(void(^)(id returnObject,BOOL isSuccess))myblok{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    manager.requestSerializer.timeoutInterval = 10;
    
    [manager POST:[self.ipstr stringByAppendingString:object] parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        myblok(responseObject,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        myblok(error,NO);
        
    }];
}


// 下载；   //存放到document中了；
-(void)dowloadWithLoadString:(NSString*)urlstring{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:urlstring];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error){
        _errorDolowdToDo();
        }
    }];

    [downloadTask resume];

}

// 上传的方法’

-(void)uploadImage{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://example.com/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:[NSData data] name:@"abc" fileName:@"文件名" mimeType:@"image/jpeg"];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSProgress *progress = nil;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            ZZLog(@"%@",error);
        } else {
            ZZLog(@"%@ %@", response, responseObject);
        }
    }];
    [uploadTask resume];
}






-(void)orderDateDIYTradeInfp:(void(^)(id DT))todo;{
    
    

    [self getRequest:@"queryDIYOrderDate.php" do:^(id returnObject, BOOL isSuccess) {
        

        if (isSuccess) {
            
            //ZZLog(@"%@",LITTLENUM);
            
            //ZZLog(@"%@",BIGNUM);
        
        
        todo(returnObject);
        }else{
            
            
            ZZLog(@"%@",returnObject);
        
            ZZFunc;
            
          //  __block wrong ss;
            
           wrong ss = ^(){
            
                [MBProgressHUD showError:@"连接失败"];
            
            };
            
            
            MAIN(ss);
            
        
        }
    
    }];

}





@end
