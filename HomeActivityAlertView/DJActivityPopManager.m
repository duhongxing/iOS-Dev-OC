//
//  JZActivityPopManager.m
//  DaoJiaComponentTest
//
//  Created by 杜 on 2018/9/4.
//  Copyright © 2018年 du. All rights reserved.
//

#import "DJActivityPopManager.h"
#import "DJActivityViewModel.h"
#import "DJActivityPopView.h"
#import "SDWebImageManager.h"
#import "JZShellVCWebVC.h"

@interface DJActivityPopManager ()

@property (nonatomic, strong) DJActivityViewModel *viewModel;

@end

@implementation DJActivityPopManager


+ (instancetype)sharedManager {
    static DJActivityPopManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager == nil) {
            _manager = [[self alloc]init];
        }
    });
    return _manager;
}

- (void)showActivityWithActivityInfo:(NSDictionary *)activityInfo {
    
    //活动弹框 活动信息及显示逻辑
    self.viewModel = [[DJActivityViewModel alloc]initWithDictionary:activityInfo];
    //显示逻辑
    BOOL ret = [self.viewModel canShowActivity];
    if (ret) {
        __weak typeof(self) weakself = self;
        //图片资源下载
        [[SDWebImageManager sharedManager]loadImageWithURL:[NSURL URLWithString:weakself.viewModel.activityModel.picUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            
            if (image && finished) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //创建活动弹框
                    DJActivityPopView *popView = [[DJActivityPopView alloc]initWithActivityImg:image activityUrl:weakself.viewModel.activityModel.targetUrl];
                    popView.actionBlock = ^(DJActionType actionType) {
                        if (actionType == DJActionTypeClose) {
                            NSLog(@"点击了关闭按钮");
                            //关闭按钮事件埋点
                            [JZMob clickWithEventId:[weakself.viewModel activity_closeEvent] pageType:[weakself.viewModel activity_pageType] pageName:[weakself.viewModel activity_pageName] attributes:nil];
                        } else if (actionType == DJActionTypeJump) {
                            NSLog(@"跳转到了Web界面");
                            JZShellWebVC *webViewVC = [[JZShellWebVC alloc] initWithUrl:weakself.viewModel.activityModel.targetUrl withTitle:nil];
                            [weakself.viewController.navigationController pushViewController:webViewVC animated:YES];
                            //活动跳转点击事件埋点
                            [JZMob clickWithEventId:[weakself.viewModel activity_jumpEvent] pageType:[weakself.viewModel activity_pageType] pageName:[weakself.viewModel activity_pageName] attributes:nil];
                        } else {
                            NSLog(@"点击蒙版浮层消失");
                            //新人弹窗点击蒙层埋点
                            [JZMob clickWithEventId:[weakself.viewModel activity_fucengEvent] pageType:[weakself.viewModel activity_pageType] pageName:[weakself.viewModel activity_pageName] attributes:nil];
                        }
                    };
                    [popView showWithCompletion:^{
                        NSLog(@"弹框显示完成");
                        //活动弹框入口曝光埋点
                        [JZMob pageLoadWithPageType:[weakself.viewModel activity_pageType] pageName:[weakself.viewModel activity_pageName] attributes:nil];
                        //记录弹窗次数
                        [weakself.viewModel recordPopTimes];
                    }];
                });
            }
        }];
    }
}

- (void)clearRecord {
    [self.viewModel clearRecordMessage];
}



@end
