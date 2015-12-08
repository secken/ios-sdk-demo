//
//  MainViewController.m
//  SeckenDemoAPI
//
//  Created by Secken_ck on 15/9/21.
//  Copyright © 2015年 Secken_ck. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import <SeckenSDK/SeckenSDK.h>


@interface MainViewController () <UIActionSheetDelegate, UIAlertViewDelegate>
{

    SeckenVoiceTrain            * voiceTrain;               //语音训练
    
    SeckenVoiceConfirm          * voiceConfirm;             //鉴定语音
    
    SeckenVoiceDelete           * voiceDelete;              //删除语音
    
    UIImageView                 * _preImg;                  //人脸预览
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    //创建一个滑动视图，并把Button和Label放到滑动视图上
    UIScrollView * sc = [[UIScrollView alloc] init];
    sc.frame = [UIScreen mainScreen].bounds;
    sc.contentSize = CGSizeMake(sc.frame.size.width, sc.frame.size.height + 100);
    sc.backgroundColor = [UIColor colorWithRed:74/255.0 green:144/255.0 blue:226/255.0 alpha:1];
    [self.view addSubview:sc];
    
    UIButton * btnQR = [self createBtnWithTitle:@"安全扫一扫" rect:
                        CGRectMake(10, 20, [UIScreen mainScreen].bounds.size.width - 20, 40)];
    [btnQR addTarget:self action:@selector(clickBtnQR) forControlEvents:UIControlEventTouchUpInside];
    [sc addSubview:btnQR];
    
    
    UIButton * btnQRConfirm = [self createBtnWithTitle:@"确认扫码" rect:
                               CGRectMake(10,70, btnQR.frame.size.width, 40)];
    [btnQRConfirm addTarget:self action:@selector(clickBtnQRConfirm) forControlEvents:UIControlEventTouchUpInside];
    [sc addSubview:btnQRConfirm];
    
    
    UIButton * btnPULL = [self createBtnWithTitle:@"推送" rect:CGRectMake(10, 120, btnQR.frame.size.width, 40)];
    [btnPULL addTarget:self action:@selector(clickBtnPULL) forControlEvents:UIControlEventTouchUpInside];
    [sc addSubview:btnPULL];
    
    
    
    UIButton * btnUpdatePushID = [self createBtnWithTitle:@"更新Push ID" rect:CGRectMake(10, 170, btnQR.frame.size.width, 40)];
    [btnUpdatePushID addTarget:self action:@selector(clickBtnPushID) forControlEvents:UIControlEventTouchUpInside];
    [sc addSubview:btnUpdatePushID];
    
    
    
    UIButton * btnFaceTrain = [self createBtnWithTitle:@"脸部训练" rect:CGRectMake(10, 220, btnQR.frame.size.width, 40)];
    [btnFaceTrain addTarget:self action:@selector(clickFaceTrain) forControlEvents:UIControlEventTouchUpInside];
    [sc addSubview:btnFaceTrain];
    
    
    UIButton * btnFaceConfirm = [self createBtnWithTitle:@"脸部识别" rect:CGRectMake(10, 270, btnQR.frame.size.width, 40)];
    [btnFaceConfirm addTarget:self action:@selector(clickFaceConfirm) forControlEvents:UIControlEventTouchUpInside];
    [sc addSubview:btnFaceConfirm];
    
    UIButton * btnFaceDel = [self createBtnWithTitle:@"删除脸部识别" rect:CGRectMake(10, 320, btnQR.frame.size.width, 40)];
    [btnFaceDel addTarget:self action:@selector(clickFaceDel) forControlEvents:UIControlEventTouchUpInside];
    [sc addSubview:btnFaceDel];
    
    
    UIButton * btnVoiceTrain = [self createBtnWithTitle:@"语音训练" rect:CGRectMake(10, 370, btnQR.frame.size.width, 40)];
    [btnVoiceTrain addTarget:self action:@selector(clickVoiceTrain) forControlEvents:UIControlEventTouchUpInside];
    [sc addSubview:btnVoiceTrain];
    
    
    UIButton * btnVoiceConfirm = [self createBtnWithTitle:@"语音识别" rect:CGRectMake(10, 420, btnQR.frame.size.width, 40)];
    [btnVoiceConfirm addTarget:self action:@selector(clickVoiceConfirm) forControlEvents:UIControlEventTouchUpInside];
    [sc addSubview:btnVoiceConfirm];
    
    
    UIButton * btnVoiceDel = [self createBtnWithTitle:@"删除声音" rect:CGRectMake(10, 470, btnQR.frame.size.width, 40)];
    [btnVoiceDel addTarget:self action:@selector(clickVoiceDel) forControlEvents:UIControlEventTouchUpInside];
    [sc addSubview:btnVoiceDel];
    
    
    UIButton * btnUnBind = [self createBtnWithTitle:@"解除绑定" rect:CGRectMake(10, 520, btnQR.frame.size.width, 40)];
    [btnUnBind addTarget:self action:@selector(clickUnBind) forControlEvents:UIControlEventTouchUpInside];
    [sc addSubview:btnUnBind];


    
}




-(UIButton *)createBtnWithTitle:(NSString *)title rect:(CGRect)r{
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = r;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor whiteColor];
    return btn;
    
}



-(void)clickBtnQR{
    
    
    [[SeckenSDK currSeckenSDK] authQR:@"http://yc"
                                token:self.token
                             userName:self.username
                            longitude:@"000.00"
                             latitude:@"000.00"
                          authSuccess:^(id operation)
    {
        
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Auth QR OK(成功)"
                                                      message:[operation description]
                                                     delegate:nil
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"OK（确定）", nil];
        [al show];
        
        NSLog(@"Auth QR OK(成功) :%@", operation);
        self.eventID = [operation objectForKey:@"eventID"];
        
    } authFail:^(id operation) {
        
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Auth QR Fail(失败)"
                                                      message:[operation description]
                                                     delegate:nil
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"OK（确定）", nil];
        [al show];

        
        NSLog(@"Auth QR Fail(失败) :%@", operation);

    }];
    
    
}

-(void)clickBtnQRConfirm{
    
    
    if (self.eventID == nil) {
        
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Tip(提示)"
                                                      message:@"No(没有)EventID"
                                                     delegate:nil
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"OK (确定)", nil];
        [al show];
        
    }else{
        
        [[SeckenSDK currSeckenSDK] confirmToken:self.token
                                       userName:self.username
                                          agree:@"1"
                                        eventID:nil
                                    authSuccess:^(id operation)
        {
            NSLog(@"confirmToken OK(成功) :%@", operation);
            UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"confirmToken OK(成功)"
                                                          message:[operation description]
                                                         delegate:nil
                                                cancelButtonTitle:nil
                                                otherButtonTitles:@"OK (确定)", nil];
            [al show];
            

        } authFail:^(id operation) {
            
            NSLog(@"confirmToken fail(失败) :%@", operation);
            UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"confirmToken fail(失败)"
                                                          message:[operation description]
                                                         delegate:nil
                                                cancelButtonTitle:nil
                                                otherButtonTitles:@"OK (确定)", nil];
            [al show];

        }];
    }
    
    
}


-(void)clickBtnPULL{
    
    
    //先通过resultPullBlock 监听推送状态，如果服务器有推送的话，Block内容会执行。这个是长连接推送。
    [[SeckenSDK currSeckenSDK] observeResultPullBlock:^(id operation) {
       
        //然后通过Pull接口拉取内容。
        [[SeckenSDK currSeckenSDK] pullUserName:self.username
                                          token:self.token
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
    }];
    
}





-(void)clickBtnPushID{
    
    //更新推送
    NSString * str = [AppDelegate app].strDevice;
    [[SeckenSDK currSeckenSDK] updatePushIdUserName:self.username token:self.token pushID:str PushSuccess:^(id operation) {
       
        NSLog(@"push ID ok  = %@", operation);
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"push OK(成功)"
                                                      message:[operation description]
                                                     delegate:nil
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"OK (确定)", nil];
        [al show];
        

    } PushFail:^(id operation) {
        
        NSLog(@"push ID fail  = %@", operation);
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"push fail(失败)"
                                                      message:[operation description]
                                                     delegate:nil
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"OK (确定)", nil];
        [al show];

        
    }];
}


-(void)closeImage{

    [_preImg removeFromSuperview];

    for (UIView * v in [self.view subviews]) {
        if ([v isKindOfClass:[UIButton class]]) {
            v.userInteractionEnabled = YES;
        }
    }
}

#pragma mark - Face Train
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {

        
        for (UIView * v in [self.view subviews]) {
            if ([v isKindOfClass:[UIButton class]]) {
                v.userInteractionEnabled = NO;
            }
        }
        
        self.view.exclusiveTouch = YES;
        _preImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TestFace.jpg"]];
        _preImg.userInteractionEnabled = YES;
        _preImg.frame = [UIScreen mainScreen].bounds;
        [self.view addSubview:_preImg];
        

        UIButton * closePreImg = [UIButton buttonWithType:UIButtonTypeCustom];
        closePreImg.frame = CGRectMake(10, _preImg.frame.size.height - 50, _preImg.frame.size.width - 20, 40);
        [closePreImg setTitle:@"Close (关闭)" forState:UIControlStateNormal];
        closePreImg.backgroundColor = [UIColor blueColor];
        [closePreImg setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [closePreImg addTarget:self action:@selector(closeImage) forControlEvents:UIControlEventTouchUpInside];
        [_preImg addSubview:closePreImg];
        
        
    }else if (buttonIndex == 1) {
        [self faceTrainStepValue:@"1"];
        
    }else if (buttonIndex == 2){
        [self faceTrainStepValue:@"2"];
        
    }else if (buttonIndex == 3){
        [self faceTrainStepValue:@"3"];

    }
}

-(void)faceTrainStepValue:(NSString *)value{

    UIImage * image = [UIImage imageNamed:@"TestFace.jpg"];
    [[SeckenSDK currSeckenSDK] faceTrainUserName:self.username token:self.token step:value faceImage:image faceTraninSuccess:^(id operation) {
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"faceTrain OK(成功 )"
                                                      message:[operation description]
                                                     delegate:nil
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"OK (确定)", nil];
        [al show];
        
    } faceTraninFail:^(id operation) {
        
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"faceTrain Fail(失败)"
                                                      message:[operation description]
                                                     delegate:nil
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"OK (确定)", nil];
        [al show];

        
    }];
}

-(void)clickFaceTrain{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Photo is ready(照片已准备好)"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel(取消)"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:
                                  @"preview Photo (预览照片)",
                                  @"Please FaceTrainOne(训练第一次)",
                                  @"Please FaceTrainTwo(训练第二次)",
                                  @"Please FaceTrainThr(训练第三次)",   nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

-(void)clickFaceConfirm{
    
    [[SeckenSDK currSeckenSDK] faceCompareUserName:self.username
                                             token:self.token
                                         faceImage:[UIImage imageNamed:@"TestFace.jpg"]
                                faceCompareSuccess:^(id operation)
    {
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"faceCompare OK(成功)"
                                                      message:[operation description]
                                                     delegate:nil
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"OK (确定)", nil];
        [al show];
        
    } faceCompareFail:^(id operation) {
        
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"faceCompare Fail(失败)"
                                                      message:[operation description]
                                                     delegate:nil
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"OK (确定)", nil];
        [al show];
    }];
    
}


-(void)clickFaceDel{
    
    [[SeckenSDK currSeckenSDK] faceDeleteUserName:self.username
                                            token:self.token
                                faceDeleteSuccess:^(id operation)
    {
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"faceDelete OK(成功)"
                                                      message:[operation description]
                                                     delegate:nil
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"OK (确定)", nil];
        [al show];

        
    } faceDeleteFail:^(id operation) {
        
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"faceDelete Fail(失败)"
                                                      message:[operation description]
                                                     delegate:nil
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"OK (确定)", nil];
        [al show];
    }];
    
}



-(void)clickVoiceTrain{
    
    NSString * userName = self.username;
    NSString * token = self.token;
    CGRect vTrainRect = CGRectMake( 0,
                                    0,
                                   [UIScreen mainScreen].bounds.size.width,
                                   [UIScreen mainScreen].bounds.size.height);
    voiceTrain = [[SeckenVoiceTrain alloc] initWithFrame:vTrainRect];

    //voiceTrain.titleLab.text = @"";  可以自定义导航Title的名称
    
    [self.view addSubview:voiceTrain];
    
    voiceTrain.resultBlock = ^(id operation){
    
        
        [[SeckenSDK currSeckenSDK] voiceTrainUserName:userName
                                                token:token
                                    voiceTrainSuccess:^(id operation)
         {
             UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Voice Train(成功)"
                                                           message:[operation description]
                                                          delegate:nil
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:@"OK (确定)", nil];
             [al show];
             
         } voiceTrainFail:^(id operation) {
             UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Voice Train Fail(失败)"
                                                           message:[operation description]
                                                          delegate:nil
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:@"OK (确定)", nil];
             [al show];
             
             
         }];
        

        
    };
    
    //[voiceTrain resultBlock:^(id operation) {
    //     }];
    [voiceTrain.cancelBtn addTarget:self action:@selector(reMoveVoiceTrain) forControlEvents:UIControlEventTouchUpInside];
}

/*
 移除 SeckenVoiceTrain 视图
 Remove SeckenVoiceTrain view
 */
-(void)reMoveVoiceTrain{
    [voiceTrain removeFromSuperview];
}



/*
 鉴定语音
 Identification of the voice
 */
-(void)clickVoiceConfirm{

    CGRect vConfirmRect = CGRectMake( 0,
                                   0,
                                   [UIScreen mainScreen].bounds.size.width,
                                   [UIScreen mainScreen].bounds.size.height);
    
    voiceConfirm = [[SeckenVoiceConfirm alloc] initWithFrame:vConfirmRect userNmae:self.username token:self.token SuccessBlock:^(id operation) {
        
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Voice Confirm OK(成功)"
                                                      message:[operation description]
                                                     delegate:nil
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"OK (确定)", nil];
        [al show];

        
    } FailBlock:^(id operation) {
        
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Voice Confirm NO(失败)"
                                                      message:[operation description]
                                                     delegate:nil
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"OK (确定)", nil];
        [al show];

    }];
    [voiceConfirm.cancelBtn addTarget:self action:@selector(removeConfirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:voiceConfirm];
    
}

/*
 移除 SeckenVoiceConfirm 视图
 Remove SeckenVoiceConfirm view
 */
-(void)removeConfirm{
    [voiceConfirm removeFromSuperview];
}


-(void)clickVoiceDel{
    
    voiceDelete = [[SeckenVoiceDelete alloc] initAndVoiceDelSuccessBlock:^(id operation) {
       
        [[SeckenSDK currSeckenSDK] voiceDeleteUserName:self.username token:self.token voiceDelSuccess:^(id operation) {
          
            UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Voice Delete(成功)"
                                                          message:[operation description]
                                                         delegate:nil
                                                cancelButtonTitle:nil
                                                otherButtonTitles:@"OK (确定)", nil];
            [al show];
            
        } voiceDelFail:^(id operation) {

            UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Voice Delete Fail(失败)"
                                                          message:[operation description]
                                                         delegate:nil
                                                cancelButtonTitle:nil
                                                otherButtonTitles:@"OK (确定)", nil];
            [al show];

        }];
        
    } delFailBlock:^(id operation) {
        
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Voice Delete Fail(失败)"
                                                      message:nil
                                                     delegate:nil
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"OK (确定)", nil];
        [al show];
        
    }];
    
}

-(void)clickUnBind{
    
    [[SeckenSDK currSeckenSDK] unBindUserName:self.username
                                        token:self.token
                                unBindSuccess:^(id operation)
    {
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"unBind Ok(成功)"
                                                      message:[operation description]
                                                     delegate:self
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"OK (确定)", nil];
        al.tag = 9000;
        [al show];
        
    } unBindFail:^(id operation) {
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"unBind Fail(失败)"
                                                      message:[operation description]
                                                     delegate:nil
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"OK (确定)", nil];
        [al show];
        
        
    }];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 9000) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 是否支持屏幕旋转
- (BOOL)shouldAutorotate {
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
