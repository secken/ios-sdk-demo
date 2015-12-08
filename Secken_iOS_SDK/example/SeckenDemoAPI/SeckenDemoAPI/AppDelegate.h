//
//  AppDelegate.h
//  SeckenDemoAPI
//
//  Created by Secken_ck on 15/9/21.
//  Copyright © 2015年 Secken_ck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSString * strDevice;     //通过改字符串可以证书推送
@property (nonatomic, retain) NSString * userName;      //授权SDK的用户名
@property (nonatomic, retain) NSString * userToken;     //授权SDK返回的Token

+(AppDelegate *)app;
@end

