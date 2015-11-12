//
//  ViewController.m
//  SeckenUISDK
//
//  Created by Secken_ck on 15/10/14.
//  Copyright © 2015年 Secken_ck. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"
#import <SeckenUI/SCFaceConfirmController.h>

@interface ViewController () <UITextFieldDelegate>
{
    
    UITextField             * tfAppKey;
    UITextField             * tfAppID;
    UITextField             * tfUsername;
    
    UIButton                * btn;
    
    UIScrollView            * scView;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self initSubView];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(30,
                           self.view.frame.size.height - 80,
                           self.view.frame.size.width - 60,
                           55);
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitle:@"点击授权 SDK" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBind) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    tfAppKey.text = @"";
    tfAppID.text = @"";
    tfUsername.text = @"";
    
    tfAppKey.placeholder = @"您的APP KEY";
    tfAppID.placeholder = @"您的APP ID";
    tfUsername.placeholder = @"用户名";
    
    
    if (tfAppKey.text.length >= 1 && tfAppID.text.length >= 1 && tfUsername.text.length >= 1) {
        
        btn.userInteractionEnabled = YES;
        btn.alpha = 1;
    }else{
        
        btn.userInteractionEnabled = NO;
        btn.alpha = 0.4;
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initSubView{
    
    
    scView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scView.backgroundColor = [UIColor colorWithRed:74/255.0 green:144/255.0 blue:226/255.0 alpha:1];
    [self.view addSubview:scView];
    scView.contentSize = CGSizeMake(0, 700);
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKey)];
    [scView addGestureRecognizer:tap];
    
    
    CGRect tipRect = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 100, 40, 200, 50);
    UILabel * labelTip = [self createLabel:tipRect
                                      text:@"SDK Demo"
                                      font:[UIFont systemFontOfSize:38]];
    [scView addSubview:labelTip];
    
    
    
    CGRect writeInfoRect = CGRectMake(40,
                                      labelTip.frame.size.height + labelTip.frame.origin.y + 10,
                                      150,
                                      30);
    UILabel * labelTipWriteInfo = [self createLabel:writeInfoRect
                                               text:@"填写授权信息"
                                               font:[UIFont systemFontOfSize:16]];
    labelTipWriteInfo.textAlignment = NSTextAlignmentLeft;
    [scView addSubview:labelTipWriteInfo];
    
    
    
    CGRect IDLabelRect = CGRectMake(40,
                                    writeInfoRect.origin.y + writeInfoRect.size.height + 10,
                                    100,
                                    20);
    
    UILabel * appkey = [self createLabel:IDLabelRect
                                    text:@"AppID"
                                    font:[UIFont systemFontOfSize:18]];
    appkey.textAlignment = NSTextAlignmentLeft;
    [scView addSubview:appkey];
    
    CGRect IDRect = CGRectMake(40,
                               IDLabelRect.origin.y + IDLabelRect.size.height + 5,
                               [UIScreen mainScreen].bounds.size.width - 80,
                               35);
    tfAppID = [self createTextField:IDRect];
    [scView addSubview:tfAppID];
    
    
    
    CGRect KeyLabelRect = CGRectMake(40,
                                     IDRect.origin.y + IDRect.size.height + 10,
                                     IDLabelRect.size.width,
                                     IDLabelRect.size.height);
    UILabel * keyLabel = [self createLabel:KeyLabelRect text:@"AppKey" font:appkey.font];
    keyLabel.textAlignment = NSTextAlignmentLeft;
    [scView addSubview:keyLabel];
    
    CGRect idRect = CGRectMake(40,
                               KeyLabelRect.origin.y + KeyLabelRect.size.height + 5,
                               IDRect.size.width,
                               IDRect.size.height);
    tfAppKey = [self createTextField:idRect];
    [scView addSubview:tfAppKey];
    
    
    CGRect nameRect = CGRectMake(40,
                                 idRect.origin.y + idRect.size.height + 10,
                                 KeyLabelRect.size.width,
                                 KeyLabelRect.size.height);
    UILabel * nameLabel = [self createLabel:nameRect text:@"UserName" font:keyLabel.font];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [scView addSubview:nameLabel];
    
    
    
    CGRect tfNameRect = CGRectMake(40,
                                   nameLabel.frame.origin.y + nameLabel.frame.size.height + 5, idRect.size.width,
                                   idRect.size.height);
    tfUsername = [self createTextField:tfNameRect];
    [scView addSubview:tfUsername];
    
    
}



-(UITextField *)createTextField:(CGRect)r{
    UITextField * tf = [[UITextField alloc] initWithFrame:r];
    tf.borderStyle = UITextBorderStyleLine;
    tf.backgroundColor = [UIColor whiteColor];
    tf.delegate = self;
    return tf;
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


-(void)closeKey{
    [self.view endEditing:NO];
}

-(void)clickBind{
    
    btn.userInteractionEnabled = NO;
    
    //初始化:
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    indicator.tag = 103;
    //设置显示样式,见UIActivityIndicatorViewStyle的定义
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    //设置背景色
    indicator.backgroundColor = [UIColor blackColor];
    //设置背景透明
    indicator.alpha = 0.5;
    //设置背景为圆角矩形
    indicator.layer.cornerRadius = 6;
    indicator.layer.masksToBounds = YES;
    //设置显示位置
    [indicator setCenter:CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0)];
    //开始显示Loading动画
    [indicator startAnimating];
    
    [self.view addSubview:indicator];
    MainViewController * main = [[MainViewController alloc] init];

    
    [SeckenSDK registerAppID:tfAppID.text appKey:tfAppKey.text];
    
    [[SeckenSDK currSeckenSDK] bindUserName:tfUsername.text bindSuccess:^(id operation) {
        NSString * token = [operation objectForKey:@"token"];

        main.username = tfUsername.text;
        main.token = token;

        [self.navigationController pushViewController:main animated:YES];
        
        
        btn.userInteractionEnabled = YES;
        [indicator removeFromSuperview];
        
    } bindFail:^(id operation) {
        
        
        btn.userInteractionEnabled = YES;
        [indicator removeFromSuperview];

        UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Tip（提示）" message:[operation description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK(确定)", nil];
        [al show];
        NSLog(@"error = %@", operation);
    }];
}




#pragma mark - TextField Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (tfAppKey == textField) {
        [UIView animateWithDuration:0.3 animations:^{
            scView.contentOffset = CGPointMake(0, 0);
        }];
    }else if(tfAppID == textField){
        [UIView animateWithDuration:0.3 animations:^{
            scView.contentOffset = CGPointMake(0, 30);
        }];
    }else if (tfUsername == textField){
        [UIView animateWithDuration:0.3 animations:^{
            scView.contentOffset = CGPointMake(0, 60);
        }];
    }
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.3 animations:^{
        scView.contentOffset = CGPointMake(0, 0);
    }];
    
    if (tfAppKey.text.length >= 1 && tfAppID.text.length >= 1 && tfUsername.text.length >= 1) {
        btn.userInteractionEnabled = YES;
        btn.alpha = 1;
    }else{
        btn.userInteractionEnabled = NO;
        btn.alpha = 0.4;
    }
}


@end
