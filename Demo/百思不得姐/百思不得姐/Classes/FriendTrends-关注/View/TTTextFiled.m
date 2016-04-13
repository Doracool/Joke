//
//  TTTextFiled.m
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/13.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import "TTTextFiled.h"

@implementation TTTextFiled

- (void)drawPlaceholderInRect:(CGRect)rect
{
    [self.placeholder drawInRect:CGRectMake(0, 10, rect.size.width, 25) withAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor], NSFontAttributeName : self.font}];
}

@end
