//
//  TTTabBarController.m
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/7.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import "TTTabBarController.h"

@interface TTTabBarController ()

@end

@implementation TTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor yellowColor];
    vc1.tabBarItem.title = @"精华";
    vc1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [vc1.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [vc1.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    [self addChildViewController:vc1];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor orangeColor];
    vc2.tabBarItem.title = @"新帖";
    vc2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    [vc2.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [vc2.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    [self addChildViewController:vc2];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = [UIColor orangeColor];
    vc3.tabBarItem.title = @"关注";
    vc3.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    [vc3.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [vc3.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    [self addChildViewController:vc3];
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.view.backgroundColor = [UIColor orangeColor];
    vc4.tabBarItem.title = @"我";
    vc4.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    [vc4.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [vc4.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    [self addChildViewController:vc4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
