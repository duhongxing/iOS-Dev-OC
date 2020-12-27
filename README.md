### iOS知识回顾梳理
#### 基础知识
* 内存管理  [参考资料](https://juejin.cn/post/6844903473272586254#heading-20)
    - 关键字 nonatomic atomic readwrite readonly retain strong assign weak copy autorelease
    - MRC
    - ARC
* 类与类之间的消息传递
    - 通知（notification）
    - 代理（delegate）
    - block
* KVC使用及实现原理
* KVO使用及实现原理
* category 和 extension
* load 和 initialize ()
* [事件的传递及响应](https://www.jianshu.com/p/c294d1bd963d)
* 线程（thread）间的通信
* [线程锁（互斥锁和自旋锁)](https://blog.csdn.net/qq_41431406/article/details/109319433)
#### 网络
* [HTTP 协议](https://www.jianshu.com/p/6e9e4156ece3)
* [TCP/IP 协议](https://www.jianshu.com/p/9f3e879a4c9c)
* [浅析HTTPS中间人攻击与证书校验](https://www.jianshu.com/p/d4822bc289cf?utm_campaign=haruki&utm_content=note&utm_medium=reader_share&utm_source=weixin&from=groupmessage&isappinstalled=0)
* [SSL三种类型证书有什么区别](https://freessl.wosign.com/2018110901.html)
* [三次握手 四次挥手](https://zhuanlan.zhihu.com/p/86426969)
#### 常用第三方库
* [SDWebImage](https://github.com/SDWebImage/SDWebImage)
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)
* [Texture(ASyncDisplayKit)](https://github.com/texturegroup/texture)
* [FMDB](https://github.com/ccgus/fmdb)
* [JSONModel](https://github.com/jsonmodel/jsonmodel)
* [YYModel](https://github.com/ibireme/YYModel)
* [YYKit](https://github.com/ibireme/YYKit)
* [Masonry](https://github.com/SnapKit/Masonry)
* [IQKeyboardManager](https://github.com/hackiftekhar/IQKeyboardManager)

#### 底层知识
* 消息的发送及转发 (runtime)
    - instance class metaClass 
    - subClass superClass rootClass
    - isa
* [runloop](https://www.jianshu.com/p/8595a191063e)
* [weak](https://mp.weixin.qq.com/s/Y1jd1Q58YviRypMdfsbT3g)
    - > 1、调用objc_release
        2、因为对象的引用计数为0，所以执行dealloc
        3、在dealloc中，调用了_objc_rootDealloc函数
        4、在_objc_rootDealloc中，调用了object_dispose函数
        5、调用objc_destructInstance
        6、最后调用objc_clear_deallocating。
* [autoreleasePool](https://www.jianshu.com/p/58dab9c28a12)



#### 设计模式和设计原则
* 设计原则
    - 单一职责原则
    - 开闭原则
    - 接口隔离原则
    - 依赖倒置原则
    - 里氏替换原则
    - 迪米特法则
[参考资料]（https://juejin.cn/post/6844903673672237063）
* 设计模式
    - 单例模式
    - 代理模式
    - 观察者模式
    - 责任链
    - 命令模式
    - 适配器模式：将一个接口转换成客户希望的另一个接口，适配器模式使接口不兼容的那些类可以一起工作，其别名为包装器(Wrapper)。将目标类和适配者类解耦，通过引入一个适配器类来重用现有的适配者类，而无须修改原有代码。 增加了类的透明性和复用性，将具体的实现封装在适配者类中，对于客户端类来说是透明的，而且提高了适配者的复用性。灵活性和扩展性都非常好，通过使用配置文件，可以很方便地更换适配器，也可以在不修改原有代码的基础上增加新的适配器类，完全符合“开闭原则”
    - 桥接模式： 桥接模式的目的是把抽象层次结构从其实现中分离出来，使其能够独立变更。 分离抽象接口及其实现部分。桥接模式提高了系统的可扩充性，在两个变化维度中任意扩展一个维度，都不需要修改原有系统。实现细节对客户透明，可以对用户隐藏实现细节。
#### App优化
* 启动优化
    - [iOS客户端启动速度优化](https://www.jianshu.com/p/7096478ccbe7)
* 包大小优化
* 卡顿优化
    - [离屏渲染]()
    > CPU计算好显示内容提交到GPU，GPU渲染完成后将渲染结果放入帧缓冲区
      当前屏幕渲染，指的是GPU的渲染操作是在当前用于显示的屏幕缓冲区中进行
      离屏渲染，指的是GPU在当前屏幕缓冲区以外新开辟一个缓冲区进行渲染操
      重写了drawRect方法，并且使用任何Core Graphics的技术进行了绘制操作，就涉及到了CPU渲染
      CoreGraphic通常是线程安全的，所以可以进行异步绘制，显示的时候再放回主线程
* 电量优化
* 内存优化
    - [图片压缩](https://www.jianshu.com/p/99c3e6a6c03)
* [视图渲染与性能优化](https://www.jianshu.com/p/748f9abafff8)
 



