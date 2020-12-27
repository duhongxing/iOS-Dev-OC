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
* 线程（thread）间的通信
* [线程锁（互斥锁和自旋锁)](https://blog.csdn.net/qq_41431406/article/details/109319433)
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
* runloop 

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
* 包大小优化
* 卡顿优化
* 电量优化
* 内存优化



