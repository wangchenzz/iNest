//
//  NSSktTOne.h
//  LeeNote
//
//  Created by administrator on 15/10/26.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSktTOne : NSObject

@property (nonatomic,copy) NSMutableString *ipstr;

+(instancetype)shareskt;


- (void)fina:(void (^)(NSString *one ,NSString *b))myblock;


-(void)requeset:(NSMutableURLRequest*)reqest :(void (^)(NSData*dat,NSError*er,NSDictionary *ary))myblockd;


-(NSData*)encodingStr:(NSString*)str;


- (void)uploadImage:(NSString *)name filename:(NSString *)filename mimeType:(NSString *)mimeType data:(NSData *)data parmas:(NSDictionary *)params block:(void (^)())myblockd;


-(NSMutableURLRequest*)requestForObject:(NSString*)badystring somePhpFile:(NSString*)phpStr;

-(void)getRequeset:(NSURLRequest *)reqest :(void (^)(NSData *dat, NSError *er, NSDictionary *dic))myblockd;

-(NSURLRequest*)requestforPhpfile:(NSString*)phpstr;
@end
