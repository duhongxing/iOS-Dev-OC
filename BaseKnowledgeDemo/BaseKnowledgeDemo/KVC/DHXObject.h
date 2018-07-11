//
//  DHXObject.h
//  HooK
//
//  Created by 杜红星 on 2018/7/11.
//  Copyright © 2018年 MrDu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DHXSubObjc;

@interface DHXObject : NSObject
{
    
    NSString *    _objectName;
    NSString *    _isObjectName;
    NSString *    objectName;
    NSString *    isObjectName;

}

//@property (copy, nonatomic) NSString *objName;

@property (strong, nonatomic) DHXSubObjc *subObjc;


@end
