//
//  TTEssenceViewController.m
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/7.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import "TTEssenceViewController.h"
#import "TTRecommendTagsViewController.h"
@interface TTEssenceViewController ()

@end

@implementation TTEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置导航栏左右的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" hightImage:@"MainTagSubSubIconClick" Target:self action:@selector(tagClick)];
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)tagClick
{
    TTRecommendTagsViewController *tags = [[TTRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor yellowColor];
//    vc.view.alpha = 0;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
