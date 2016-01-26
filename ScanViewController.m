//
//  ViewController.m
//  scan_qrcode_demo
//
//  Created by strivingboy on 14/11/3.
//
//

#import "ScanViewController.h"
#import "playViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (weak, nonatomic) IBOutlet UIView *sanFrameView;//扫描视图
//@property (weak, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic)UIView *boxView;//扫描框
@property (strong, nonatomic)CALayer *scanLayer;//扫描线
//@property (strong, nonatomic) IBOutlet UIView *transparentView;//半透明背景
@property (strong, nonatomic)NSTimer *timer;

@property (nonatomic) AVCaptureSession *captureSession;
@property (nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic) BOOL lastResut;
@end

@implementation ScanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _lastResut = YES;
    
    [self startReading];
    //隐藏tabBar
    self.tabBarController.tabBar.hidden = YES;
}

- (void)dealloc
{
    [self stopReading];
}


- (BOOL)startReading
{
    //[_button setTitle:@"停止" forState:UIControlStateNormal];
    // 获取 AVCaptureDevice 实例
    NSError * error;
    //初始化捕捉设备(AVCaptureDevice)
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 初始化输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
      //  NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    // 创建会话
    _captureSession = [[AVCaptureSession alloc]init];
    // 添加输入流
    [_captureSession addInput:input];
    // 初始化输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    // 添加输出流
    [_captureSession addOutput:captureMetadataOutput];
    
    // 创建dispatch queue.队列
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("扫描二维码", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    // 设置元数据类型 AVMetadataObjectTypeQRCode
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // 创建输出对象
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_sanFrameView.layer.bounds];
    [_sanFrameView.layer addSublayer:_videoPreviewLayer];
    
    
    self.sanFrameView.backgroundColor = [UIColor blackColor];
    
    
    
    UIImageView *toumingView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.sanFrameView.bounds.size.width, self.sanFrameView.bounds.size.height)];
    toumingView.image = [UIImage imageNamed:@"touming.png"];
    [self.sanFrameView addSubview:toumingView];
    
    //设置扫描区域

    captureMetadataOutput.rectOfInterest = CGRectMake(0.2f, 0.2f, 0.75f, 0.75f);
    
    
    //扫描框
    
    self.boxView = [[UIView alloc]initWithFrame:CGRectMake(self.sanFrameView.bounds.size.width * 0.15 - 1.5, self.sanFrameView.bounds.size.height * 0.12 + 4, self.sanFrameView.bounds.size.width * 0.7 + 5, self.sanFrameView.bounds.size.height * 0.6 -5.5)];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.boxView.bounds.size.width, self.boxView.bounds.size.height)];
    imageview.image = [UIImage imageNamed:@"scan.png"];
    imageview.alpha = 1.0f;
    [self.boxView addSubview:imageview];
    
    self.boxView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.boxView.layer.borderWidth = 1.5f;
    [self.sanFrameView addSubview:self.boxView];
    
    //扫描线
    self.scanLayer = [[CALayer alloc]init];
    self.scanLayer.frame = CGRectMake(0, 0, self.boxView.bounds.size.width, 3);
    self.scanLayer.backgroundColor = [UIColor greenColor].CGColor;
    //将扫描线添加到扫描框中去
    [self.boxView.layer addSublayer:self.scanLayer];
    //定时器控制扫描线移动
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
    [self.timer fire];
    
    UIView * lableView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - 80, self.sanFrameView.bounds.size.width, 80)];
    lableView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lableView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(lableView.bounds.size.width * 0.5 - 35, 5, 70, 70)];
    imageView.image = [UIImage imageNamed:@"tupian.png"];
    [lableView addSubview:imageView];
    
    // 开始扫描
    [_captureSession startRunning];
    
    return YES;
}

//实现扫描线移动
- (void)moveScanLayer:(NSTimer *)timer{
    CGRect frame = self.scanLayer.frame;
    if (self.boxView.frame.size.height < self.scanLayer.frame.origin.y) {
        frame.origin.y = 0;
        self.scanLayer.frame = frame;
    } else {
        frame.origin.y +=2;
        [UIView animateWithDuration:0.05 animations:^{
            self.scanLayer.frame = frame;
        }];
    }
}

- (void)stopReading
{
    //[_button setTitle:@"开始" forState:UIControlStateNormal];
    // 停止会话
    [_captureSession stopRunning];
    _captureSession = nil;
}

- (void)reportScanResult:(NSString *)result
{
    [self stopReading];
    if (!_lastResut) {
        return;
    }
    _lastResut = NO;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"二维码扫描"
    message:result delegate:nil cancelButtonTitle:@"自动跳转到播放器"otherButtonTitles: nil];
    [alert show];
    
    playViewController *nc = [[playViewController alloc]init];
    nc.codeUrl = @"http://10.110.5.73:8888/upload/record/myRecord.caf";
    [self.navigationController pushViewController:nc animated:YES];
    
    // 以及处理了结果，下次扫描
    _lastResut = YES;
}

- (void)systemLightSwitch:(BOOL)open
{

    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        if (open) {
            [device setTorchMode:AVCaptureTorchModeOn];
        } else {
            [device setTorchMode:AVCaptureTorchModeOff];
        }
        [device unlockForConfiguration];
    }
}

#pragma AVCaptureMetadataOutputObjectsDelegate

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
      fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        NSString *result;
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            result = metadataObj.stringValue;
            [self.timer invalidate];
        } else {
          //  NSLog(@"不是二维码");
        }
        [self performSelectorOnMainThread:@selector(reportScanResult:) withObject:result waitUntilDone:NO];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
