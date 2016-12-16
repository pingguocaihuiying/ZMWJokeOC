//
// Created by GYJZH on 7/17/16.
// Copyright (c) 2016 GYJZH. All rights reserved.
//

#import "LLLoginViewController.h"
#import "EMClient.h"
#import "LLUtils.h"
#import "UIKit+LLExt.h"
#import "LLConfig.h"
#import "LLClientManager.h"
#import "Tooles.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LLLoginViewController () <UITextFieldDelegate>

@property (strong, nonatomic) UITextField *accountTextField;

@property (strong, nonatomic) UITextField *passwordTextField;

@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UIButton *registButton;

@end


@implementation LLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllView];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboard:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    
    [self.view addGestureRecognizer:tapGesture];

    self.accountTextField.text = [self getLastLoginUsername];
    
    //XXX 为了方便
    self.passwordTextField.text = self.accountTextField.text;

}

- (void)initAllView {
    
    self.accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, SCREEN_WIDTH - 20, 30)];
    self.accountTextField.placeholder = @"用户名只能是英文字母和数字";
    [self.view addSubview:self.accountTextField];
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.accountTextField.bottom_LL + 10, SCREEN_WIDTH - 20, 30)];
    self.passwordTextField.placeholder = @"6-16位";
    [self.view addSubview:self.passwordTextField];
    self.loginButton = [Tooles getButtonWithTitle:@"登录" titleColor:[UIColor blueColor] font:[UIFont systemFontOfSize:16]];
    self.loginButton.frame = CGRectMake(10, self.passwordTextField.bottom_LL + 20, SCREEN_WIDTH - 20, 40);
    [self.view addSubview:self.loginButton];
    [self.loginButton addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.registButton = [Tooles getButtonWithTitle:@"注册" titleColor:[UIColor blueColor] font:[UIFont systemFontOfSize:16]];
    self.registButton.frame = CGRectMake(10, self.loginButton.bottom_LL + 20, SCREEN_WIDTH - 20, 40);
    [self.view addSubview:self.registButton];
    [self.registButton addTarget:self action:@selector(registerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    return NO;
}


- (void)resignKeyboard:(UITapGestureRecognizer *)tap {
    [self.accountTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.accountTextField) {
        [self.passwordTextField becomeFirstResponder];
    }else {
        if (self.loginButton.enabled)
            [self loginButtonPressed:nil];
    }
    
    return YES;
}


- (IBAction)textFieldDidChange:(UITextField *)sender {
    if (self.accountTextField.text.length > 0 && self.passwordTextField.text.length > 0) {
        self.loginButton.enabled = YES;
    }else {
        self.loginButton.enabled = NO;
    }
}

#pragma mark - 用户登录

- (void)loginButtonPressed:(UIButton *)sender {
    [self.view endEditing:YES];
    [[LLClientManager sharedManager] loginWithUsername:self.accountTextField.text password:self.passwordTextField.text];
}

- (void)registerButtonPressed:(id)sender {
    [self.view endEditing:YES];
    [[LLClientManager sharedManager] registerWithUsername:self.accountTextField.text password:self.passwordTextField.text];
}

- (NSString *)getLastLoginUsername {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:LAST_LOGIN_USERNAME_KEY];
}

@end
