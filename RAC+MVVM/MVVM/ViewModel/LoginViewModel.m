//
//  LoginViewModel.m
//  RAC+MVVM
//
//  Created by 韩锐 on 17/2/26.
//  Copyright © 2017年 HanRui. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

-(instancetype)init {
    if (self = [super init]) {
        [self initialBind];
    }
    return self;
}

-(void)initialBind {
    
    _loginSinal = [RACSignal combineLatest:@[RACObserve(self, userName), RACObserve(self, passWord)] reduce:^(NSString *username, NSString *userpwd){
        return @([self isValidUsername:username] && [self isValidPassword:userpwd]);
    }];
    
    _logButtonCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
                [self loginWithUsername:self.userName password:self.passWord complete:^(BOOL success) {
                    [subscriber sendNext:@(success)];
                    [subscriber sendCompleted];
                }];
            
            return nil;
        }];
    }];
    
    
    
}
- (BOOL)isValidUsername:(NSString *)username {
        return username.length >= 6;
}

- (BOOL)isValidPassword:(NSString *)password {
    return password.length >= 6;
}
- (void)loginWithUsername:(NSString *)username password:(NSString *)password complete:(void (^)(BOOL))loginResult {
    BOOL success = [username isEqualToString:@"username"] && [password isEqualToString:@"password"];
    loginResult(success);
}

@end
