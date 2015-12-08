//
//  SeckenSDK.h
//  CreateSDK
//
//  Created by Secken_ck on 15/9/13.
//  Copyright (c) 2015年 Secken_ck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SeckenVoiceTrain.h"        
#import "SeckenVoiceConfirm.h"
#import "SeckenVoiceDelete.h"

@interface SeckenSDK : NSObject

/**
 说明 (instructions)
 初始化SDK (To initialize the SDK)
 
 参数 (parameter)
 appid:开发者申请应用的 appid (Apply for application developers appid)
 appkey:开发者申请应用的appkey (Apply for application developers appkey)
 
 返回 (The return value)
 SeckenSDK的实例 (the instance of SeckenSDK)
 
 例子 (example)
 [SeckenSDK registerAppID:@"xx" appKey:@"xx"];
 */
+(instancetype)registerAppID:(NSString *)appID appKey:(NSString *)appKey;


/**
 说明 (instructions)
 获取SeckenSDK (the instance of SeckenSDK)

 返回(The return value)
 SeckenSDK的实例 (the instance of SeckenSDK)
 
 例子 (example)
 [SeckenSDK currSeckenSDK]";
 */
+(instancetype)currSeckenSDK;


/**
 说明 (instructions)
 授权接口 (Authorization interface)
 
 参数 (parameter)
 strUserName:开发者app的用户名 (Developers of the app user name)
 bindSuccess:返回授权成功的结果 (Return authorization successful results)
 bindFail:返回授权失败的结果 (The results of the return authorization failure)
 */
-(void)bindUserName:(NSString *)strUserName
        bindSuccess:(void (^)(id operation))success
           bindFail:(void (^)(id operation))fail;


/**
 说明 (instructions)
 取消授权 (Cancel the authorization)
 
 参数 (parameter)
 strUserName:开发者app的用户名 (Developers of the app user name)
 token:授权接口返回的Token (Authorization Token returned by the interface)
 unBindSuccess:取消授权成功 (Cancel the authorization success)
 unBindFail:取消授权失败 (Cancel the authorization failure)
 
 */
-(void)unBindUserName:(NSString *)strUserName
                token:(NSString *)strToken
        unBindSuccess:(void (^)(id operation))success
           unBindFail:(void (^)(id operation))fail;

/**
 说明 (instructions)
 二维码扫描 (Qr code scanning)

 参数 (parameter)
 strQR:二维码地址 (Qr code address)
 token:授权接口返回的Token (Authorization Token returned by the interface)
 strUserName:开发者app的用户名 (Developers of the app user name)
 strLon:经度 (longitude)
 strLat:纬度 (latitude)
 authSuccess:扫描成功 (Scan success)
 authFail:扫描失败 (Scan fail)
 
 */
-(void)authQR:(NSString *)strQR
        token:(NSString *)strToken
     userName:(NSString *)strUserName
    longitude:(NSString *)strLon
     latitude:(NSString *)strLat
  authSuccess:(void (^)(id operation))success
     authFail:(void (^)(id operation))fail;


/**
 说明 (instructions)
 确认接口 (Confirm the interface)

 参数 (parameter)
 token:授权接口返回的Token (Authorization Token returned by the interface)
 strUserName:开发者app的用户名 (Developers of the app user name)
 agr:是否确认，传@"1"表示确认，传@"0"表示否定 (If confirmed, the @ "1" said confirmation, @ "0" said no)
 eventID:二维码扫描成功后返回的eventID (After the success of the qr code scanning return eventID)
 authSuccess:成功 (success)
 authFail:失败 (fail)
 
 */
-(void)confirmToken:(NSString *)strToken
           userName:(NSString *)strUserName
              agree:(NSString *)agr
            eventID:(NSString *)event_ID
        authSuccess:(void (^)(id operation))success
           authFail:(void (^)(id operation))fail;



/**
 说明 (instructions)
 拉取消息 (Pull the message)

 参数 (parameter)
 strUserName:开发者app的用户名 (Pull the developer app user name)
 token:授权接口返回的Token (Authorization Token returned by the interface)
 pullSuccess:成功 (success)
 pullFail:失败 (fail)
 
 */
-(void)pullUserName:(NSString *)strUserName
              token:(NSString *)strToken
        pullSuccess:(void (^)(id operation))success
           pullFail:(void (^)(id operation))fail;


/**
 说明 (instructions)
 更新Push ID (Update Push ID)
 
 参数 (parameter)
 strUserName:开发者app的用户名 (Pull the developer app user name)
 token:授权接口返回的Token  (Authorization Token returned by the interface)
 pushID:新的PUSH ID (new Push ID)
 pushSuccess:成功 (Success)
 pushFail:失败 (fail)
 
 */
-(void)updatePushIdUserName:(NSString *)strUserName
                      token:(NSString *)strToken
                     pushID:(NSString *)strPushID
                PushSuccess:(void (^)(id operation))success
                   PushFail:(void (^)(id operation))fail;



/**
 说明 (instructions)
 人脸训练 (face train)

 参数 (parameter)
 strUserName:开发者app的用户名 (Pull the developer app user name)
 token:授权接口返回的Token (Authorization Token returned by the interface)
 image:训练人脸的图片 (The training face images)
 faceTraninSuccess:训练成功, 训练成功后会返回face_id (After the success of the training will return face_id)
 faceTraninFail:训练失败，训练失败后不会返回face_id (Training will not return to face_id after failure)
 
 */
-(void)faceTrainUserName:(NSString *)strUserName
                   token:(NSString *)strToken
                    step:(NSString *)strStep
               faceImage:(UIImage *)image
       faceTraninSuccess:(void(^)(id operation))success
          faceTraninFail:(void (^)(id operation))fail;



/**
 说明 (instructions)
 人脸删除 (Face Delete)
 
 参数 (parameter)
 strUserName:开发者app的用户名 (Pull the developer app user name)
 token:授权接口返回的Token (Authorization Token returned by the interface)
 faceDeleteSuccess:删除成功 (delete success)
 faceDeleteFail:删除失败 (delete fail)
 
 */
-(void)faceDeleteUserName:(NSString *)strUserName
                    token:(NSString *)strToken
        faceDeleteSuccess:(void(^)(id operation))success
           faceDeleteFail:(void (^)(id operation))fail;




/**
 说明 (instructions)
 人脸鉴定 (Face identification)

 参数 (parameter)
 strUserName:开发者app的用户名 (Pull the developer app user name)
 token:授权接口返回的Token (Authorization Token returned by the interface)
 image:需要鉴定的人脸图片 (Need to identify face images)
 faceCompareSuccess:鉴定成功 (Identification of success)
 faceCompareFail:鉴定失败 (Identification of fail)
 
 */
-(void)faceCompareUserName:(NSString *)strUserName
                     token:(NSString *)strToken
                 faceImage:(UIImage *)image
        faceCompareSuccess:(void(^)(id operation))success
           faceCompareFail:(void (^)(id operation))fail;




/**
 说明 (instructions)
 声纹训练 (Voiceprint Train)

 参数 (parameter)
 strUserName:开发者app的用户名 (Pull the developer app user name)
 token:授权接口返回的Token (Authorization Token returned by the interface)
 voiceTrainSuccess:声纹成功 (Voiceprint success)
 voiceTrainFail:声纹失败 (Voiceprint fail)
 */

-(void)voiceTrainUserName:(NSString *)strUserName
                    token:(NSString *)strToken
                     voiceTrainSuccess:(void(^)(id operation))success
           voiceTrainFail:(void (^)(id operation))fail;


/**
 说明 (instructions)
 声纹删除 (Voiceprint Delete)

 参数 (parameter)
 strUserName:开发者app的用户名 (Pull the developer app user name)
 token:授权接口返回的Token (Authorization Token returned by the interface)
 voiceDelSuccess:声纹删除成功 (Voiceprint deleted successfully)
 voiceDelSuccess:声纹删除失败 (Voiceprint deleted fail)
 
 */-(void)voiceDeleteUserName:(NSString *)strUserName
                        token:(NSString *)strToken
              voiceDelSuccess:(void(^)(id operation))success
                 voiceDelFail:(void (^)(id operation))fail;



/**
 说明 (instructions)
 绑定推送，通过回调获取推送内容 (Binding push, push content in the callback)
 */
-(void)observeResultPullBlock:(void (^)(id operation))result;

@end
