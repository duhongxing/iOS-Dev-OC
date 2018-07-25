//
//  HXNormalAlgorithm.m
//  HXAlgorithmDemo
//
//  Created by 杜红星 on 2018/7/24.
//  Copyright © 2018年 dhx. All rights reserved.
//

#import "HXNormalAlgorithm.h"

@implementation HXNormalAlgorithm

+ (NSUInteger)fibNumWithNumber:(NSUInteger)number methodCode:(NSInteger)methodCode
{
    switch (methodCode) {
        case 1:
            [self fibNum1WithNumber:number];
            break;
        case 2:
            [self fibNum2WithNumber:number];
            break;
        case 3:
            [self fibNum3WithNumber:number];
            break;
            
        default:
            break;
    }
    return 0;
}

///时间复杂度 O(2^n) NSUInteger 无符号数字 递归方式
+ (NSUInteger)fibNum1WithNumber:(NSUInteger)number
{
    if ((number == 0) || (number == 1)) {
        return number;
    }
    return [self fibNum1WithNumber:number - 1] + [self fibNum1WithNumber:number - 2];

    //简写
//    return number < 2 ? number : ([self fibNum1WithNumber:number - 1] + [self fibNum1WithNumber:number - 2]);

}

+ (NSUInteger)fibNum2WithNumber:(NSUInteger)number
{
    return 0;
}

//时间复杂度 n  空间复杂度 1
+ (NSUInteger)fibNum3WithNumber:(NSUInteger)number
{
    NSUInteger firstNum = 0;
    NSUInteger secondNum = 1;
    NSUInteger thirdNum = 0;
    for (NSUInteger i = 2; i <= number; i++) {
        thirdNum = firstNum + secondNum;
        firstNum = secondNum;
        secondNum = thirdNum;
    }
    return thirdNum;
}

@end
