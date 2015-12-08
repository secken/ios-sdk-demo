//
//  SeckenVoiceDelete.h
//  CreateSDK
//
//  Created by Secken_ck on 15/9/19.
//  Copyright © 2015年 Secken_ck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SeckenVoiceDelete : NSObject

/*
 说明 （instructions）
 删除声纹 （To delete a voiceprint）
 */
-(instancetype)initAndVoiceDelSuccessBlock:(void(^)(id operation))success
                              delFailBlock:(void(^)(id operation))fail;
@end
