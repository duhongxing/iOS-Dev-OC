//
//  JZActivityPopView.h
//  Jiazheng
//
//  Created by 杜 on 2018/8/16.
//  Copyright © 2018年 58. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 操作类型 */
typedef NS_ENUM(NSInteger,DJActionType) {
    DJActionTypeClose      = 0,//关闭操作
    DJActionTypeJump , //跳转操作
    DJActionTypeTapMask //点击蒙版
};

/** 关闭按钮位置 */
typedef NS_ENUM(NSInteger,DJPopViewCloseBtnPosition) {
    DJPopViewCloseBtnPositionTop  = 1,
    DJPopViewCloseBtnPositionBottom ,
    DJPopViewCloseBtnPositionLeft,
    DJPopViewCloseBtnPositionRight
};

/** 操作回调 */
typedef void(^ActionHandleBlock)(DJActionType actionType);

/** 活动弹窗视图 */
@interface DJActivityPopView : UIView

/** 点击蒙层能否消失 默认消失 */
@property (nonatomic, assign) BOOL dismissWhenTapMask;

/** 修改关闭按钮位置 */
@property (nonatomic, assign) DJPopViewCloseBtnPosition closeBtnPosition;

/** 事件回调 */
@property (nonatomic, copy) ActionHandleBlock actionBlock;

/** 活动链接 */
@property (nonatomic, copy, readonly) NSString *activityUrl;

/**
 初始化活动弹框

 @param image 活动图片
 @param url 活动链接
 @param viewController 从哪个控制器跳转到活动页
 @return 活动弹框实例
 */
- (instancetype)initWithActivityImg:(UIImage *)image
                        activityUrl:(NSString *)url
                 fromViewController:(UIViewController *)viewController;

/**
 初始化活动弹框
 
 @param image 活动图片
 @param url 活动链接
 @return 活动弹框实例
 */
- (instancetype)initWithActivityImg:(UIImage *)image
                        activityUrl:(NSString *)url;

/** 显示 */
- (void)showWithCompletion:(void(^)(void))completion;

/** 隐藏 */
- (void)hideWithCompletion:(void(^)(void))completion;

@end
