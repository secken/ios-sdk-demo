//
//  SeckenVoiceTrain.h
//  CreateSDK
//
//  Created by Secken_ck on 15/9/17.
//  Copyright (c) 2015年 Secken_ck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeckenVoiceTrain : UIView
/*
 说明 （instructions）
 声纹训练界面 （Voiceprint training interface）
 */
-(instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, strong)   UILabel     * titleLab;                 //导航的标题 (Title)
@property (nonatomic, strong)   UIButton    * cancelBtn;                //取消按钮  (Cancel)
@property (nonatomic, strong)   NSString    * strUsername;              //用户名（Username）
@property (nonatomic, strong)   NSString    * strToken;                 //Token（Token）

@property (nonatomic, assign)   BOOL        isShowAlert;                //是否显示录音错误的提示，NO表示不显示，默认为NO


/*
 说明 （instructions）
 返回值（Return Value）
 hasVoice 返回0和1, 0代表声纹没有创建失败 (Return 0 s and 1 s and 0 mean voiceprint don't create failure)
 hasRegID 返回0和1, 0代表该声纹无法验证 (Returns 0 s and 1 s and 0 represents the voice print is unable to verify)
 */
@property (nonatomic, copy)     void (^resultBlock)(id operation);      //结果回调 (Block Result)

@end
