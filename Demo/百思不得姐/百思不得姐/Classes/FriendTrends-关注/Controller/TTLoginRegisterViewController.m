//
//  TTLoginRegisterViewController.m
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/11.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import "TTLoginRegisterViewController.h"

@interface TTLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;
@property (weak, nonatomic) IBOutlet UITextField *phoneFiled;
@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@end

@implementation TTLoginRegisterViewController
- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)showLoginOrRegister:(UIButton *)sender {
    //退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) {
        //线束注册界面
        self.loginViewLeftMargin.constant = -self.view.width;
        sender.selected = YES;
    }else{
        //显示登录界面
        self.loginViewLeftMargin.constant = 0;
        sender.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //文字属性
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor yellowColor];
//    // NSAttributedString : 带有属性的文字
//    NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attrs];
//    self.phoneFiled.attributedPlaceholder = placeholder;
//    
//    [self.view insertSubview:self.bgView atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//让当前控制器对应的状态栏是白色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
