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
     https://blog.ibireme.com/2015/05/18/runloop/ 深入理解runloop
     
     runloop
     保证程序不退出(死循环)
     负责监听事件:时钟 网络 触摸事件
     如果没有事件发生会让它进入休眠状态
     渲染图片 一次循环
     */
    
    /**
     默认模式
     NSDefaultRunLoopMode - 时钟 网络事件  App的默认 Mode，通常主线程是在这个 Mode 下运行的。
     UITrackingRunLoopMode UI处理模式(只能被UI事件触发) 界面跟踪 Mode，用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他 Mode 影响。
     
     占位模式 （兼容两种模式）
     NSRunLoopCommonModes - 用户交互
     
     系统默认注册了5个Mode:
     1. kCFRunLoopDefaultMode: App的默认 Mode，通常主线程是在这个 Mode 下运行的。
     2. UITrackingRunLoopMode: 界面跟踪 Mode，用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他 Mode 影响。
     3. UIInitializationRunLoopMode: 在刚启动 App 时第进入的第一个 Mode，启动完成后就不再使用。
     4: GSEventReceiveRunLoopMode: 接受系统事件的内部 Mode，通常用不到。
     5: kCFRunLoopCommonModes: 这是一个占位的 Mode，没有实际作用。
     
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
    
//    CFRunLoopTimerRef
}

static void callBack(){
    
}

@end
