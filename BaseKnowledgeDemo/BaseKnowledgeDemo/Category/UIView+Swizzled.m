//
//  UIView+Swizzled.m
//  BaseKnowledgeDemo
//
//  Created by 杜红星 on 2018/9/5.
//  Copyright © 2018年 MrDu. All rights reserved.
//

#import "UIView+Swizzled.h"
#import <objc/runtime.h>

@implementation UIView (Swizzled)

+ (void)load {
    [super load];
    __weak typeof(self) weakSelf = self;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //类
        Class alertClass = [weakSelf class];
        //获取旧方法
        Method oldMethod = class_getInstanceMethod(weakSelf, NSSelectorFromString(@"dealloc"));
        //获取新方法
        Method newMethod = class_getInstanceMethod(weakSelf, @selector(hx_dealloc));
        //为类添加实例方法
        BOOL didAddMethod = class_addMethod(alertClass, NSSelectorFromString(@"dealloc"), method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
        if (didAddMethod) {
            //替换方法
            class_replaceMethod(alertClass, @selector(hx_dealloc), method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod));
        } else {
            //交换方法
            method_exchangeImplementations(oldMethod, newMethod);
        }
    });
}

- (void)hx_dealloc {
    NSLog(@"%s",__func__);
    [self hx_dealloc];
}

@end
