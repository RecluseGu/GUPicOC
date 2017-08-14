//
//  MMCameraViewController.m
//  MMScanPic
//
//  Created by 王腾飞 on 2017/4/23.
//  Copyright © 2017年 王腾飞. All rights reserved.
//

#import "MMCameraViewController.h"
#import "MMPhotoViewController.h"
#import "CameraTopToolView.h"
#import "CameraBottomToolView.h"
#import <AVFoundation/AVFoundation.h>
#import "MMCameraConfig.h"
#import "YBPasterImageVC.h"

#define kScreenBounds   [UIScreen mainScreen].bounds
#define kScreenWidth  kScreenBounds.size.width
#define kScreenHeight kScreenBounds.size.height
@interface MMCameraViewController ()<AVCaptureMetadataOutputObjectsDelegate, CameraTopToolDelgate, CameraBottomDelegate>
//捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property(nonatomic, strong)AVCaptureDevice *captureDevice;
//AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property(nonatomic, strong)AVCaptureDeviceInput *captureDeviceInput;
//当启动摄像头开始捕获输入
@property(nonatomic, strong)AVCaptureMetadataOutput *captureMetadataOutput;
@property (nonatomic, strong)AVCaptureStillImageOutput *stillImageOutput;
//session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property(nonatomic, strong)AVCaptureSession *captureSession;
//图像预览层，实时显示捕获的图像
@property(nonatomic, strong)AVCaptureVideoPreviewLayer *videoPreviewLayer;

@property (nonatomic, strong)UIView *focusView;
//@property (nonatomic, strong)ALAssetsLibrary *assetsLibrary;
//@property (nonatomic, strong)NSArray <ALAsset *>*assetList;
@property (nonatomic, strong)CameraBottomToolView *bottomTool;
@end

@implementation MMCameraViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = GYLCOLOR(37, 37, 38);
    if ([self canUserCamear]) {
        [self setupCaptureSession];
        [self focusPoint];
        
        //[self showPhotoList];
    }else{
        return;
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = GYLCOLOR(37, 37, 38);
    if ([self canUserCamear]) {
        [self setupCaptureSession];
        [self focusPoint];
        
        //[self showPhotoList];
    }else{
        return;
    }
    
}

- (void)setupCaptureSession {
    
    // 1.创建会话
    
    self.captureSession = [[AVCaptureSession alloc] init];
    
    if ([self.captureSession canSetSessionPreset:AVCaptureSessionPresetHigh]) {
        self.captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    }
    
    // 2.创建输入设备
    
    self.captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([self.captureDevice lockForConfiguration:nil]) {
        if (self.captureDevice.autoFocusRangeRestrictionSupported) {
            self.captureDevice.autoFocusRangeRestriction = AVCaptureAutoFocusRangeRestrictionNear;
        }
        
        if (self.captureDevice.smoothAutoFocusSupported) {
            self.captureDevice.smoothAutoFocusEnabled = YES;
        }
        
        self.captureDevice.focusMode = AVCaptureFocusModeContinuousAutoFocus;
        self.captureDevice.exposureMode = AVCaptureExposureModeContinuousAutoExposure;
        
        [self.captureDevice unlockForConfiguration];
    }

    // 3.创建输入
    
    NSError *error = nil;
    
    self.captureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:&error];
    
    // 3.创建输出
    
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    
    self.stillImageOutput.outputSettings = @{AVVideoCodecKey : AVVideoCodecJPEG};
    
    // 4.连接输入与会话
    
    if ([self.captureSession canAddInput:self.captureDeviceInput]) {
        
        [self.captureSession addInput:self.captureDeviceInput];
        
    }
    
    // 5.连接输出与会话
    
    if ([self.captureSession canAddOutput:self.stillImageOutput]) {
        
        [self.captureSession addOutput:self.stillImageOutput];
        
    }
    
    // 6.预览画面
    
    self.videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    self.videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;

    self.videoPreviewLayer.frame = CGRectMake(0, 120, ScreenWidth, ScreenWidth);
    
    [self.view.layer addSublayer:self.videoPreviewLayer];
    
    [self startSession];
}

- (void)configCamera {
    if ([_captureDevice lockForConfiguration:nil]) {
        if ([_captureDevice isFlashModeSupported:AVCaptureFlashModeAuto]) {
            [_captureDevice setFlashMode:AVCaptureFlashModeAuto];
        }
        //自动白平衡
        if ([_captureDevice isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
            [_captureDevice setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
        }
        [_captureDevice unlockForConfiguration];
    }
}
- (void)startSession {
    if (![self.captureSession isRunning]) {                              
        dispatch_async([self globalQueue], ^{
            [self.captureSession startRunning];
        });
    }
}

- (void)stopSession {
    if ([self.captureSession isRunning]) {
        dispatch_async([self globalQueue], ^{
            [self.captureSession stopRunning];
        });
    }
}

- (dispatch_queue_t)globalQueue {
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

- (void)focusPoint {
    
    CameraTopToolView *topTool = [[CameraTopToolView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    topTool.delgate = self;
    [self.view addSubview:topTool];
    
    _bottomTool = [[CameraBottomToolView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 100, kScreenWidth, 100)];
    _bottomTool.delagate = self;
    [self.view addSubview:_bottomTool];
    
    _focusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    _focusView.layer.borderWidth = 1.0;
    _focusView.layer.borderColor =GYLCOLOR(247, 98, 96).CGColor;
    _focusView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_focusView];
    _focusView.hidden = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(focusGesture:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (BOOL)canSwitchCameras {                                                  
    return self.cameraCount > 1;
}

- (NSUInteger)cameraCount {                                                 
    return [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
}
- (AVCaptureDevice *)activeCamera {                                         
    return self.captureDeviceInput.device;
}
- (AVCaptureDevice *)inactiveCamera {                                       
    AVCaptureDevice *device = nil;
    if (self.cameraCount > 1) {
        if ([self activeCamera].position == AVCaptureDevicePositionBack) {
            device = [self cameraWithPosition:AVCaptureDevicePositionFront];
        } else {
            device = [self cameraWithPosition:AVCaptureDevicePositionBack];
        }
    }
    return device;
}
- (void)switchBackAndFrontCamera{
    if (![self canSwitchCameras]) {
        return;
    }

    CATransition *animation = [CATransition animation];
    animation.duration = .5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"oglFlip";
    
    NSError *error;
    AVCaptureDevice *videoDevice = [self inactiveCamera];                   
    AVCaptureDeviceInput *videoInput =
    [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
    
    if (videoInput) {
        [self.captureSession beginConfiguration];                           
        [self.captureSession removeInput:self.captureDeviceInput];          
        if ([self.captureSession canAddInput:videoInput]) {
            [self.captureSession addInput:videoInput];
            self.captureDeviceInput = videoInput;
            animation.subtype = kCATransitionFromLeft;
        } else {
            [self.captureSession addInput:self.captureDeviceInput];
            animation.subtype = kCATransitionFromRight;
        }
        [self.captureSession commitConfiguration];
        [self.videoPreviewLayer addAnimation:animation forKey:nil];
    }else {
        NSLog(@"toggle carema failed, error = %@", error);
    }
    
}
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position ) return device;
    return nil;
}
- (void)focusGesture:(UITapGestureRecognizer*)gesture{
    CGPoint point = [gesture locationInView:gesture.view];
    [self focusAtPoint:point];
}
- (void)focusAtPoint:(CGPoint)point {
    BOOL isContain = CGRectContainsPoint(_videoPreviewLayer.frame, point);
    if (!isContain) {
        return;
    }
    CGSize size = self.view.bounds.size;
    CGPoint focusPoint = CGPointMake( point.y /size.height ,1-point.x/size.width );
    NSError *error;
    if ([self.captureDevice lockForConfiguration:&error]) {
        
        if ([self.captureDevice isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            [self.captureDevice setFocusPointOfInterest:focusPoint];
            [self.captureDevice setFocusMode:AVCaptureFocusModeAutoFocus];
        }
        
        if ([self.captureDevice isExposureModeSupported:AVCaptureExposureModeAutoExpose ]) {
            [self.captureDevice setExposurePointOfInterest:focusPoint];
            [self.captureDevice setExposureMode:AVCaptureExposureModeAutoExpose];
        }
        
        [self.captureDevice unlockForConfiguration];
        _focusView.center = point;
        _focusView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            _focusView.transform = CGAffineTransformMakeScale(1.25, 1.25);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                _focusView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                _focusView.hidden = YES;
            }];
        }];
    }
    
}

#pragma - 保存至相册
- (void)saveImageToPhotoAlbum:(UIImage*)savedImage
{
    
    YBPasterImageVC *imageVC = [[YBPasterImageVC alloc] init];
    imageVC.originalImage = savedImage;
    
    [self.navigationController pushViewController:imageVC animated:YES];
    
    /*
    MMPhotoViewController *photoVC = [[MMPhotoViewController alloc] init];
    photoVC.image = savedImage;
    photoVC.frame = self.videoPreviewLayer.frame;
    photoVC.retakeBlock = ^{
        [self startSession];
    };
    [self.navigationController pushViewController:photoVC animated:YES];
     */
    
}
#pragma mark - 检查相机权限
- (BOOL)canUserCamear{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请打开相机权限" message:@"设置-隐私-相" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                
                [[UIApplication sharedApplication] openURL:url];
                
            }
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        /*
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请打开相机权限" message:@"设置-隐私-相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alertView.tag = 100;
        [alertView show];
         */
        return NO;
    }
    else{
        return YES;
    }
    return YES;
}

/*
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0 && alertView.tag == 100) {
        
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            
            [[UIApplication sharedApplication] openURL:url];
            
        }
    }
}
*/

#pragma mark CameraTopToolDelgate
- (void)closeCamera {
    //设置隐藏要在dismiss之前
    [UIApplication sharedApplication].statusBarHidden = NO;
    [self stopSession];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)reverseCamera:(BOOL)isOn {
    [self switchBackAndFrontCamera];
}
- (void)flashCamera:(BOOL)isOn {
    if ([_captureDevice lockForConfiguration:nil]) {
        if (!isOn) {
            if ([_captureDevice isFlashModeSupported:AVCaptureFlashModeOff]) {
                [_captureDevice setFlashMode:AVCaptureFlashModeOff];
            }
        }else{
            if ([_captureDevice isFlashModeSupported:AVCaptureFlashModeOn]) {
                [_captureDevice setFlashMode:AVCaptureFlashModeOn];
            }
        }
        [_captureDevice unlockForConfiguration];
    }
}

- (void)cameraRatio:(StyleCameraRatio)ratio {
    MMCameraConfig *config = [MMCameraConfig shareConfig];
    if (ratio == Style_camera_ratio_full) {
        GULog(@"full");
        self.videoPreviewLayer.frame = self.view.bounds;
        if ([self.captureSession canSetSessionPreset:AVCaptureSessionPresetHigh]) {
            self.captureSession.sessionPreset = AVCaptureSessionPresetHigh;
        }
    }else if (ratio == StyleCameraRatio_1_1) {
        GULog(@"11");
        self.videoPreviewLayer.frame = CGRectMake(0, config.ratio_1_1_point_y, config.ratio_1_1_width, config.ratio_1_1_height);
    }else if (ratio == Style_camera_ratio_3_4) {
        GULog(@"34");
        self.videoPreviewLayer.frame = CGRectMake(0, config.ratio_3_4_point_y, config.ratio_3_4_width, config.ratio_3_4_height);
        if ([self.captureSession canSetSessionPreset:AVCaptureSessionPresetPhoto]) {
            self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
        }
    }
}

//
//- (void)cameraRatio:(StyleCameraRatio)ratio {
//    
//    GULog(@"ratio:%lu", (unsigned long)ratio);
//    MMCameraConfig *config = [MMCameraConfig shareConfig];
//    if (ratio == StyleCameraRatio_1_1) {
//        GULog(@"11");
//        self.videoPreviewLayer.frame = CGRectMake(0, config.ratio_1_1_point_y, config.ratio_1_1_width, config.ratio_1_1_height);
//        if ([self.captureSession canSetSessionPreset:AVCaptureSessionPresetHigh]) {
//            self.captureSession.sessionPreset = AVCaptureSessionPresetHigh;
//        }
//    }else if (ratio == Style_camera_ratio_3_4) {
//        GULog(@"34");
//        self.videoPreviewLayer.frame = CGRectMake(0, config.ratio_3_4_point_y, config.ratio_3_4_width, config.ratio_3_4_height);
//    }else if (ratio == Style_camera_ratio_full) {
//        GULog(@"full");
//        self.videoPreviewLayer.frame = self.view.bounds;
//        if ([self.captureSession canSetSessionPreset:AVCaptureSessionPresetPhoto]) {
//            self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
//        }
//    }
//}

#pragma mark CameraBottomDelegate
- (void)shutterCamera {
    AVCaptureConnection * videoConnection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!videoConnection) {
        NSLog(@"take photo failed!");
        return;
    }
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == NULL) {
            return;
        }
        [self stopSession];
        NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        CFDictionaryRef metadata = CMCopyDictionaryOfAttachments(NULL, imageDataSampleBuffer, kCMAttachmentMode_ShouldPropagate);
        NSDictionary *meta = [[NSDictionary alloc] initWithDictionary:(__bridge NSDictionary *)(metadata)];
        CFRelease(metadata);
        NSLog(@"%@", meta);
        [self saveImageToPhotoAlbum:[UIImage imageWithData:imageData]];
        
    }];
}
/*
- (void)browsePhoto {
    JSImagePickerViewController *imagePickerViewController = [[JSImagePickerViewController alloc] init];
    imagePickerViewController.jSSelectedCompleteDelegete = _delegate;
    imagePickerViewController.assetList = _assetList;
    __weak typeof(self)weakSelf = self;
    imagePickerViewController.selectedCompleteBlock = ^{
        [UIApplication sharedApplication].statusBarHidden = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf stopSession];
            [weakSelf dismissViewControllerAnimated:YES completion:^{
            }];
        });

    };
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:imagePickerViewController];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

- (void)showPhotoList {
    JSImagePickerManager *manager = [[JSImagePickerManager alloc] init];
    _assetsLibrary = [[ALAssetsLibrary alloc] init];

    [manager enumerateAssets:self.assetsLibrary completeBlock:^(JSImagePickerManager *ds, BOOL succ) {
        if (succ) {
            _assetList = ds.assetList;
            _bottomTool.poster = [UIImage imageWithCGImage:_assetList.firstObject.defaultRepresentation.fullScreenImage scale:1.0 orientation:UIImageOrientationUp];

        }
    }];
    
}
 */

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)dealloc {
    
//    [UIApplication sharedApplication].statusBarHidden = NO;
    NSLog(@"dealloc ------");
}
@end
