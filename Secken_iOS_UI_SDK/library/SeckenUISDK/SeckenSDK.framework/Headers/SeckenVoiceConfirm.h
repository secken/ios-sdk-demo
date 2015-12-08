//
//  SeckenVoiceConfirm.h
//  CreateSDK
//
//  Created by Secken_ck on 15/9/18.
//  Copyright (c) 2015年 Secken_ck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeckenVoiceConfirm : UIView

/*
 说明 （instructions）
 鉴定声纹界面 （Identification of voiceprint interface）
*/
-(instancetype)initWithFrame:(CGRect)frame
                    userNmae:(NSString *)username
                       token:(NSString *)token
                SuccessBlock:(void(^)(id operation))success
                FailBlock:(void(^)(id operation))fail;

@property (nonatomic, strong)   UILabel     * titleLab;     //导航的标题 (Title)
@property (nonatomic, strong)   UIButton    * cancelBtn;    //取消按钮  (Cancel)

@end
