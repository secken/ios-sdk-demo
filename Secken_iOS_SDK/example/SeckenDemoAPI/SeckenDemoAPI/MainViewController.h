//
//  MainViewController.h
//  SeckenDemoAPI
//
//  Created by Secken_ck on 15/9/21.
//  Copyright © 2015年 Secken_ck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (nonatomic, strong) NSString * username;
//授权（绑定）返回的
@property (nonatomic, strong) NSString * token;

@property (nonatomic, strong) NSString * rID;
//扫描二维码返回的
@property (nonatomic, strong) NSString * eventID;
@end
