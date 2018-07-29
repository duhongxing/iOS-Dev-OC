//
//  RunloopIntroduction.h
//  BaseKnowledgeDemo
//
//  Created by 杜红星 on 2018/7/27.
//  Copyright © 2018年 MrDu. All rights reserved.
//

#ifndef RunloopIntroduction_h
#define RunloopIntroduction_h

/**
 RunLoop是一让线程能随时处理事件但不退出的机制。RunLoop实际上是一个对象，这个对象管理了其需要处理的事件和消息，并提供了一个入口函数来执行Event Loop的逻辑。线程执行了这个函数后，就会一直处于这个函数内部 "接受消息->等待->处理" 的循环中，直到这个循环结束（比如传入 quit 的消息），函数返回。让线程在没有处理消息时休眠以避免资源占用、在有消息到来时立刻被唤醒。一个runloop就是一个事件处理循环，用来不停的监听和处理输入事件并将其分配到对应的目标上进行处理。
 
 RunLoop的四个作用为:使程序一直运行接受用户输入;决定程序在何时应该处理哪些Event;调用解耦;节省CPU时间。
 
 线程和 RunLoop 之间是一一对应的，其关系是保存在一个全局的 Dictionary 里。线程刚创建时并没有 RunLoop，如果你不主动获取，那它一直都不会有。RunLoop 的创建是发生在第一次获取时，RunLoop 的销毁是发生在线程结束时。你只能在一个线程的内部获取其RunLoop（主线程除外）。
 
 主线程的runloop默认是启动的。
 
 
 */

#endif /* RunloopIntroduction_h */
