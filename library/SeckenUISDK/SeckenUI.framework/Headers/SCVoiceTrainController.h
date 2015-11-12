//
//  SCVoiceTrainController.h
//  CreateSDK
//
//  Created by Secken_ck on 15/9/18.
//  Copyright (c) 2015年 Secken_ck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SeckenSDK/SeckenSDK.h>


@interface SCVoiceTrainController : UIViewController
{
    
}

//当前Controller的title
@property (nonatomic, strong) NSString * strTitle;

//通过SeckenSDK 授权获取到的token
@property (nonatomic, strong) NSString * strToken;

//用户名
@property (nonatomic, strong) NSString * strUserName;

//声音成功的回调
@property (nonatomic, copy) void (^successBlock)(id operation);

//声音失败的回调
@property (nonatomic, copy) void (^failBlock)(id operation);

@end
