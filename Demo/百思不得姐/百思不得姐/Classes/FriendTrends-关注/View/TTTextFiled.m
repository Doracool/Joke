//
//  TTTextFiled.m
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/13.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import "TTTextFiled.h"
#import <objc/runtime.h>

static NSString * const TTPlacerholderColorKeyPath = @"_placeholderLabel.textColor";
@implementation TTTextFiled

+ (void)initialize
{
    [self getIvars];
}

+ (void)getProperties
{
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList([UITextField class], &count);
    
    for (int i = 0; i < count; i++) {
        //取出属性
        objc_property_t property = properties[i];
        
        //打印属性名字
        TTLog(@"%s  <----->  %s",property_getName(property),property_getAttributes(property));
    }
    free(properties);
}

+ (void)getIvars
{
    unsigned int count = 0;
    
    //拷贝出所有的成员变量的名字
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    
    for (int i = 0; i < count; i++) {
        //取出成员变量
        Ivar ivar = ivars[i];
        
        //打印成员变量的名字
        TTLog(@"%s  %s", ivar_getName(ivar),ivar_getTypeEncoding(ivar));
    }
    //释放
    free(ivars);
}

- (void)awakeFromNib
{
    //设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    
    //不成为第一响应者
    [self resignFirstResponder];
}

/**
 *  当前文本框聚焦时就会调用
 */
- (BOOL)becomeFirstResponder
{
    //修改占位文字颜色
    [self setValue:self.textColor forKeyPath:TTPlacerholderColorKeyPath];
    return [super becomeFirstResponder];
}

/**
 *  当前文本框失去焦点时就会调用
 */
- (BOOL)resignFirstResponder
{
    //修改占位文字的颜色
    [self setValue:[UIColor grayColor] forKeyPath:TTPlacerholderColorKeyPath];
    return [super resignFirstResponder];
}
//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    [self.placeholder drawInRect:CGRectMake(0, 10, rect.size.width, 25) withAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor], NSFontAttributeName : self.font}];
//}

@end
