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
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [tagButton setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    tagButton.size = tagButton.currentBackgroundImage.size;
    [tagButton addTarget:self action:@selector(tagClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nightButton setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [nightButton setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
    nightButton.size = nightButton.currentBackgroundImage.size;
    [nightButton addTarget:self action:@selector(nightModeClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:tagButton],[[UIBarButtonItem alloc] initWithCustomView:nightButton]];
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
