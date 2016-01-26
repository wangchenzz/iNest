//
//  PersonaDetailPage.m
//  Personal
//
//  Created by 薛立恒 on 15/10/26.
//  Copyright © 2015年 xueliheng. All rights reserved.
//


#import "PersonaDetailPage.h"
#import "PersonaDetailCell1.h"
#import "PersonaDetailCell2.h"
#import "PersonaDetailCell3.h"
#import "PersonalInfo.h"
#import "PersonNamePage.h"
#import "InterviewPHPMethod.h"
#import "MBProgressHUD+MJ.h"
#define IP "http://192.168.2.15:8888"

#define YYEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]

@interface PersonaDetailPage ()

@property (nonatomic, retain) UIImage *headImage;
@property (nonatomic, assign) NSInteger count;

@end

@implementation PersonaDetailPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.count = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//在界面准备出现的时候
- (void)viewWillAppear:(BOOL)animated {
    
    
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];

    //显示导航栏
    self.navigationController.navigationBarHidden = NO;
    
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1]];
    
    
    self.title = @"我的资料";
    
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.leftBarButtonItem.title = @"< 返回";
    
    self.tabBarController.tabBar.hidden = YES;
    

    
    
    PersonalInfo *personInfo = [PersonalInfo share];
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:0];
    PersonaDetailCell2 *cell = [self.personDetailTableView cellForRowAtIndexPath:index];
    
    if (personInfo.UserName.length > 0) {
        cell.cell2Addition.text= personInfo.UserName;
    } else {
        cell.cell2Addition.text = personInfo.UserID;
        personInfo.UserName = personInfo.UserID;
        
    }
    if (personInfo.ImageData.length == 0) {
        NSMutableURLRequest *request = [InterviewPHPMethod interviewPHP:@"Search.php" and:[NSString stringWithFormat:@"UserID=%@",personInfo.UserID]];
        
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:@"网路加载失败"];
                    personInfo.UserName = personInfo.UserID;
                    personInfo.ImageData = UIImagePNGRepresentation([UIImage imageNamed:@"headImage"]);
                });
                
            } else {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                NSData *data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.2.15:8888%@",dic[@"result2"]]]];
                personInfo.ImageData = data1;
                
                self.headImage = [UIImage imageWithData:personInfo.ImageData];
                if (dic[@"result3"] == nil) {
    //                personInfo.UserName = dic[@"result3"];
                    personInfo.UserName = personInfo.UserID;
                } else {
                    personInfo.UserName = dic[@"result3"];
    //            personInfo.UserName = personInfo.UserID;
                }
                dispatch_async(dispatch_get_main_queue(), ^{

                [self.personDetailTableView reloadData];
                });
            }
        }];
        [task resume];
    } else {
        
        self.headImage = [UIImage imageWithData:personInfo.ImageData];
    }

}

#pragma mark - tableviewdelegate
//有2个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


//每个分组里面有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    } else {
        return 1;
    }
    
}

//设置TableviewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalInfo *personInfo = [PersonalInfo share];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        PersonaDetailCell1 *cell = [self.personDetailTableView dequeueReusableCellWithIdentifier:@"PersonaDetailCell1"];
        //设置cell选中之后不会显示成灰色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.cell1Image.layer.cornerRadius = 15.0;
        cell.cell1Image.clipsToBounds = YES;
        
        if (self.headImage == nil) {
            cell.cell1Image.image = [UIImage imageNamed:@"headImage"];
        } else {
        
            cell.cell1Image.image = self.headImage;
        }
        return cell;
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        PersonaDetailCell2 *cell = [self.personDetailTableView dequeueReusableCellWithIdentifier:@"PersonaDetailCell2"];
        //设置cell选中之后不会显示成灰色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (personInfo.UserID.length == 0) {
            cell.cell2Addition.text = @"无";
        } else {
            if (!personInfo.UserName.length == 0) {
                cell.cell2Addition.text= personInfo.UserName;
            } else {
                cell.cell2Addition.text = personInfo.UserID;
                
            }
//            cell.cell2Addition.text = personInfo.UserID;
        }
        
        return cell;
    } else {
        PersonaDetailCell3 *cell = [self.personDetailTableView dequeueReusableCellWithIdentifier:@"PersonaDetailCell3"];
        //设置cell选中之后不会显示成灰色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    
    }

}

#pragma mark - UIImagePickerControllerDelegate,UINavigationControllerDelegate代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    PersonaDetailCell1 *cell = [self.personDetailTableView cellForRowAtIndexPath:index];
    cell.cell1Image.image = [editingInfo objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    
    [self uuuuu:cell];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)uuuuu:(PersonaDetailCell1 *)cell {
    NSIndexPath *index2 = [NSIndexPath indexPathForRow:1 inSection:0];
    
    PersonaDetailCell2 *cell2 = [self.personDetailTableView cellForRowAtIndexPath:index2];
    
    
    PersonalInfo *personInfo = [PersonalInfo share];
    personInfo.UserName = cell2.cell2Addition.text;
    NSString *headImagePath = [NSString stringWithFormat:@"/upload/head/%@.jpg",personInfo.UserID];
    NSMutableURLRequest *request = [InterviewPHPMethod interviewPHP:@"ChangeNickName.php" and:[NSString stringWithFormat:@"UserName=%@&HeadImagePath=%@&UserID=%@",cell2.cell2Addition.text,headImagePath,personInfo.UserID]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showError:@"网络加载失败"];
            });
            return ;
        } else {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([dic[@"info"] isEqualToString:@"is success"]) {
                    
             //       NSLog(@"修改成功");
                    
                } else {
                    
    //                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"错误" message:@"修改昵称失败" preferredStyle:UIAlertControllerStyleAlert];
    //                UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
    //                [ac addAction:returnAction];
    //                [self presentViewController:ac animated:YES completion:nil];
                    [MBProgressHUD showError:@"修改昵称失败"];
                }
            
            });
       
        }
        
    }];
                           
    [task resume];
    
    
    //    PersonalInfo *personInfo = [PersonalInfo share];
    
    NSString *headimagepath = [NSString stringWithFormat:@"%@.jpg",personInfo.UserID];
    //    NSIndexPath *index1 = [NSIndexPath indexPathForRow:0 inSection:0];
    //    PersonaDetailCell1 *cell = [self.personDetailTableView cellForRowAtIndexPath:index1];
    //    PersonaDetailCell1 *cell = [self.personDetailTableView dequeueReusableCellWithIdentifier:@"PersonaDetailCell1" forIndexPath:index];
    
    NSData *data = UIImagePNGRepresentation(cell.cell1Image.image);
//    NSLog(@"*********%@",data);
    personInfo.ImageData = data;
    
    
    [self upload:@"abc" filename:headimagepath mimeType:@"image/jpg" data:data parmas:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        PersonNamePage *pnp = [sb instantiateViewControllerWithIdentifier:@"personNamePage"];
        [self.navigationController pushViewController:pnp animated:YES];
    } else if (indexPath.section == 0 && indexPath.row == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
            ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            ipc.allowsEditing = YES;
            
            ipc.delegate = self;
            
            [self presentViewController:ipc animated:YES completion:nil];
            
            
        } else {
            UIAlertController *uc = [UIAlertController alertControllerWithTitle:@"警告" message:@"你的相册无法使用" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *acAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
            [uc addAction:acAction];
            [self presentViewController:uc animated:YES completion:nil];
        
        
        
        }
    
    }

}

- (IBAction)deletePersonalDetail:(UIButton *)sender {
    
//    PersonalInfo *personInfo = [PersonalInfo share];
//    personInfo.UserID = nil;

    
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        PersonalInfo *personInfo = [PersonalInfo share];
        [PersonalInfo clear];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:personInfo.UserID forKey:@"未登录"];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        //让数据速度存入nsuserdefaults；
        
        [ud synchronize];
        
        [MBProgressHUD showSuccess:@"已退出登录"];
    }];
    UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:sureAction];
    [ac addAction:returnAction];
    
    [self presentViewController:ac animated:YES completion:nil];

}

//-(void)dealloc{
//    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
//    PersonaDetailCell1 *cell = [self.personDetailTableView cellForRowAtIndexPath:index];
//    [self uuuuu:cell];

//    NSIndexPath *index2 = [NSIndexPath indexPathForRow:1 inSection:0];
//
//    PersonaDetailCell2 *cell2 = [self.personDetailTableView cellForRowAtIndexPath:index2];
//
//    
//    PersonalInfo *personInfo = [PersonalInfo share];
//    personInfo.UserName = cell2.cell2Addition.text;
//    NSString *headImagePath = [NSString stringWithFormat:@"/upload/head/%@.jpg",personInfo.UserID];
//    NSMutableURLRequest *request = [InterviewPHPMethod interviewPHP:@"ChangeNickName.php" and:[NSString stringWithFormat:@"UserName=%@&HeadImagePath=%@&UserID=%@",cell2.cell2Addition.text,headImagePath,personInfo.UserID]];
//    
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        
//            if ([dic[@"info"] isEqualToString:@"is success"]) {
//                
//                NSLog(@"修改成功");
//                
//            } else {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"错误" message:@"修改昵称失败" preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
//                [ac addAction:returnAction];
//                [self presentViewController:ac animated:YES completion:nil];
//                });
//            }
//        
////        
//    }];
//    [task resume];
    
    
//    NSString *headimagepath = [NSString stringWithFormat:@"%@.jpg",personInfo.UserID];
//    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
//    PersonaDetailCell1 *cell = [self.personDetailTableView cellForRowAtIndexPath:index];
////    PersonaDetailCell1 *cell = [self.personDetailTableView dequeueReusableCellWithIdentifier:@"PersonaDetailCell1" forIndexPath:index];
//    
//    NSData *data = UIImagePNGRepresentation(cell.cell1Image.image);
//    NSLog(@"*********%@",data);
//    personInfo.ImageData = data;
//    
//    
//    [self upload:@"abc" filename:headimagepath mimeType:@"image/jpg" data:data parmas:nil];
    
    
//}

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    self.count = 0;
//}

- (void)upload:(NSString *)name filename:(NSString *)filename mimeType:(NSString *)mimeType data:(NSData *)data parmas:(NSDictionary *)params {

    // 文件上传
//    NSURL *url = [NSURL URLWithString:@"http://192.168.1.106:8888/ChangePersonalInfo.php"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    request.HTTPMethod = @"POST";
    
    
    NSMutableURLRequest *request = [InterviewPHPMethod interviewPHP:@"ChangePersonalInfo.php" and:nil];
    
    //    NSString *str1 = [NSString stringWithFormat:@"name=%@&email=%@&pass=%@",self.nametext1.text,self.emailtext1.text,self.passtext1.text];
    //
    //    request.HTTPBody = [str1 dataUsingEncoding:NSUTF8StringEncoding];
    
    
    // 设置请求体
    NSMutableData *body = [NSMutableData data];
    
    /***************文件参数***************/
    // 参数开始的标志
    [body appendData:YYEncode(@"--YY\r\n")];
    // name : 指定参数名(必须跟服务器端保持一致)
    // filename : 文件名
    NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, filename];
    [body appendData:YYEncode(disposition)];
    NSString *type = [NSString stringWithFormat:@"Content-Type: %@\r\n", mimeType];
    [body appendData:YYEncode(type)];
    
    [body appendData:YYEncode(@"\r\n")];
    [body appendData:data];
    [body appendData:YYEncode(@"\r\n")];
    
    /***************普通参数***************/
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 参数开始的标志
        [body appendData:YYEncode(@"--YY\r\n")];
        NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n", key];
        [body appendData:YYEncode(disposition)];
        
        [body appendData:YYEncode(@"\r\n")];
        [body appendData:YYEncode(obj)];
        [body appendData:YYEncode(@"\r\n")];
    }];
    
    /***************参数结束***************/
    // YY--\r\n
    [body appendData:YYEncode(@"--YY--\r\n")];
    request.HTTPBody = body;
    
    // 设置请求头
    // 请求体的长度
    [request setValue:[NSString stringWithFormat:@"%zd", body.length] forHTTPHeaderField:@"Content-Length"];
    // 声明这个POST请求是个文件上传
    [request setValue:@"multipart/form-data; boundary=YY" forHTTPHeaderField:@"Content-Type"];
    
    // 发送请求

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
        //    NSLog(@"%@",error);
        }
    }];
    [task resume];
    
}














@end
