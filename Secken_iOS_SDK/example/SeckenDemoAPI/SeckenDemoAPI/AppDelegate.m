//
//  AppDelegate.m
//  SeckenDemoAPI
//
//  Created by Secken_ck on 15/9/21.
//  Copyright © 2015年 Secken_ck. All rights reserved.
//

#import "AppDelegate.h"
//#import "Secken/SeckenSDK.h"
#import <SeckenSDK/SeckenSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


+(AppDelegate *)app{

   return [UIApplication sharedApplication].delegate;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self registerPushNotification];
    return YES;
}

#pragma mark 注册推送通知
- (void)registerPushNotification
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }else{
        // iOS7及之前版本注册
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
}

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
#endif
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *str =[NSString stringWithFormat:@"%@",deviceToken];
    // 注册成功，将deviceToken保存到应用服务器数据库中，因为在写向ios推送信息的服务器端程序时要用到这个
    NSRange range = NSMakeRange(1, 71);
    NSString *device = [str substringWithRange:range];
    NSString *strUrl = [device stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.strDevice = strUrl;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    //查看推送的内容
    NSLog(@"userInfo = %@", userInfo);
    
    //如果type == 1的话，代表推送有内容，通过 SDK的 pull来获取消息。
    if (1 == [[userInfo objectForKey:@"type"] intValue]) {
        
        //然后通过Pull接口拉取内容。
        [[SeckenSDK currSeckenSDK] pullUserName:self.userName
                                          token:self.userToken
                                    pullSuccess:^(id operation)
         {
             
             NSLog(@"pull ok  = %@", operation);
             UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"pull OK(成功)"
                                                           message:[operation description]
                                                          delegate:nil
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:@"OK (确定)", nil];
             [al show];
             
             
         } pullFail:^(id operation) {
             
             NSLog(@"pull fail = %@", operation);
             UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"pull fail(失败)"
                                                           message:[operation description]
                                                          delegate:nil
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:@"OK (确定)", nil];
             [al show];
             
         }];

    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
