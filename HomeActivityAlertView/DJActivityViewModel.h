//
//  JZActivityViewModel.h
//  DaoJiaComponentTest
//
//  Created by 杜 on 2018/9/4.
//  Copyright © 2018年 du. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DJActivityModel;

@interface DJActivityViewModel : NSObject

/** 弹框数据 */
@property (nonatomic, strong) DJActivityModel *activityModel;

/** 是否需要判断弹出条件 */
@property (nonatomic, assign) BOOL needCondition;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

///是否满足展示条件
- (BOOL)canShowActivity;

///记录弹框次数
- (void)recordPopTimes;

///清除记录 (测试使用)
- (void)clearRecordMessage;

///活动埋点页面
- (NSString *)activity_pageName;

///活动埋点类型
- (NSString *)activity_pageType;

///跳转事件埋点id
- (NSString *)activity_jumpEvent;

///关闭事件埋点id
- (NSString *)activity_closeEvent;

///浮层点击事件埋点id
- (NSString *)activity_fucengEvent;


@end

@interface DJActivityModel : NSObject

/** 是否展示关闭 */
@property (nonatomic, assign) NSInteger canClose;
/** 图片链接 */
@property (nonatomic, copy)   NSString  *picUrl;
/** 弹窗标识 */
@property (nonatomic, copy)   NSString  *name;
/** 跳转链接 */
@property (nonatomic, copy)   NSString  *targetUrl;
/** 间隔时间 默认为1 特殊值：0 无限制  */
@property (nonatomic, assign) NSInteger days;
/** 每天弹框次数 默认为1 特殊值：0 无限制  */
@property (nonatomic, assign) NSInteger times;
/** 是否需要登录 0不需要登录 1需要登录 */
@property (nonatomic, assign) NSInteger needLogin;
/** 显示时间 0表示一直显示 */
@property (nonatomic, assign) NSInteger showTime;
/** "n/m" //n代表次数，m代表天数 ，特殊值：0/0表示每次启动都弹 */
@property (nonatomic, copy)   NSString *frequency;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
