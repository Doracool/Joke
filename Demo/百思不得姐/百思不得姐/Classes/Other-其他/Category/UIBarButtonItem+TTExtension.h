//
//  UIBarButtonItem+TTExtension.h
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/7.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (TTExtension)

+ (instancetype)itemWithImage:(NSString *)image hightImage:(NSString *)hightImage Target:(id)target action:(SEL)action;

@end
