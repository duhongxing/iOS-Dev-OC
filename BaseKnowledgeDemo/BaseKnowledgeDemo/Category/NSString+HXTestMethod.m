//
//  NSString+HXTestMethod.m
//  BaseKnowledgeDemo
//
//  Created by 杜红星 on 2018/7/25.
//  Copyright © 2018年 MrDu. All rights reserved.
//

#import "NSString+HXTestMethod.h"

@implementation NSString (HXTestMethod)

- (void)hx_logTestCategory {
    NSLog(@"\n%s\n\nself:%@",__func__,self);
}

@end
