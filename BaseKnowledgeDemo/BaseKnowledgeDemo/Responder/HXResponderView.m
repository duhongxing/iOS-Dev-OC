//
//  HXResponderView.m
//  BaseKnowledgeDemo
//
//  Created by 杜红星 on 2018/7/27.
//  Copyright © 2018年 MrDu. All rights reserved.
//

#import "HXResponderView.h"
#import <objc/runtime.h>

@implementation HXResponderView

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"%s",__func__);
//    [super touchesBegan:touches withEvent:event];
//}
//
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"%s",__func__);
//    [super touchesMoved:touches withEvent:event];
//}
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"%s",__func__);
//    [super touchesEnded:touches withEvent:event];
//}
//
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"%s",__func__);
//    [super touchesCancelled:touches withEvent:event];
//}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    UIView *touchView = self;
    if ([self pointInside:point withEvent:event] && (!self.hidden) && self.userInteractionEnabled && (self.alpha >= 0.01f)) {
        for (UIView *subView in self.subviews) {
            CGPoint subPoint = [subView convertPoint:point fromView:self];
            UIView *subTouchView = [subView hitTest:subPoint withEvent:event];
            if (subTouchView) {
                touchView = subTouchView;
                break;
            }
        }
    } else {
        touchView = nil;
    }
    
    NSLog(@"%@",touchView);
    
    return touchView;
}

//超过 父视图 Frame 范围时也可以响应 取消了pointInside 函数的检测 以便让我们可以捕获到当前 Frame 范围以外的子 View 的触控事件。

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    if (!self.clipsToBounds && !self.hidden && self.alpha > 0) {
//        for (UIView *subview in self.subviews.reverseObjectEnumerator) {
//            CGPoint subPoint = [subview convertPoint:point fromView:self];
//            UIView *result = [subview hitTest:subPoint withEvent:event];
//            if (result != nil) {
//                return result;
//            }
//        }
//    }
//    return nil;
//}

@end
