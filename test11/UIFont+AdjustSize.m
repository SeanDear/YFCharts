//
//  UIFont+AdjustSize.m
//  test11
//
//  Created by leoshi on 2018/3/28.
//  Copyright © 2018年 gongzi. All rights reserved.
//

#import "UIFont+AdjustSize.h"
#import <objc/runtime.h>

@implementation UIFont (AdjustSize)


+ (void)load{
    
    Method oldMethod = class_getClassMethod([self class], @selector(systemFontOfSize:));
    Method newMethod = class_getClassMethod([self class], @selector(adjustFontSize:));
    method_exchangeImplementations(oldMethod, newMethod);
    
}

+ (UIFont *)adjustFontSize:(CGFloat)fontSize{
    
    return [UIFont adjustFontSize:fontSize * [UIScreen mainScreen].bounds.size.width /320];
//    return [UIFont systemFontOfSize:fontSize];
}

@end
