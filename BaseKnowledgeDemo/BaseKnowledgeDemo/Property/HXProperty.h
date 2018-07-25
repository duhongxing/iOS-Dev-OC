//
//  HXProperty.h
//  BaseKnowledgeDemo
//
//  Created by 杜红星 on 2018/7/25.
//  Copyright © 2018年 MrDu. All rights reserved.
//

#ifndef HXProperty_h
#define HXProperty_h

/**
 现在我们将  weak 的思路整理一下：
 
 
 整个系统中存在很多个对象，这些对象都可能会被弱引用，那么我们需要一个容器来容纳这些被弱引用的对象，比如数组，在此将这个容器的数据结构标识为 objectContainerDataStructure；
 
 
 一个对象可能会被多次弱引用，当这个对象被销毁时，我们需要找到这个对象的所有弱引用，所以我们需要将这些弱引用的地址（即指针）放在一个容器里，比如数组，在此将这些弱引用的地址的数据结构标识为 pointerContainerDataStructure；
 
 
 当对象不再被强引用时需要销毁的时候，我们需要通过这个对象在 objectContainerDataStructure 找到其对应的 pointerContainerDataStructure，进而找到这个对象的所有弱引用，将其置为 nil，
 
 
 通过上面的步骤，我们大概可以得出这么一个数据结构：
 
 
 pointerContainerDataStructure 仅仅只是容纳一个对象的所有弱引用的地址，所以用数组即可；
 
 
 objectContainerDataStructure 是一个 key-value 数据结构，将对象作为 key，对象的内存地址是最好的选择；
 
 
 在 iOS 中常用的 key-value 数据结构就是字典 Dictionary ，在这里我们的 key 是一个数值对象，value 则是一个数值数组对象，可以用哈希表实现；
 
 
 总结
 
 
 为了实现 weak，我们需要这样的一张弱引用表：
 
 
 表的数据结构是哈希表；
 
 
 表的 key 是对象的内存地址；
 
 
 value 是指向该对象的所有弱引用的指针；
 
 */

#endif /* HXProperty_h */
