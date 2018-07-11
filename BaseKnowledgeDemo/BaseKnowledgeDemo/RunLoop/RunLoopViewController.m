//
//  RunLoopViewController.m
//  BaseKnowledgeDemo
//
//  Created by 杜红星 on 2018/7/11.
//  Copyright © 2018年 MrDu. All rights reserved.
//

/**
 简单模拟runloop
 static int count = 0;
 void click (int type){
 count++;
 printf("正在执行第%d条指令",count);
 }
 
 int main(int argc, const char * argv[]) {
 @autoreleasepool {
 // insert code here...
 while (true) {
 printf("请输入选项 0 表示退出");
 int result = -1;
 scanf("%d",&result);
 if (result == 0) {
 printf("程序结束\n");
 break;
 } else {
 click(result);
 }
 }
 }
 return 0;
 }
 
 */

#import "RunLoopViewController.h"

@interface RunLoopViewController ()

@property (assign, nonatomic) BOOL isFinished;

@end

@implementation RunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _isFinished = NO;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    /**
     runloop
     保证程序不退出(死循环)
     负责监听事件:时钟 网络 触摸事件
     如果没有事件发生会让它进入休眠状态
     渲染图片 一次循环
     */
    
    /**
     默认模式
     NSDefaultRunLoopMode - 时钟 网络事件
     UITrackingRunLoopMode UI处理模式(只能被UI事件触发)
     
     占位模式 （兼容两种模式）
     NSRunLoopCommonModes - 用户交互
     */

    /*
     每一条线程上都有一条runloop 若想线程不被释放 让其runloop 开启
     */
    
    /**
     UI线程如有耗时操作 阻碍了runloop 监听runloop 分任务操作
     */
    
    
//   NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(run:) userInfo:nil repeats:YES];
//
//    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
//
    NSThread *thread = [[NSThread alloc]initWithBlock:^{
        NSLog(@"coming...%@",[NSThread currentThread]);
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(run:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
        //开启runloop循环 变成了常驻线程
        if (!_isFinished) {
             [[NSRunLoop currentRunLoop]runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.001]];
        }
        NSLog(@"comming...");
    }];
    [thread start];
}

- (void)run:(NSTimer *)timer {
    NSLog(@"run....");
    NSLog(@"%@",[NSThread currentThread]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _isFinished = YES;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)dealloc {
    NSLog(@"%s",__func__);
}

#pragma mark - CFRunloop

- (void)addRunloopObserver {
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    //定义观察者
    static CFRunLoopObserverRef defaultModeObserver;
    //定义上下文
    CFRunLoopObserverContext observerContext = {
        0,
        (__bridge void*)(self),
        &CFRetain,
        &CFRelease,
        NULL
    };
    //创建观察者
    defaultModeObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopBeforeWaiting, YES, 0, &callBack, &observerContext);
}

static void callBack(){
    
}

@end
