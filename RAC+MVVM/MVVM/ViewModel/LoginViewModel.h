//
//  LoginViewModel.h
//  RAC+MVVM
//
//  Created by 韩锐 on 17/2/26.
//  Copyright © 2017年 HanRui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginViewModel : NSObject

/** usetName */
@property (nonatomic, strong) NSString *userName;
/** passWord */
@property (nonatomic, strong) NSString *passWord;

/** 登录信号 */
@property (nonatomic, strong) RACSignal *loginSinal;
/** 登录请求 */
@property (nonatomic, strong) RACCommand *logButtonCommand;

@end
