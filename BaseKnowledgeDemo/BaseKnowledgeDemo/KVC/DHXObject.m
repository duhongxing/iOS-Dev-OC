//
//  DHXObject.m
//  HooK
//
//  Created by 杜红星 on 2018/7/11.
//  Copyright © 2018年 MrDu. All rights reserved.
//

#import "DHXObject.h"
#import "DHXSubObjc.h"

@implementation DHXObject

- (instancetype)init {
    
    if (self = [super init]) {
        
        _objectName = @"_objectName";
        _isObjectName = @"_isObjectName";
        objectName = @"objectName";
        isObjectName = @"isObjectName";
        
        _subObjc = [[DHXSubObjc alloc]init];
        _subObjc.subObjcName = @"subObjcName";
        
    }
    return self;
}

//重写该方法 可避免当获取不到value时崩溃异常
- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

//默认YES 直接访问成员变量 若设置为NO 则不会访问成员变量
+ (BOOL)accessInstanceVariablesDirectly {
    return YES;
}

//- (NSUInteger)countOfSubObjc {
//    return 1;
//}
//
//- (id)objectInSubObjcAtIndex:(NSUInteger)index {
//    return @"相关方法";
//}

//getObjectName 优先级比 objectName 优先级要高
//objectName优先级比访问成员变量优先级高

//- (NSString *)getObjectName {
//    return @"getObjectName";
//}

//- (NSString *)objectName {
//    return @"objectName";
//}



@end




