//
//  ResponderIntroduction.h
//  BaseKnowledgeDemo
//
//  Created by 杜红星 on 2018/7/27.
//  Copyright © 2018年 MrDu. All rights reserved.
//

#ifndef ResponderIntroduction_h
#define ResponderIntroduction_h

/**
 事件响应者链
 
 事件的分类：1.触屏事件（Touch Event） 2.运动时间 (Motion Event) 3.远端控制事件（Remote-Control Event）
 
 事件的产生（传递链）：由系统向离用户最近的view传递。
 
 UIKit –> active app’s event queue –> window –> root view –>……–>lowest view
 
 事件的响应处理（响应链）：由离用户最近的view向系统传递。
 
 initial view –> super view –> …..–> view controller –> window –> Application
 
 App内部通过UIResponder来接收和处理事件，包括UIResponder的派生类：UIView、UIViewController、UIApplication同样具有这种能力
 
 我们通过override它们的一系列方法可以实时的得到事件响应的回调：
 
 触摸
 - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
 - (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
 - (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
 - (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
 加速计
 - (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event;
 - (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event;
 - (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event;
 远程控制
 - (void)remoteControlReceivedWithEvent:(UIEvent *)event;
 
 UIView：若它是ViewController的跟view，那么它的nextResponder就是ViewController；否则，它的nextResponder就是它的superView
 
 UIViewController：若它的view是某个window的跟视图，则其nextResponder为window；若它是从别的控制器present出来的，则其nextResponder为presenting view controller

 UIWindow：它的nextResponder为UIApplication对象

 UIApplication：若App delegate是一个UIResponder对象，且不是UIView、UIViewController、app本身，则UIApplication的nextResponder为app delegate
 
 UIKit通过hit-testing机制确定最佳响应者，将从层级最深的子视图（ the deepest subview）通过hitTest:withEvent:方法逐一查找，一旦有响应者满足触摸条件，该响应者将担此重任——处理touch event。
 
 响应者不能接受事件的情况:
 1、responder.userInteractionEnabled = NO
 2、responder.hidden = YES
 3、responder.alpha < 0.01
 
 hitTest:withEvent:方法的处理流程如下:
 
 首先调用当前视图的 pointInside:withEvent: 方法判断触摸点是否在当前视图内；
 若返回 NO, 则 hitTest:withEvent: 返回 nil，若返回 YES, 则向当前视图的所有子视图 (subviews) 发送 hitTest:withEvent: 消息，所有子视图的遍历顺序是从最顶层视图一直到到最底层视图，即从 subviews 数组的末尾向前遍历，直到有子视图返回非空对象或者全部子视图遍历完毕；
 若第一次有子视图返回非空对象，则 hitTest:withEvent: 方法返回此对象，处理结束；
 如所有子视图都返回空，则 hitTest:withEvent: 方法返回自身 (self)。
 
 系统默认Gestures比Responder拥有更高的响应优先
 
 Gesture recognizers use the target-action design pattern to send notifications.
 Gesture recognizers are the simplest way to handle touch or press events in your views.
 
 问题1：如果我们需要手势识别器的同时，又想要Respondser能够继续响应touch回调方法呢？
 只需要修改UIGestureRecognizer的一个属性：gestureObject.cancelsTouchesInView = NO
 
 UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureActionHandle)];
 gesture.cancelsTouchesInView = NO;
 
 */

#endif /* ResponderIntroduction_h */
