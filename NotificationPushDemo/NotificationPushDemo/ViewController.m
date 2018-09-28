//
//  ViewController.m
//  NotificationPushDemo
//
//  Created by 杜红星 on 2018/9/13.
//  Copyright © 2018年 daojia. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>

#define kIdentifier_Notification  @"localNotification"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self pushLocalNotification];
}

///推送本地通知
- (void)pushLocalNotification {
    
    //在每周三的20点30分提醒
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.weekday = 4;
    components.hour = 20;
    components.minute = 48;
    
    // components 日期
    UNCalendarNotificationTrigger *calendarTrigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
    
    //位置推送
    CLLocationCoordinate2D center1 = CLLocationCoordinate2DMake(39.788857, 116.5559392);
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:center1 radius:500 identifier:@"经海五路"];
    region.notifyOnEntry = YES;
    region.notifyOnExit = YES;
    // region 位置信息 repeats 是否重复 （CLRegion 可以是地理位置信息）
    UNLocationNotificationTrigger *locationTrigger = [UNLocationNotificationTrigger triggerWithRegion:region repeats:YES];
    
    // 创建通知内容 UNMutableNotificationContent, 注意不是 UNNotificationContent ,此对象为不可变对象。
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"喜马拉雅之牧师";
    content.subtitle = [NSString stringWithFormat:@"杜牧"];
    content.body = @"天苍苍，野茫茫，风吹草地见牛羊。";
    content.badge = @1;
    content.sound = [UNNotificationSound defaultSound];
    content.userInfo = @{@"author":@"杜牧",@"title":@"天苍苍"};
    
    
    // 设置触发条件 UNNotificationTrigger
    UNTimeIntervalNotificationTrigger *timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5.0f repeats:NO];
    
    // 创建通知标示
    NSString *requestIdentifier = kIdentifier_Notification;
    
    // 创建通知请求 UNNotificationRequest 将触发条件和通知内容添加到请求中
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:timeTrigger];
    
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    // 将通知请求 add 到 UNUserNotificationCenter
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"推送已添加成功 %@", requestIdentifier);
            //你自己的需求例如下面：
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"本地通知" message:@"成功添加推送" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
            //此处省略一万行需求。。。。
        }
    }];
    
}

/// 进阶通知
- (void)advanceNotification {
    
    UNNotificationAction *lookAction = [UNNotificationAction actionWithIdentifier:kIdentifier_Notification title:@"接受邀请" options:UNNotificationActionOptionAuthenticationRequired];
    
     UNNotificationAction *joinAction = [UNNotificationAction actionWithIdentifier:kIdentifier_Notification title:@"查看邀请" options:UNNotificationActionOptionForeground];
    
     UNNotificationAction *cancelAction = [UNNotificationAction actionWithIdentifier:kIdentifier_Notification title:@"取消" options:UNNotificationActionOptionDestructive];
    
    UNTextInputNotificationAction *inputAction = [UNTextInputNotificationAction actionWithIdentifier:kIdentifier_Notification title:@"输入" options:UNNotificationActionOptionDestructive textInputButtonTitle:@"发送" textInputPlaceholder:@"tell me loudly"];
    
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:kIdentifier_Notification actions:@[] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    
    
}


@end
