//
//  SCFaceTrainController.h
//  CreateSDK
//
//  Created by Secken_ck on 15/9/16.
//  Copyright (c) 2015年 Secken_ck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <SeckenSDK/SeckenSDK.h>


@interface SCFaceTrainController : UIViewController 

//当前Controller的title
@property (nonatomic, strong) NSString * strTitle;

//通过SeckenSDK 授权获取到的token
@property (nonatomic, strong) NSString * strToken;

//用户名
@property (nonatomic, strong) NSString * strUserName;

//训练成功后，是否Pop到上个界面。
@property (assign) BOOL isTipSuccessPop;

//脸部训练成功的回调
@property (nonatomic, copy) void (^successBlock)(id operation);

//脸部训练失败的回调
@property (nonatomic, copy) void (^failBlock)(id operation);

@end
