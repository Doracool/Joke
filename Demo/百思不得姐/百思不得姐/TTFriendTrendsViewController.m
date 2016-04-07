//
//  TTFriendTrendsViewController.m
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/7.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import "TTFriendTrendsViewController.h"

@interface TTFriendTrendsViewController ()

@end

@implementation TTFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏的文字
    self.navigationItem.title = @"我的关注";
    
    //设置导航栏左边的按钮
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    [tagButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
    tagButton.size = tagButton.currentBackgroundImage.size;
    [tagButton addTarget:self action:@selector(tagClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tagButton];
}

- (void)tagClick
{
    TTLogFunc;
}


@end
