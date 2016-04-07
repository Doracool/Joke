//
//  TTMeViewController.m
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/7.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import "TTMeViewController.h"

@interface TTMeViewController ()

@end

@implementation TTMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置到杭兰的标题
    self.navigationItem.title = @"我的";
    //设置导航栏左右两边的标题
    UIBarButtonItem *setting = [UIBarButtonItem itemWithImage:@"mine-setting-icon" hightImage:@"mine-setting-icon-click" Target:self action:@selector(tagClick)];
    UIBarButtonItem *night = [UIBarButtonItem itemWithImage:@"mine-moon-icon" hightImage:@"mine-moon-icon-click" Target:self action:@selector(nightModeClick)];
    self.navigationItem.rightBarButtonItems = @[setting,night];
}

- (void)tagClick
{
    TTLogFunc;
}

- (void)nightModeClick
{
    TTLogFunc;
}

@end
