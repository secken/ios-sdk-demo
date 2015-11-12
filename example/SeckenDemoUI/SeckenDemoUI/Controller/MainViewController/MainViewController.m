//
//  MainViewController.m
//  CreateSDK
//
//  Created by Secken_ck on 15/9/16.
//  Copyright (c) 2015年 Secken_ck. All rights reserved.
//

#import "MainViewController.h"
#import <SeckenUI/SCQRViewController.h>
#import <SeckenUI/SCFaceConfirmController.h>
#import <SeckenUI/SCFaceTrainController.h>
#import <SeckenUI/SCVoiceTrainController.h>
#import <SeckenUI/SCVoiceConfirmController.h>
#import <SeckenUI/SCVerifyController.h>
#import "AppDelegate.h"

@interface MainViewController () <UIAlertViewDelegate>
{
 
    UIScrollView            * scView;
    SeckenSDK               * seckenSDK;
    
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //初始化界面相关
    [self initSubView];

    
    //监听推送内容
    [[SeckenSDK currSeckenSDK] observeResultPullBlock:^(id operation) {
       
        if ([[operation objectForKey:@"type"] intValue] == 1) {
            
            [[SeckenSDK currSeckenSDK] pullUserName:self.username
                                              token:self.token
                                        pullSuccess:^(id operationSuccess)
             {
                 
                 int authType = [[operationSuccess objectForKey:@"auth_type"] intValue];
                 
                 
                 SCVerifyController * scVerify = [[SCVerifyController alloc] init];
                 scVerify.authType = authType;
                 scVerify.strUserName = self.username;
                 scVerify.strToken = self.token;
                 scVerify.strIPAddress = [operationSuccess objectForKey:@"ip"];
                 scVerify.strEventID = [operationSuccess objectForKey:@"event_id"];
                 scVerify.logoImage = [operationSuccess objectForKey:@"app_logo"];
                 scVerify.strDescContent = [operationSuccess objectForKey:@"action_details"];
                 scVerify.strTitle = [operationSuccess objectForKey:@"action_type"];
                 scVerify.strAppName = [operationSuccess objectForKey:@"app_name"];
                 
                 scVerify.successBlock = ^(id operation){
                     
                     //if ([[operation objectForKey:@"code"] intValue] == 200) {
                     
                     
                        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Tip OK(提示成功)" message:[operation description] delegate:self cancelButtonTitle:@"OK(确定)" otherButtonTitles:nil];
                        al.tag = 5000;
                        [al show];
                     
                     
                         /*
                     }else{
                         
                         UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Tip NO(提示失败)" message:[operation description] delegate:self cancelButtonTitle:@"OK(确定)" otherButtonTitles:nil];
                         al.tag = 6000;
                         [al show];
                         
                     }
                     */
                 };
                 
                 scVerify.failBlock = ^(id operation){
                     
                     UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Tip NO(提示失败)" message:[operation description] delegate:self cancelButtonTitle:@"OK(确定)" otherButtonTitles:nil];
                     al.tag = 6000;
                     [al show];
                     
                 };
                 
                 [self.navigationController pushViewController:scVerify animated:YES];
                 
                 
             } pullFail:^(id operationFail) {
                 
                 NSLog(@"pull fail operation = %@", operationFail);
                 
             }];
        }

    }];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag == 5000) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    return;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)initSubView{
    
    scView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scView.backgroundColor = [UIColor colorWithRed:74/255.0 green:144/255.0 blue:226/255.0 alpha:1];
    [self.view addSubview:scView];
    scView.contentSize = CGSizeMake(0, 700);
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKey)];
    [scView addGestureRecognizer:tap];
    
    CGRect tipRect = CGRectMake(20, 50, 120, 30);
    UILabel * tipLabel = [self createLabel:tipRect
                                      text:@"SDK 功能模块"
                                      font:[UIFont systemFontOfSize:17]];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    [scView addSubview:tipLabel];
    
    
    CGRect faceRect = CGRectMake(40,
                                 tipRect.origin.y + tipRect.size.height + 20,
                                 [UIScreen mainScreen].bounds.size.width - 80,
                                 40);
    UIButton * btnFaceTrain = [self createButton:faceRect
                                            text:@"人脸训练"
                                            font:tipLabel.font];
    [btnFaceTrain addTarget:self
                     action:@selector(clickFaceTrain:)
           forControlEvents:UIControlEventTouchUpInside];
    [scView addSubview:btnFaceTrain];
    
    
    UIButton * btnFaceConfirm = [self createButton:
                                 CGRectMake(40,
                                btnFaceTrain.frame.origin.y + btnFaceTrain.frame.size.height + 5,
                                btnFaceTrain.frame.size.width,
                                btnFaceTrain.frame.size.height)
                                text:@"人脸验证"
                                font:tipLabel.font];
    [btnFaceConfirm addTarget:self
                       action:@selector(clickFaceConfirm:)
             forControlEvents:UIControlEventTouchUpInside];
    [scView addSubview:btnFaceConfirm];
    
    
    UIButton * btnFaceDel = [self createButton:
                             CGRectMake(40,
                        btnFaceConfirm.frame.origin.y + btnFaceConfirm.frame.size.height + 5,
                                btnFaceConfirm.frame.size.width,
                                btnFaceConfirm.frame.size.height)
                                          text:@"人脸删除"
                                          font:tipLabel.font];
    [btnFaceDel addTarget:self
                   action:@selector(clickFaceDel:)
         forControlEvents:UIControlEventTouchUpInside];
    [scView addSubview:btnFaceDel];
    
    
    
    
    UIButton * voiceTrain = [self createButton:
                             CGRectMake(40,
                            btnFaceDel.frame.origin.y + btnFaceDel.frame.size.height + 30,btnFaceDel.frame.size.width,
                                btnFaceDel.frame.size.height)
                                          text:@"声纹训练"
                                          font:tipLabel.font];
    [voiceTrain addTarget:self
                   action:@selector(clickVoiceTrain:)
         forControlEvents:UIControlEventTouchUpInside];
    [scView addSubview:voiceTrain];
    
    
    UIButton * voiceConfirm = [self createButton:
                               CGRectMake(40,
                                voiceTrain.frame.origin.y + voiceTrain.frame.size.height + 5,
                                voiceTrain.frame.size.width,
                                voiceTrain.frame.size.height)
                                text:@"声纹验证"
                                font:tipLabel.font];
    [voiceConfirm addTarget:self
                     action:@selector(clickVoiceConfirm:)
           forControlEvents:UIControlEventTouchUpInside];
    [scView addSubview:voiceConfirm];
    
    
    
    UIButton * voiceDel = [self createButton:
                           CGRectMake(40,
                            voiceConfirm.frame.origin.y + voiceConfirm.frame.size.height + 5,
                            voiceConfirm.frame.size.width,
                            voiceConfirm.frame.size.height)
                                        text:@"声纹删除"
                                        font:tipLabel.font];
    [voiceDel addTarget:self
                 action:@selector(clickVoiceDel:)
       forControlEvents:UIControlEventTouchUpInside];
    [scView addSubview:voiceDel];
    
    
    UIButton * scanQR = [self createButton:
                         CGRectMake(40,
                                    voiceDel.frame.origin.y + voiceDel.frame.size.height + 30,
                                    voiceDel.frame.size.width,
                                    voiceDel.frame.size.height)
                                      text:@"安全扫一扫"
                                      font:tipLabel.font];
    [scanQR addTarget:self
               action:@selector(clickScanQR:)
     forControlEvents:UIControlEventTouchUpInside];
    [scView addSubview:scanQR];
    
    
    UIButton * unBind = [self createButton:
                         CGRectMake(40,
                                    scanQR.frame.origin.y + scanQR.frame.size.height + 5,
                                    scanQR.frame.size.width,
                                    scanQR.frame.size.height)
                                      text:@"解除授权"
                                      font:tipLabel.font];
    [unBind addTarget:self
               action:@selector(clickUnBind:)
     forControlEvents:UIControlEventTouchUpInside];
    [scView addSubview:unBind];
    
    
    
}



-(UILabel *)createLabel:(CGRect)r text:(NSString *)t font:(UIFont *)f{
    
    UILabel * labelTip = [[UILabel alloc] init];
    labelTip.frame = r;
    labelTip.text = t;
    labelTip.font = f;
    labelTip.textColor = [UIColor whiteColor];
    labelTip.backgroundColor = [UIColor clearColor];
    labelTip.textAlignment = NSTextAlignmentCenter;
    return labelTip;
}


-(UIButton *)createButton:(CGRect)r text:(NSString *)t font:(UIFont *)f{
    
    UIButton * btn = [[UIButton alloc] init];
    btn.frame = r;
    btn.titleLabel.text = t;
    [btn setTitle:t forState:UIControlStateNormal];
    btn.titleLabel.font = f;
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor whiteColor];
    return btn;
}



-(void)closeKey{
    [self.view endEditing:NO];
}



#pragma mark - UIButton Action

//人脸训练
- (void)clickFaceTrain:(id)sender {

    //通过主Bundle 拿到SeckenUI.framework 的路径，并且加载Bundle
    NSString * path = [[NSBundle mainBundle] pathForResource:@"SeckenUI" ofType:@"framework"];
    NSBundle * bundle = [NSBundle bundleWithPath:path];
    
    //通过bundle 加在xib文件。 并传入token和username参数
    SCFaceTrainController * face = [[SCFaceTrainController alloc] initWithNibName:@"SCFaceTrainController" bundle:bundle];
    face.strToken = self.token;
    face.strUserName =self.username;
    face.isTipSuccessPop = YES;
    
    //显示回调的结果。
    face.successBlock = ^(id operation){
        NSLog(@"operation = %@", operation);
    };
    face.failBlock = ^(id operation){
        NSLog(@"operation = %@", operation);
    };
    
    [self.navigationController pushViewController:face animated:YES];
}


//人脸验证
-(void)clickFaceConfirm:(id)sender {

    
    //通过主Bundle 拿到SeckenUI.framework 的路径，并且加载Bundle
    NSString * path = [[NSBundle mainBundle] pathForResource:@"SeckenUI" ofType:@"framework"];
    NSBundle * bundle = [NSBundle bundleWithPath:path];
    
    //通过bundle 加在xib文件。 并传入token和username参数
    SCFaceConfirmController * faceConfirm = [[SCFaceConfirmController alloc] initWithNibName:@"SCFaceConfirmController" bundle:bundle];
    faceConfirm.strtToken = self.token;
    faceConfirm.strUserName = self.username;
    
    faceConfirm.successBlock = ^(id operation){
        NSLog(@"operation = %@", operation);
        
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Tip OK(提示成功)" message:[operation description] delegate:nil cancelButtonTitle:@"OK(确定)" otherButtonTitles:nil];
        [al show];
        [self.navigationController popViewControllerAnimated:YES];

        
    };
    faceConfirm.failBlock = ^(id operation){
        NSLog(@"operation = %@", operation);
        
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Tip NO(提示失败)" message:[operation description] delegate:nil cancelButtonTitle:@"OK(确定)" otherButtonTitles:nil];
        [al show];
        
    };

    [self.navigationController pushViewController:faceConfirm animated:YES];
    
}


//人脸删除
-(void)clickFaceDel:(id)sender {

    
    //通过调用SeckenSDK，然后删除人脸。
    [[SeckenSDK currSeckenSDK] faceDeleteUserName:self.username token:self.token faceDeleteSuccess:^(id operation) {

       
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Tip OK(提示成功)" message:[operation description] delegate:nil cancelButtonTitle:@"OK(确定)" otherButtonTitles:nil];
        [al show];
        
    } faceDeleteFail:^(id operation) {
        
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Tip NO(提示失败)" message:[operation description] delegate:nil cancelButtonTitle:@"OK(确定)" otherButtonTitles:nil];
        [al show];
        
    }];
    
}


//声纹训练
-(void)clickVoiceTrain:(id)sender {

    
    SCVoiceTrainController * scVoice = [[SCVoiceTrainController alloc] init];
    scVoice.strToken = self.token;
    scVoice.strUserName = self.username;
    scVoice.strTitle = @"声纹训练";
    
    scVoice.successBlock = ^(id operation){

        //提示声纹训练成功
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Tip OK(提示成功)" message:[operation description] delegate:nil cancelButtonTitle:@"OK(确定)" otherButtonTitles:nil];
        [al show];
        
        //
        [self.navigationController popViewControllerAnimated:YES];
        
    };
    scVoice.failBlock = ^(id operation){
        
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Tip NO(提示失败)" message:[operation description] delegate:nil cancelButtonTitle:@"OK(确定)" otherButtonTitles:nil];
        [al show];

    
    };
    
    [self.navigationController pushViewController:scVoice animated:YES];
}


//声纹验证
-(void)clickVoiceConfirm:(id)sender {

    SCVoiceConfirmController * scVoiceConfirm = [[SCVoiceConfirmController alloc] init];
    scVoiceConfirm.strToken = self.token;
    scVoiceConfirm.strUserName = self.username;
    scVoiceConfirm.strRID = self.rID;
    scVoiceConfirm.strTitle = @"声纹验证";
    scVoiceConfirm.successBlock = ^(id operation){
        
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Tip OK(提示成功)" message:[operation description] delegate:nil cancelButtonTitle:@"OK(确定)" otherButtonTitles:nil];
        [al show];
        

    };
    
    scVoiceConfirm.failBlock = ^(id operation){
        
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Tip NO(提示失败)" message:[operation description] delegate:nil cancelButtonTitle:@"OK(确定)" otherButtonTitles:nil];
        [al show];

        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:scVoiceConfirm animated:YES];
    
}


//声纹删除
-(void)clickVoiceDel:(id)sender {

    SeckenVoiceDelete * voiceDel = nil;
    voiceDel = [[SeckenVoiceDelete alloc] initAndVoiceDelSuccessBlock:^(id operation) {

       [[SeckenSDK currSeckenSDK] voiceDeleteUserName:self.username token:self.token voiceDelSuccess:^(id operationDel){
           
           UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Tip OK(提示成功)" message:[operationDel description] delegate:nil cancelButtonTitle:@"OK(确定)" otherButtonTitles:nil];
           [al show];
           
           
       } voiceDelFail:^(id operationDel) {
           
           UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Tip NO(提示失败)" message:[operationDel description] delegate:nil cancelButtonTitle:@"OK(确定)" otherButtonTitles:nil];
           [al show];
           
       }];
   
   } delFailBlock:^(id operation) {
       
       UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Tip NO(提示失败)" message:[operation description] delegate:nil cancelButtonTitle:@"OK(确定)" otherButtonTitles:nil];
       [al show];
       
       
    }];
    
}


//安全扫一扫
- (void)clickScanQR:(id)sender {
    
    
    
    //通过主Bundle 拿到SeckenUI.framework 的路径，并且加载Bundle
    NSString * path = [[NSBundle mainBundle] pathForResource:@"SeckenUI" ofType:@"framework"];
    NSBundle * bundle = [NSBundle bundleWithPath:path];
    
    //通过bundle 加在xib文件。 并传入token和username参数
    SCQRViewController * scanQR = [[SCQRViewController alloc] initWithNibName:@"SCQRViewController" bundle:bundle];
    scanQR.strToken = self.token;
    scanQR.strUserName = self.username;
    scanQR.longitude = @"123.00";
    scanQR.latitude = @"123.00";
    
    scanQR.successBlock = ^(id operation){
        
        NSLog(@"operation = %@", operation);
        
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Tip OK(提示成功)" message:[operation description] delegate:nil cancelButtonTitle:@"OK(确定)" otherButtonTitles:nil];
        [al show];
        

        
    };
    scanQR.failBlock = ^(id operation){
        
        NSLog(@"operation = %@", operation);
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Tip NO(提示失败)" message:[operation description] delegate:nil cancelButtonTitle:@"OK(确定)" otherButtonTitles:nil];
        [al show];
        

        
    };

    [self.navigationController pushViewController:scanQR animated:YES];

    
    
}






//取消绑定
- (void)clickUnBind:(id)sender {
    
    [[SeckenSDK currSeckenSDK] unBindUserName:self.username token:self.token unBindSuccess:^(id operation) {
        
        if (200 == [[operation objectForKey:@"code"] intValue]) {
       
            
            UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Tip OK(提示成功)" message:[operation description] delegate:nil cancelButtonTitle:@"OK(确定)" otherButtonTitles:nil];
            [al show];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } unBindFail:^(id operation) {
       
        NSLog(@"operation = %@", operation);
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Tip NO(提示失败)" message:[operation description] delegate:nil cancelButtonTitle:@"OK(确定)" otherButtonTitles:nil];
        [al show];
        

        
    }];
    
}



@end
