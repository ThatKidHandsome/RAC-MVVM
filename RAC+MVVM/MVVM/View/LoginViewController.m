//
//  LoginViewController.m
//  RAC+MVVM
//
//  Created by 韩锐 on 17/2/26.
//  Copyright © 2017年 HanRui. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
/** viewModel */
@property (nonatomic, strong) LoginViewModel *viewModel;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialBind];
}

- (void)initialBind {
    
    RAC(self.viewModel, userName) = self.userNameTextField.rac_textSignal;
    RAC(self.viewModel, passWord) = self.passWordTextField.rac_textSignal;
    RAC(self.loginButton, enabled) = self.viewModel.loginSinal;
    
    [[self.viewModel.logButtonCommand.executionSignals switchToLatest] subscribeNext:^(id x) {
        BOOL success = [x boolValue];
        if (success) {
            NSLog(@"成功");
        }else {
            NSLog(@"登录失败");
        }
    }];
    
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.viewModel.logButtonCommand execute:nil];
    }];

}

- (LoginViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[LoginViewModel alloc]init];
    }
    return _viewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
