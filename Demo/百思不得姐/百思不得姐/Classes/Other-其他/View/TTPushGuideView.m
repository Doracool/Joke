//
//  TTPushGuideView.m
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/13.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import "TTPushGuideView.h"

@implementation TTPushGuideView

+ (void)show
{
    NSString *key = @"CFBundleShortVersionString";
    
    //获取当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //获取沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        TTPushGuideView *guideView = [TTPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        //存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (IBAction)close:(id)sender {
    [self removeFromSuperview];
}

@end
