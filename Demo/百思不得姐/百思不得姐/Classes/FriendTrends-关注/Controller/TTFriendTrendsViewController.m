//
//  TTFriendTrendsViewController.m
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/7.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import "TTFriendTrendsViewController.h"
#import "TTRecommendViewController.h"
@interface TTFriendTrendsViewController ()

@end

@implementation TTFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏的文字
    self.navigationItem.title = @"我的关注";
    
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" hightImage:@"friendsRecommentIcon-click" Target:self action:@selector(tagClick)];
}

- (void)tagClick
{
    TTRecommendViewController *vc = [[TTRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
