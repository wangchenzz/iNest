//
//  ViewController.m
//  RecordToQRcode
//
//  Created by lyc on 15/11/6.
//  Copyright © 2015年 lyc. All rights reserved.
//

#import "savevoicecontroller.h"
#import "InterviewPHPMethod.h"
#import "CircularProgressView.h"
#import "ToggleButton.h"
#import <AVFoundation/AVFoundation.h>
#define kRecordAudioFile @"myRecord.caf"

#import "PersonalInfo.h"

#import "UMSocial.h"

#define YYEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]

@interface savevoicecontroller ()<CircularProgressViewDelegate,AVAudioRecorderDelegate,AVAudioPlayerDelegate>
@property (nonatomic,assign)int count;
@property (nonatomic,strong)AVAudioRecorder *audioRecorder;//音频录音机
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic, retain) NSString *urlStr;
@property (nonatomic, assign) int timerCount;

@property (nonatomic, assign)BOOL isRecord;


@property (unsafe_unretained, nonatomic) IBOutlet ToggleButton *playOrPauseButton;

@property (unsafe_unretained, nonatomic) IBOutlet CircularProgressView *circularProgressView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *timeLabel;
- (IBAction)clickPlayOrPause:(ToggleButton *)sender;
- (IBAction)clickStop:(id)sender;
@end

@implementation savevoicecontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:250/255.0 green:59/255.0 blue:70/255.0 alpha:1.0];
    self.circularProgressView.backColor = [UIColor colorWithRed:236/255.0
    green:236/255.0 blue:236/255.0 alpha:1.0];
    self.circularProgressView.progressColor = [UIColor colorWithRed:82/255.0 green:135/255.0 blue:237/255.0 alpha:1.0];
    self.circularProgressView.audioPath = [[NSBundle mainBundle]pathForResource:self.urlStr ofType:@"caf"];
    
    self.circularProgressView.lineWidth = 20;
    
    //set CircularProgressView delegate
    self.circularProgressView.delegate = self;
//    _audioPlayer.numberOfLoops = 1;//播放次数

    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 191, 191)];
    button1.backgroundColor = [UIColor whiteColor];
    button1.layer.borderColor = [UIColor darkGrayColor].CGColor;
    button1.layer.borderWidth = 1.0f;
    button1.tag = 1;
    button1.layer.cornerRadius = self.circularProgressView.bounds.size.height * 0.4;
    button1.layer.masksToBounds = YES;
    [button1 setImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(audioRecord:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.circularProgressView addSubview:button1];
    self.isRecord = NO;
    
    
    self.playOrPauseButton.enabled = NO;
    self.stopButton.enabled = NO;
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    UIBarButtonItem *fenxiangButton = [[UIBarButtonItem alloc]initWithTitle:@"分享给好友" style:UIBarButtonItemStylePlain target:self action:@selector(fenxiang:)];
    self.navigationItem.rightBarButtonItem = fenxiangButton;
//    fenxiangButton.title = @"分享";
//    [self.view addSubview:fenxiangButton];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.navigationItem setRightBarButtonItem:fenxiangButton];

}

- (void)fenxiang:(UIBarButtonItem *)sender {
    [self inviteFriends];

}

- (void)countAdd:(NSTimer *)timer {
    
    self.circularProgressView.duration = [[NSString stringWithFormat:@"%d",self.timerCount] doubleValue];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@",[self formatTime:(int)self.circularProgressView.duration + 1]];
    
    self.timerCount++;
    //[self.timer invalidate];
}


- (void)playTime:(NSTimer *)timer {
    if (self.timerCount > 0) {
        //self.timerCount = (self.timerCount/60) ;
        self.timerCount--;
    }
    
    if (self.timerCount <= 0) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
   self.timeLabel.text = [NSString stringWithFormat:@"00:%02d",self.timerCount];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//    self.timeLabel.text = [NSString stringWithFormat:@"00:%02d",self.timerCount];
//    });
    
  //  NSLog(@"~~~~~%@",self.timeLabel.text);
}

//录音
- (void)audioRecord:(UIButton *)sender
{
    
    self.playOrPauseButton.enabled = NO;
    self.stopButton.enabled = NO;
    
    [self setAudioSession];
    if (![self.audioRecorder isRecording]) {
        [self.audioRecorder record];
        self.isRecord = YES;
//        self.timer.fireDate = [NSDate distantPast];   开启定时器   future 暂停定时器；
        self.timerCount = 0;
        
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }else{
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countAdd:) userInfo:nil repeats:YES];
        }
    } else {
//        [self.audioPlayer stop];
        [self.audioRecorder stop];
        //[self.timer invalidate];
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
            //[self.timer setFireDate:[NSDate distantFuture]];
        }
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否保存并播放录音?" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            //点击确定按钮之后播放语音,并且让button1隐藏显示button2
            
            self.playOrPauseButton.enabled = YES;
            self.stopButton.enabled = YES;
            self.navigationItem.rightBarButtonItem.enabled = YES;
            [self save];
        }];
        
        UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"重录" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        }];
        [ac addAction:sureAction];
        [ac addAction:returnAction];
        [self presentViewController:ac animated:YES completion:nil];
    }
}


- (void)save {
    //NSURL *url =[self getSavePath];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *recordPath = [NSString stringWithFormat:@"%@/%@", path, kRecordAudioFile];
    
    NSFileHandle *handler = [NSFileHandle fileHandleForReadingAtPath:recordPath];
    NSData *data = [handler readDataToEndOfFile];
    
    [self upload:@"abc" filename:recordPath mimeType:@"video/caf" data:data parmas:nil];
    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
//    [request setHTTPMethod:@"POST"];
//    request setValue:@"video/caf" forHTTPHeaderField:<#(nonnull NSString *)#>
    
    
   // NSLog(@"上传文件");
}

//播放
- (IBAction)clickPlayOrPause:(ToggleButton *)sender {
//    _audioPlayer.numberOfLoops = 0;//播放次数
    UIButton *button = [self.view viewWithTag:1];
    button.enabled = NO;
    
    if (sender.on) {
        
        self.circularProgressView.audioPath = self.urlStr;
        [self.circularProgressView play];
        self.circularProgressView.playOrPauseButtonIsPlaying = YES;
        
        if (self.timer) {
            //[self.timer invalidate];
            [self.timer setFireDate:[NSDate distantPast]];
        }else{
            self.timerCount = self.circularProgressView.duration + 1;
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(playTime:) userInfo:nil repeats:YES];
        }

    }else {
        [self.circularProgressView pause];
        
        self.circularProgressView.playOrPauseButtonIsPlaying = NO;
         [self.timer setFireDate:[NSDate distantFuture]];
        button.enabled = YES;
    }
}

//- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
//
//self.playOrPauseButton.on = NO;
//
//}

- (IBAction)clickStop:(id)sender {
    [self.circularProgressView stop];
    self.playOrPauseButton.on = NO;
    self.circularProgressView.playOrPauseButtonIsPlaying = NO;
    
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark Circular Progress View Delegate method
- (void)updateProgressViewWithPlayer:(AVAudioPlayer *)player {
    //update timeLabel
//    self.timeLabel.text = [NSString stringWithFormat:@"%@",[self formatTime:(int)self.circularProgressView.duration]];
}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    self.playOrPauseButton.on = NO;
        [self.playOrPauseButton setImage:[UIImage imageNamed:@"pase@2x.png"] forState:UIControlStateNormal];
    
}

- (void)playerDidFinishPlaying{
    self.playOrPauseButton.on = NO;

    //= [UIImage imageNamed:@"pase@2x.png"];
}

//format audio time
- (NSString *)formatTime:(int)num{
    int sec = num % 60;
    int min = num / 60;
    return [NSString stringWithFormat:@"%02d:%02d",min,sec];
}


//#pragma mark - 长按手势录音实现方法
//- (void)longPressToRecord:(UILongPressGestureRecognizer *)recongnizer
//{
//    if (![self.audioRecorder isRecording]) {
//        [self.audioRecorder record];
//        self.timer.fireDate = [NSDate distantPast];
//    }
//}

#pragma mark - 录音方法
//获取录音机对象
//注意:使用get/set方法不能自调用(×× self.audioRecorder ××)
- (AVAudioRecorder *)audioRecorder
{
    if (!_audioRecorder) {
        //创建录音文件保存路径
        NSURL *url = [self getSavePath];
        //创建录音格式设置
        NSDictionary *setting = [self getAudioSetting];
        //创建录音机
        NSError *error = nil;
        _audioRecorder = [[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate = self;
        if (error) {
       //     NSLog(@"创建录音机失败,失败原因:%@",error);
            return nil;
        }
    }
    return _audioRecorder;
}

//设置音频会话
- (void)setAudioSession
{
    AVAudioSession *avSession = [AVAudioSession sharedInstance];
    //设置为播放和录音状态,以便可以在录制完之后播放录音
    [avSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [avSession setActive:YES error:nil];
}

//取得录音文件保存路径
- (NSURL *)getSavePath
{
    NSString *urlStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    self.urlStr = [urlStr stringByAppendingPathComponent:kRecordAudioFile];
  //  NSLog(@"file path:%@",self.urlStr);
    NSURL *url = [NSURL fileURLWithPath:self.urlStr];
    return url;
}

//录音设置
-(NSDictionary *)getAudioSetting
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //设置录音格式
    [dic setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    return dic;
}
//

//录音完成
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{

//        [self.audioPlayer play];
    
   
  //  NSLog(@"录音完成!");
}

#pragma mark - 录音上传

- (void)upload:(NSString *)name filename:(NSString *)filename mimeType:(NSString *)mimeType data:(NSData *)data parmas:(NSDictionary *)params {
    NSMutableURLRequest *request = [InterviewPHPMethod interviewPHP:@"uploadRecord.php" and:nil];
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
    //        NSLog(@"%@",error);
        }
    }];
    [task resume];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)inviteFriends {
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5636c41be0f55a34fc0019d4"
                                      shareText:[NSString stringWithFormat:@"我给你录了一段祝福,你点击链接听听吧:%@",self.urlStr]
                                     shareImage:[UIImage imageNamed:@"lijiHeadImage"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToQzone,UMShareToQQ,UMShareToWechatSession,nil]
                                       delegate:nil];
    
    
}

@end
