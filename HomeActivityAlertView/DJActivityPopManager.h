//
//  JZActivityPopManager.h
//  DaoJiaComponentTest
//
//  Created by 杜 on 2018/9/4.
//  Copyright © 2018年 du. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJActivityPopManager : NSObject

@property (nonatomic, weak) UIViewController *viewController;

+ (instancetype)sharedManager;

- (void)showActivityWithActivityInfo:(NSDictionary *)activityInfo;

///清除弹窗记录
- (void)clearRecord;

@end


