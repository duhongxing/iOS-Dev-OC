//
//  CategoryHeader.h
//  BaseKnowledgeDemo
//
//  Created by 杜红星 on 2018/7/25.
//  Copyright © 2018年 MrDu. All rights reserved.
//

#ifndef CategoryHeader_h
#define CategoryHeader_h
/**
 分类里面不能添加Ivar是因为分类本身并不是一个真正的类，它并没有自己的isa。有兴趣可以研究一下类是怎么被创建出来的，类最开始生成了很多基本属性，比如IvarList，MethodList，分类只会将自己的method attach到主类，并不会影响到主类的IvarList。这就是为什么分类里面不能增加成员变量的原因
 
根本原因是category 它是在运行期决议的。 因为在运行期即编译完成后，对象的内存布局已经确定，如果添加实例变量就会破坏类的内部布局，这对编译型语言来说是灾难性的。
 
 关联对象都由AssociationsManager管理，AssociationsManager里面是由一个静态AssociationsHashMap来存储所有的关联对象的。这相当于把所有对象的关联对象都存在一个全局map里面。而map的的key是这个对象的指针地址（任意两个不同对象的指针地址一定是不同的），而这个map的value又是另外一个AssociationsHashMap，里面保存了关联对象的kv对。
 
 runtime的销毁对象函数objc_destructInstance里面会判断这个对象有没有关联对象，如果有，会调用_object_remove_assocations做关联对象的清理工作。
 
 */

#endif /* CategoryHeader_h */
