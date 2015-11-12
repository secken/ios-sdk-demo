//
//  SCVerifyController.h
//  CreateSDK
//
//  Created by Secken_ck on 15/9/19.
//  Copyright © 2015年 Secken_ck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SeckenSDK/SeckenSDK.h>


@interface SCVerifyController : UIViewController


//成功的回调
@property (nonatomic, copy) void (^successBlock)(id operation);
//失败的回调
@property (nonatomic, copy) void (^failBlock)(id operation);


//当前Controller的title
@property (nonatomic, strong) NSString * strTitle;

//通过SeckenSDK 授权获取到的token
@property (nonatomic, strong) NSString * strToken;

//需要显示出来的logo
@property (nonatomic, strong) NSString * logoImage;

//需要显示出来的详情
@property (nonatomic, strong) NSString * strDescContent;

//用户名
@property (nonatomic, strong) NSString * strUserName;

//ip地址
@property (nonatomic, strong) NSString * strIPAddress;

//App名字
@property (nonatomic, strong) NSString * strAppName;

//验证类型
@property (nonatomic, assign) int       authType;

//EventID
@property (nonatomic, strong) NSString * strEventID;

@end
