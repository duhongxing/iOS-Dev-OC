//
//  iPhoneXAdapter.h
//  HXiPhoneXAdapterDemo
//
//  Created by 杜红星 on 2018/8/16.
//  Copyright © 2018年 dhx. All rights reserved.
//

#ifndef iPhoneXAdapter_h
#define iPhoneXAdapter_h
/**
 iPhoneX 屏幕尺寸: 375pt x 812pt @3x 像素为 1125px × 2436px
 
 可以通过判断屏幕的高度来判断设备是否是 iPhoneX，可以在全局宏定义中添加判断设备的宏定义（横竖屏通用）
 
 如果在 iPhoneX模拟器运行现有 app，出现上下屏幕没填充满的情况时，说明 app 没有适合 iPhoneX 尺寸的启动图，因此，需要添加一张 1125px × 2436px（@3x）的启动图，或者在项目中添加 LaunchScreen.xib，然后在项目的 target 中，设置启动 Launch Screen File 为 LaunchScreen.xib。

 safe area 安全区域
 
 为了尽可能的使布局和手势等不被圆角和传感器遮挡，竖屏情况下，苹果官方建议的安全区大小为上图（竖屏），指定的状态栏高度为 44pt，下方指示灯处的高度为 34pt；横屏情况下为上图（横屏）所示，上下安全边距分别为 0pt/21pt，左右安全边距为 44pt/34pt，如果使用了UINavigationBar和UITabBar，安全区的上边缘会变成导航栏下边缘的位置，如果是自定义的navigationBar，并且还继承于UIView，就需要手动修改状态栏的高度，在我们的项目中，状态栏的高度是用的全局宏定义，因此，修改状态栏高度的宏定义
 
 如果你同时也用了自定义的UITabBar那么就需要修改TABBAR_HEIGHT的宏定义
 
 */

#define IS_IPHONE_X     (( fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)812) < DBL_EPSILON ) || (fabs((double)[[UIScreen mainScreen] bounds].size.width - (double)812) < DBL_EPSILON ))

#define STATUS_HEIGHT   (IS_IPHONE_X?44:20)

#define BOTTOM_SAFEAREA_HEIGHT (IS_IPHONE_X? 34 : 0)

#define TABBAR_HEIGHT   (IS_IPHONE_X? (49 + 34) : 49)

#define SCREEN_WIDTH   CGRectGetWidth([UIScreen mainScreen].bounds)

#define SCREEN_HEIGHT  CGRectGetHeight([UIScreen mainScreen].bounds)


#endif /* iPhoneXAdapter_h */
